# 单场进货契约（27 端点 / 22 家 / JSONL / ETLX）

`GATE_FOR: Stage 3 / Stage 4`
`RETURN_TO: SKILL.md §3 / §4`

Read this before a single-match capture or an ETLX promotion. The machine contract is `config/endpoints.json` for endpoints and `config/datasources.json` for the bookmaker roster; this file explains the project wiring and gives one filled example.

## 1. 27 endpoint keys

26 requests produce 27 analysis rows. `eu_42.html` has `skip_request=true`: it is a placeholder for 188Bet's absent Euro offer, not a network request; its row is filled as `not_offered`.

| # | Key | Tier | URL / mode | Purpose |
|---:|---|---:|---|---|
| 1 | `1x2d.js` | 1 | `https://txt.titan007.com/1x2/{mid}.js` — text | 21 Euro CIDs, initial/latest and history |
| 2 | `analysis.html` | 1 | `https://m.titan007.com/analy/Analysis/{mid}.htm` — full HTML | standings, form, line performance |
| 3 | `odds.html` | 1 | `https://m.titan007.com/analy/Lineup/{mid}.htm` — full HTML | lineups, formations, injuries |
| 4 | `analy.json` | 1 | `https://m.titan007.com/analy/shijian/{mid}.htm` — text/JSON | events, xG, in-match stats |
| 5–11 | `ah_1.html`, `ah_3.html`, `ah_8.html`, `ah_12.html`, `ah_42.html`, `ah_47.html`, `ah_48.html` | 2 | `https://m.titan007.com/AsianDetail/{cid}/{mid}.htm` — HTML | Asian handicap history for 7 houses |
| 12–18 | `ou_1.html`, `ou_3.html`, `ou_8.html`, `ou_12.html`, `ou_42.html`, `ou_47.html`, `ou_48.html` | 2 | `https://m.titan007.com/OuDetail/{cid}/{mid}.htm` — HTML | over/under history for 7 houses |
| 19–25 | `eu_1.html`, `eu_3.html`, `eu_8.html`, `eu_12.html`, `eu_42.html`, `eu_47.html`, `eu_48.html` | 2 | `https://m.titan007.com/CompensateDetail/{cid}/{mid}.htm` — HTML | European odds history; `eu_42.html` is the 188Bet skipped placeholder |
| 26 | `asian_odds.html` | 2 | `https://m.titan007.com/HandicapDataInterface.ashx?scheid={mid}&type=1&oddskind=0` — JSON | Asian initial/latest panorama |
| 27 | `over_under.html` | 2 | `https://m.titan007.com/HandicapDataInterface.ashx?scheid={mid}&type=1&oddskind=1` — JSON | over/under initial/latest panorama |

Decode raw bytes with the encoding declared by the endpoint or the page meta. When a history page declares `gb2312`/`GB18030`, use `GB18030`; never force UTF-8 over Chinese text. `1x2d.js` must contain the legal 21-CID rows; `analysis.html` must not be a header-only shell; `odds.html` must contain `lineupObj`; `asian_odds.html` and `over_under.html` must be valid JSON.

## 2. 22-bookmaker roster

Euro CIDs belong to the 21 Euro slots. Asian and over/under CIDs are the 7 history slots. `188Bet` has no Euro CID; its Euro slot is a skipped placeholder, while its AH/OU cid `42` is captured normally.

| Bookmaker | Euro cid | AH/OU cid |
|---|---:|---:|
| 澳彩 | 80 | 1 |
| 皇冠 | 545 | 3 |
| Bet365 | 281 | 8 |
| 易胜博 | 90 | 12 |
| 平博 | 177 | 47 |
| 香港马会 | 432 | 48 |
| 188Bet | — | 42 |
| 威廉希尔 | 115 | — |
| 立博 | 82 | — |
| 伟德 | 81 | — |
| Interwetten | 104 | — |
| Bwin | 255 | — |
| SNAI | 110 | — |
| 必发 | 2 | — |
| 利记 | 474 | — |
| 沙巴 | 649 | — |
| Marathon | 800 | — |
| Betway | 482 | — |
| Unibet | 386 | — |
| Paddy Power | 826 | — |
| 10Bet | 16 | — |
| 中国体彩 | 1129 | — |

Five reconciliation batches: `澳彩/皇冠/平博/Bet365/易胜博`; `香港马会/188Bet/威廉希尔/立博/伟德`; `Interwetten/Bwin/SNAI/必发/利记`; `沙巴/Marathon/Betway/Unibet/Paddy Power`; `10Bet/中国体彩`.

Missing bookmakers are a capture omission. The only legal empty state is an official no-offering, written as `[官方未开盘]`; never invent a row.

## 3. JSONL row

Each row is one endpoint. `ItemList.to_jsonl()` writes one JSON object per line; the build reads it from outside the repository and deletes it after successful promotion.

```json
{"match_id":"3000504","endpoint_key":"1x2d.js","content_type":"javascript","content":"...","chars":312540,"raw_sha256":"...","sha256":"...","source_url":"https://txt.titan007.com/1x2/3000504.js","fetched_at":"2026-10-25 12:10:00","status":200,"state":"ok","empty_state":null,"extraction_type":"text"}
```

Required fields: `match_id`, `endpoint_key`, `content_type`, `content`, `chars`, `raw_sha256`, `sha256`, `source_url`, `fetched_at`, `status`, `state`, `empty_state`, `extraction_type`. `chars` and both hashes must match the payload. `state` is `ok`, `not_offered`, or `failed`. A short JSONL, a missing key, or a mismatched hash blocks promotion.

## 4. ETLX and seven tables

Build one empty working DB, then let ETLX read the JSONL directly:

```bash
set -e
SQLITE3="C:/Users/home/AppData/Local/sqlite/3.54.1/sqlite3.exe"
JSONL="C:/Users/home/AppData/Local/hermes/cache/scratch/match-{matchId}.jsonl"
mkdir -p data/.build
rm -f data/.build/build.db
"$SQLITE3" data/.build/build.db < data/schema.sql
ETLX="C:/Users/home/AppData/Local/etlx/1.156.1-linking/etlx-windows-linking-amd64.exe"
"$ETLX" -config data/pipeline.md -date {销售日} -file "$JSONL"
```

`data/schema.sql` creates exactly seven STRICT tables, in this order: `球队基本情况`, `欧指`, `欧指变盘`, `亚盘`, `亚盘变盘`, `大小球`, `大小球变盘`. There is no staging table, no view, no second database, and no Python cleanup after ETLX.

`球队基本情况` has 14 fixed columns: `比赛ID`, `数据类型`, `联赛`, `主队`, `客队`, `开球时间`, `竞彩编号`, `销售日`, `队伍`, `身份`, `号码`, `姓名`, `位置`, `伤停原因`. Row order is match info, home starters, away starters, home bench, away bench, home injuries, away injuries.

`GATE_FINAL` asserts: `final_table_total=7`, `final_table_count=7`, `final_view_count=0`, `final_identity_match=1`, `euro_rows=21`, non-empty Euro/Asian/over-under history, `team_info_rows=1 + 阵容 + 伤停`, and `team_info_types=1`. `PRAGMA integrity_check` must return `ok`.

Promote only after the gate:

```bash
if [ -f "data/{销售日}/{matchId}.db" ]; then
  cp "data/{销售日}/{matchId}.db" "data/{销售日}/{matchId}.db.previous"
fi
cp data/.build/build.db "data/{销售日}/{matchId}.db"
rm -rf data/.build
```

A failed build leaves `data/.build/build.db` for inspection and does not touch the old final DB. `Error loading .env file` from ETLX is non-fatal only when exit 0 and the SQLite gates pass; the database check is authoritative.

## 5. Filled happy path

Use `test_request_plan_has_26_urls` and `test_official_item_exporter_writes_27_jsonl_lines` as the offline evidence for the request/row counts. The real archive `data/2026-10-25/3000504.db` supplies the seven-table example; do not invent values.

```text
输入
matchId: 3000504
销售日: 2026-10-25
主队 / 客队: FC东京 / 水户蜀葵
竞彩编号: 周日003
开球时间: 2026-10-25 15:00

动作
JSONL="C:/Users/home/AppData/Local/hermes/cache/scratch/match-3000504.jsonl"
py -3.13 skills/match-scraper/scripts/ingest_spider.py \
  --match-id 3000504 --sales-date 2026-10-25 \
  --home FC东京 --away 水户蜀葵 \
  --output "$JSONL"

结果
请求: 26
JSONL: 27 行，所有 endpoint_key 唯一
ETLX: 7 张表，0 视图，integrity_check=ok
球队基本情况 56 | 欧指 21 | 欧指变盘 345 | 亚盘 22
亚盘变盘 162 | 大小球 24 | 大小球变盘 116
交付: data/2026-10-25/3000504.db
```

The row counts above are read from the named archive and must be re-read before reuse. A count mismatch means the example is stale, not that the gate passed.

## 6. Filled stop-line

An endpoint failure is not a successful capture, even though the script still writes the JSONL and returns 0:

```text
端点 ah_47.html 连续失败
stdout: {"ok": false, "failed": ["ah_47.html"], "items": 27}
JSONL: 27 行，ah_47.html 的 state=failed
exit: 0
最终 .db: 不存在
动作: 保留 JSONL 与错误证据，置顶报警，禁止晋升
```

A fatal exception or JSONL export failure is different:

```text
导出失败
stdout: {"ok": false, "error": "export_failed:..."}
exit: 1
JSONL: 未完成
最终 .db: 不存在
动作: 保留现场，停止本场，不写 memory
```

The downstream `GATE_FINAL` blocks endpoint failures. Do not convert a failed endpoint into `[官方未开盘]`; that label is only for an official no-offering.

## 7. Optional human brief

The `.md` brief is a view, not a source of truth. When generated, it must contain six war zones: lineups/injuries; standings/form; 22-house Euro table; Asian and over/under initial/latest panorama; 21 history tables; Crown correct-score and China Sports Lottery. Keep the source order for history tables and mark an official no-offering as `[官方未开盘]`. The `.db` remains the only machine input.

The brief must pass these human-view gates:

| Gate | Rule |
|---|---|
| Anti-Ad | Zero marketing lines such as `新球会员` or `下载App` |
| Anti-Collapse | Any text line has `<=35` pipe characters; no nested-table explosion |
| Anti-Placeholder | No dead template `近 0 场 主客相同`; use `[历史无交锋记录]` when true |
| Anti-Omission 22 | All 22 bookmakers appear; missing offers show `[官方未开盘]` |
| Initial Odds | Asian and over/under initial tables each have `>=5` rows |
| Anti-Timeline | No `slice(0,10)` or `[:9]+[-1:]`; keep every history row and source order |
| Anti-Truncation | Real row count, normally 350–2000; never shrink to a fake cap |

The last two gates protect the analysis stage: the brief mirrors source order; only the downstream reader sorts by timestamp ascending.

`RETURN_TO: SKILL.md §3 / §4`
