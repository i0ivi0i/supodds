# Data Integrity Gates for Scraped Tables

Use this when a scrape claims success but the extracted table or source list may be incomplete.

## Choose the fetch path

| Page behavior | Use | Why |
| :--- | :--- | :--- |
| Static HTML with data rows | `Fetcher` / `FetcherSession`; `response.css` | Cheap and deterministic |
| Rows appear only after JavaScript | `StealthyFetcher`, `DynamicFetcher`, `AsyncStealthySession`, or MCP `browser_fetch`; `wait_selector` | The HTTP body is only a shell |
| Rows come from an XHR/API | `AsyncStealthySession(record_requests=True)` + `network.search`, or MCP `browser_network_requests` + `browser_network_request` | Capture the real payload instead of guessing URLs |
| Page is a JS view but loads a static data file | `Fetcher` / `FetcherSession` on the file or JSON URL found in `<script src>` | The rendered table is only a view; the source file is cheaper and often contains more history |
| Page loads a JS data file with a global array, not JSON | `browser_evaluate` on the live page (`typeof data`, `Array.isArray(data)`); if absent, fetch the JS and parse it as project code | A stored HTML shell cannot prove whether the live page exposes the global |
| Anti-bot or IP block | Stealth session + clean exit + backoff | A better selector cannot fix a blocked exit |

Before rendering a JS page, inspect the raw HTML's `<script src>` and inline script for a data URL. A page can show a header-only table over HTTP while its data file already holds every row. Prefer the source file/API; use the browser only when no static source exists.

### JS globals and stored-shell false negatives

A page can load a JS file that assigns an array to a global (for example `var game = Array(...)`). The stored HTML may contain only the `<script src>` tag, and a query of the saved payload for `script` can be empty even when the live page exposes the data. Verify by layer:

1. Inspect the live page's `<script src>` and inline scripts; do not infer from a saved HTML shell alone.
2. On the live page, call `browser_evaluate("typeof game")` and `browser_evaluate("Array.isArray(game) ? game.length : null")`.
3. If the global exists, read a bounded slice and assert each record has the expected fields; do not dump the whole array into context.
4. If the global is absent, fetch the JS file and parse it in project code; call that adapter project code, never "Scrapling official".
5. State whether a missing selector came from the stored payload or the live DOM. `selector_empty` on a saved payload is not proof that the live page has no scripts.

## Rendered-table validation recipe

1. Open one persistent browser session for related pages.
2. Fetch the page with `network_idle` and a `wait_selector` that targets a data row, not merely `table`.
3. Request `extraction_type="html"`; do not rely on Markdown alone.
4. Count actual rows and require numeric cells:

```python
rows = response.css("#data-table tr")
data_rows = []
for row in rows:
    cells = row.css("td::text").getall()
    if len(cells) >= 3 and any(any(ch.isdigit() for ch in cell) for cell in cells):
        data_rows.append(cells)
assert data_rows, "table contains no data rows"
```

5. Reject a header-only table even when the selector matches. `text.count("|") >= 4` is not a data check; a header plus separator row already passes it.
6. If the browser renders the table but a static request returns an empty shell, keep only that endpoint on the browser path.

### DOM table is a view, not the dataset

A table can look complete while the page's source array contains more records. Check both layers before accepting the table:

```javascript
const domRows = document.querySelectorAll("#hTable tr").length;
const sourceRows = typeof gameDetail !== "undefined" ? gameDetail.length : null;
({domRows, sourceRows})
```

If `sourceRows` is greater than the number of real DOM data rows, the page is showing a subset (latest page, collapsed history, or lazy render). Do not report the DOM table as full history. Read the global array or the backing API, and apply the project's own bounded slice only for display.

Also inspect the site's renderer when the table looks unusually clean. A common pattern is:

```javascript
var obj = game[i].split("|");
oTable.insertRow(index);
cell.innerHTML = obj[3];
```

That is the site's own parser and formatter. It proves the data is structured, not that the DOM is the source of truth. Use the raw array for completeness and the rendered table only as a cross-check.

### Layout-only "tables" (no `<table>`)

Some responsive pages render a table-like grid with none of the table elements. Do not assume every clean grid is a table.

1. Fetch the raw HTML first. Empty containers plus an inline script or page global are the signal that rows are generated client-side.
2. Check `document.querySelectorAll("table").length`. If it is zero, stop writing `tr`/`td` selectors; find the renderer.
3. Parse the data object or array from the inline script or page global. The rendered cards are a view, not the dataset.
4. Inspect the renderer only to learn the grouping key (for example a row/line index). A coordinate-like field can exist in the data and still be ignored by the current layout; do not infer columns from unused metadata.
5. Treat flex/grid/absolute positioning and background artwork as presentation. Never reconstruct records from pixel positions or visual order when a source object exists.

A quick probe is:

```javascript
({
  tables: document.querySelectorAll("table").length,
  shells: [...document.querySelectorAll("[id]")]
    .filter(e => /lineup|grid|list|content/i.test(e.id) && e.children.length === 0)
    .map(e => e.id)
})
```

If the probe shows `tables: 0` and empty containers, switch from DOM-table parsing to source-object parsing.

### Flattened Markdown streams

Some mobile endpoints return several records concatenated on one Markdown line. A line-based parser then sees one oversized row and may falsely report that the table is empty or has too few rows.
- Scan the text for repeated record shapes (for example status, value, line, value, timestamp), not only for newline-delimited rows.
- Count semantic records; one real record is data, while a header plus separator without a record is still a failure.
- Keep two fixtures: a header-only payload that must fail, and a one-line payload containing at least two records that must pass.

## MCP sequence for a JS-rendered table

1. `browser_open` with one persistent session.
2. `browser_fetch` with `network_idle=true`, `wait_selector=<data-row selector>`, `extraction_type="html"`, `main_content_only=false`.
3. `browser_evaluate` to count rows and inspect table text when the returned HTML is large.
4. `browser_network_requests` to find the XHR; `browser_network_request(part="response_body")` to read the payload.
5. `close_session` when done.

## Named-source completeness

Scrapling does not know a project's source roster. Build the gate in project code:

```python
expected = {"source-a", "source-b", "source-c"}
seen = set()

async def parse(self, response):
    source = response.meta["source"]
    rows = extract_rows(response)
    if not rows:
        raise ValueError(f"empty table for {source}")
    seen.add(source)
    yield {"source": source, "rows": rows}

async def on_close(self):
    if seen != expected:
        raise RuntimeError(f"missing sources: {expected - seen}")
```

- Put identity in `Request(meta=...)` and emit one item per source.
- Validate `response.url`, page title/header, and source name against `meta`.
- Override `is_blocked()` for content-level shells/WAF markers; the default checks status codes only.
- Record request failures in `on_error`; do not silently skip them.
- Use `on_close` set equality; duplicates and missing IDs both fail.

## Empty state versus success

- Empty is valid only when the source explicitly reports no offering.
- Store it as `not_offered` or `empty`, never as `supported`.
- Do not fabricate a placeholder row to satisfy a count gate.

## Offline tests

Use `Selector` on saved HTML so tests do not hit the site:

```python
from scrapling.parser import Selector

page = Selector(saved_html)
assert len(page.css("#data-table tr")) > 2
```

Keep two fixtures: a header-only page that must fail, and a populated page that must pass. This catches the exact false positive that a text-based `|` gate misses.
