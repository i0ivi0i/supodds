<!-- Direct ETLX: one JSONL read, in-memory temp tables, seven final tables. No staging tables, no views, no post-ETLX cleanup. -->
# PIPELINE

```yaml
name: PIPELINE
description: Load one match JSONL directly into the seven final SQLite tables.
runs_as: ELT
active: true
```

## BUILD_FINAL

```yaml
name: BUILD_FINAL
table: "球队基本情况"
load_conn: "duckdb:"
load_before_sql:
  - INSTALL sqlite
  - "ATTACH 'data/.build/build.db' AS DB (TYPE SQLITE)"
  - USE DB
load_sql: build_final_direct
load_after_sql:
  - USE memory
  - DETACH DB
rows_sql: SELECT COUNT(*) AS nrows FROM DB."球队基本情况"
active: true
```

```sql
-- build_final_direct
USE DB;
CREATE TEMP TABLE endpoint_payload AS
SELECT
  match_id,
  endpoint_key,
  content_type,
  coalesce(content, '') AS content,
  coalesce(chars, length(coalesce(content, ''))) AS chars,
  coalesce(raw_sha256, sha256) AS raw_sha256,
  sha256,
  coalesce(source_url, '') AS source_url,
  fetched_at,
  coalesce(status, 0) AS status,
  state,
  empty_state
FROM read_json_auto('{file}')
WHERE endpoint_key <> 'polymarket.json';

CREATE TEMP TABLE match_meta AS
SELECT
  trim(f[2]) AS match_id,
  '{YYYY-MM-DD}' AS sales_date,
  trim(f[1]) AS match_no,
  trim(f[3]) AS league,
  trim(f[4]) AS home_team,
  trim(f[5]) AS away_team,
  trim(f[6]) AS kickoff_at,
  'data/{YYYY-MM-DD}/meta.md' AS source
FROM (
  SELECT string_split(trim(line, '|'), '|') AS f
  FROM (
    SELECT unnest(string_split(content, chr(10))) AS line
    FROM read_text('data/{YYYY-MM-DD}/meta.md')
  ) lines
  WHERE trim(line) LIKE '|%'
) cells
WHERE trim(f[2]) = (SELECT match_id FROM endpoint_payload LIMIT 1);

CREATE TEMP TABLE euro_snapshot AS
WITH raw AS (
  SELECT
    match_id,
    content
  FROM endpoint_payload
  WHERE endpoint_key = '1x2d.js'
),
js AS (
  SELECT
    match_id,
    regexp_extract(content, 'var game=Array\((.*?)\);', 1) AS game_array
  FROM raw
),
game_rows AS (
  SELECT
    match_id,
    unnest(regexp_extract_all(game_array, '"([^"]*)"', 1)) AS row
  FROM js
),
fields AS (
  SELECT
    match_id,
    string_split(row, '|') AS f
  FROM game_rows
),
snapshots AS (
  SELECT
    match_id,
    (f[1])::INTEGER AS cid,
    f[2] AS record_id,
    f[3] AS bookmaker,
    (f[4])::DOUBLE AS initial_home,
    (f[5])::DOUBLE AS initial_draw,
    (f[6])::DOUBLE AS initial_away,
    (f[7])::DOUBLE AS initial_prob_home,
    (f[8])::DOUBLE AS initial_prob_draw,
    (f[9])::DOUBLE AS initial_prob_away,
    (f[10])::DOUBLE AS initial_return,
    (f[11])::DOUBLE AS latest_home,
    (f[12])::DOUBLE AS latest_draw,
    (f[13])::DOUBLE AS latest_away,
    (f[14])::DOUBLE AS latest_prob_home,
    (f[15])::DOUBLE AS latest_prob_draw,
    (f[16])::DOUBLE AS latest_prob_away,
    (f[17])::DOUBLE AS latest_return,
    trim(f[21]) AS source_time,
    f[22] AS alias
  FROM fields
  WHERE (f[1])::INTEGER IN (80, 545, 281, 90, 177, 432, 115, 82, 81, 104, 255, 110, 2, 474, 649, 800, 482, 386, 826, 16, 1129)
)
SELECT
  match_id, cid, bookmaker, record_id,
  initial_home, initial_draw, initial_away,
  initial_prob_home, initial_prob_draw, initial_prob_away, initial_return,
  latest_home, latest_draw, latest_away,
  latest_prob_home, latest_prob_draw, latest_prob_away, latest_return,
  source_time, alias
FROM snapshots;

CREATE TEMP TABLE euro_history AS
WITH raw AS (
  SELECT
    match_id,
    content
  FROM endpoint_payload
  WHERE endpoint_key = '1x2d.js'
),
js AS (
  SELECT
    match_id,
    regexp_extract(content, 'var gameDetail=Array\((.*?)\);', 1) AS detail_array
  FROM raw
),
detail_rows AS (
  SELECT
    match_id,
    unnest(regexp_extract_all(detail_array, '"([^"]*)"', 1)) AS row
  FROM js
),
detail_parts AS (
  SELECT
    match_id,
    string_split(row, '^') AS p
  FROM detail_rows
),
segments AS (
  SELECT
    match_id,
    p[1] AS record_id,
    string_split(p[2], ';') AS segs,
    len(string_split(p[2], ';')) AS n
  FROM detail_parts
  WHERE length(trim(p[2])) > 0
),
segment_rows AS (
  SELECT
    match_id,
    record_id,
    i,
    list_extract(segs, i) AS seg
  FROM segments,
  generate_series(1, n) AS t(i)
  WHERE length(trim(list_extract(segs, i))) > 0
),
fields AS (
  SELECT
    match_id,
    record_id,
    i - 1 AS source_index,
    string_split(seg, '|') AS f
  FROM segment_rows
),
history AS (
  SELECT
    f.match_id,
    s.cid,
    f.record_id,
    f.source_index,
    trim(f.f[4]) AS ts_local,
    (f.f[8] || '-' || trim(f.f[4])) AS ts_iso,
    (f.f[8])::INTEGER AS year,
    (f.f[1])::DOUBLE AS home,
    (f.f[2])::DOUBLE AS draw,
    (f.f[3])::DOUBLE AS away,
    (f.f[5])::DOUBLE AS kelly_home,
    (f.f[6])::DOUBLE AS kelly_draw,
    (f.f[7])::DOUBLE AS kelly_away
  FROM fields f
  JOIN euro_snapshot s
    ON s.match_id = f.match_id
   AND s.record_id = f.record_id
)
SELECT
  match_id, cid, record_id, source_index, ts_local, ts_iso, year,
  home, draw, away, kelly_home, kelly_draw, kelly_away
FROM history;

CREATE TEMP TABLE asian_odds AS
WITH raw AS (
  SELECT
    match_id,
    content
  FROM endpoint_payload
  WHERE endpoint_key = 'asian_odds.html'
),
companies AS (
  SELECT
    match_id,
    unnest(json_extract(json_extract(content, '$.companies'), '$[*]')) AS company
  FROM raw
),
details AS (
  SELECT
    match_id,
    company,
    unnest(json_extract(company, '$.details[*]')) AS detail
  FROM companies
),
parsed AS (
  SELECT
    match_id,
    (company->>'companyId')::INTEGER AS company_id,
    CASE (company->>'companyId')::INTEGER
      WHEN 1 THEN '澳彩'
      WHEN 3 THEN '皇冠'
      WHEN 8 THEN 'Bet365'
      WHEN 12 THEN '易胜博'
      WHEN 42 THEN '188Bet'
      WHEN 47 THEN '平博'
      WHEN 48 THEN '香港马会'
    END AS bookmaker,
    (detail->>'oddsId')::INTEGER AS odds_id,
    (detail->>'firstHomeOdds')::DOUBLE AS first_home,
    (detail->>'firstDrawOdds')::DOUBLE AS first_line,
    (detail->>'firstAwayOdds')::DOUBLE AS first_away,
    (detail->>'homeOdds')::DOUBLE AS home,
    (detail->>'drawOdds')::DOUBLE AS line,
    (detail->>'awayOdds')::DOUBLE AS away,
    (detail->>'modifyTime')::BIGINT AS modify_ts,
    strftime(to_timestamp((detail->>'modifyTime')::BIGINT) AT TIME ZONE 'Asia/Shanghai', '%Y-%m-%d %H:%M') AS modify_iso
  FROM details
  WHERE (company->>'companyId')::INTEGER IN (1, 3, 8, 12, 42, 47, 48)
)
SELECT
  match_id, company_id, bookmaker, odds_id,
  first_home, first_line, first_away, home, line, away,
  modify_ts, modify_iso
FROM parsed;

CREATE TEMP TABLE over_under AS
WITH raw AS (
  SELECT
    match_id,
    content
  FROM endpoint_payload
  WHERE endpoint_key = 'over_under.html'
),
companies AS (
  SELECT
    match_id,
    unnest(json_extract(json_extract(content, '$.companies'), '$[*]')) AS company
  FROM raw
),
details AS (
  SELECT
    match_id,
    company,
    unnest(json_extract(company, '$.details[*]')) AS detail
  FROM companies
),
parsed AS (
  SELECT
    match_id,
    (company->>'companyId')::INTEGER AS company_id,
    CASE (company->>'companyId')::INTEGER
      WHEN 1 THEN '澳彩'
      WHEN 3 THEN '皇冠'
      WHEN 8 THEN 'Bet365'
      WHEN 12 THEN '易胜博'
      WHEN 42 THEN '188Bet'
      WHEN 47 THEN '平博'
      WHEN 48 THEN '香港马会'
    END AS bookmaker,
    (detail->>'oddsId')::INTEGER AS odds_id,
    (detail->>'firstHomeOdds')::DOUBLE AS first_over,
    (detail->>'firstDrawOdds')::DOUBLE AS first_line,
    (detail->>'firstAwayOdds')::DOUBLE AS first_under,
    (detail->>'homeOdds')::DOUBLE AS over,
    (detail->>'drawOdds')::DOUBLE AS line,
    (detail->>'awayOdds')::DOUBLE AS under,
    (detail->>'modifyTime')::BIGINT AS modify_ts,
    strftime(to_timestamp((detail->>'modifyTime')::BIGINT) AT TIME ZONE 'Asia/Shanghai', '%Y-%m-%d %H:%M') AS modify_iso
  FROM details
  WHERE (company->>'companyId')::INTEGER IN (1, 3, 8, 12, 42, 47, 48)
)
SELECT
  match_id, company_id, bookmaker, odds_id,
  first_over, first_line, first_under, over, line, under,
  modify_ts, modify_iso
FROM parsed;

CREATE TEMP TABLE bookmaker_slots AS
WITH payload AS (
  SELECT match_id, endpoint_key, state
  FROM endpoint_payload
),
matches AS (
  SELECT DISTINCT match_id FROM payload
),
roster(bookmaker, euro_cid, ah_cid, ou_cid) AS (
  VALUES
    ('澳彩', 80, 1, 1),
    ('皇冠', 545, 3, 3),
    ('Bet365', 281, 8, 8),
    ('易胜博', 90, 12, 12),
    ('平博', 177, 47, 47),
    ('香港马会', 432, 48, 48),
    ('188Bet', NULL, 42, 42),
    ('威廉希尔', 115, NULL, NULL),
    ('立博', 82, NULL, NULL),
    ('伟德', 81, NULL, NULL),
    ('Interwetten', 104, NULL, NULL),
    ('Bwin', 255, NULL, NULL),
    ('SNAI', 110, NULL, NULL),
    ('必发', 2, NULL, NULL),
    ('利记', 474, NULL, NULL),
    ('沙巴', 649, NULL, NULL),
    ('Marathon', 800, NULL, NULL),
    ('Betway', 482, NULL, NULL),
    ('Unibet', 386, NULL, NULL),
    ('Paddy Power', 826, NULL, NULL),
    ('10Bet', 16, NULL, NULL),
    ('中国体彩', 1129, NULL, NULL)
),
slots AS (
  SELECT
    m.match_id,
    r.bookmaker,
    r.euro_cid,
    r.ah_cid,
    r.ou_cid,
    CASE
      WHEN r.ah_cid IS NULL THEN 'not_offered'
      WHEN EXISTS (
        SELECT 1 FROM payload p
        WHERE p.match_id = m.match_id
          AND p.endpoint_key = 'ah_' || r.ah_cid || '.html'
          AND p.state = 'ok'
      ) THEN 'supported'
      ELSE 'not_offered'
    END AS ah_status,
    CASE
      WHEN r.ou_cid IS NULL THEN 'not_offered'
      WHEN EXISTS (
        SELECT 1 FROM payload p
        WHERE p.match_id = m.match_id
          AND p.endpoint_key = 'ou_' || r.ou_cid || '.html'
          AND p.state = 'ok'
      ) THEN 'supported'
      ELSE 'not_offered'
    END AS ou_status,
    CASE
      WHEN r.euro_cid IS NULL THEN 'not_offered'
      WHEN EXISTS (
        SELECT 1 FROM euro_snapshot e
        WHERE e.match_id = m.match_id
          AND e.cid = r.euro_cid
      ) THEN 'supported'
      ELSE 'not_offered'
    END AS eu_status,
    r.bookmaker AS source_label,
    'euro_cid=' || coalesce(CAST(r.euro_cid AS VARCHAR), 'none')
      || '; ah=' || coalesce(CAST(r.ah_cid AS VARCHAR), 'none')
      || '; ou=' || coalesce(CAST(r.ou_cid AS VARCHAR), 'none')
      AS evidence
  FROM matches m
  CROSS JOIN roster r
)
SELECT
  match_id, bookmaker, euro_cid, ah_cid, ou_cid,
  ah_status, ou_status, eu_status, source_label, evidence
FROM slots;

CREATE TEMP TABLE ah_history AS
WITH endpoints AS (
  SELECT
    match_id,
    endpoint_key,
    content
  FROM endpoint_payload
  WHERE endpoint_key LIKE 'ah_%'
),
matches AS (
  SELECT
    match_id,
    endpoint_key,
    unnest(regexp_extract_all(content, '\|\s*(?:即|早)\s*\|[^|]*\|[^|]*\|[^|]*\|[^|]*\|', 0)) AS record
  FROM endpoints
),
fields AS (
  SELECT
    match_id,
    endpoint_key,
    row_number() OVER (PARTITION BY endpoint_key) - 1 AS source_index,
    string_split(record, '|') AS f
  FROM matches
),
parsed AS (
  SELECT
    match_id,
    endpoint_key,
    CASE endpoint_key
      WHEN 'ah_1.html' THEN 1
      WHEN 'ah_3.html' THEN 3
      WHEN 'ah_8.html' THEN 8
      WHEN 'ah_12.html' THEN 12
      WHEN 'ah_42.html' THEN 42
      WHEN 'ah_47.html' THEN 47
      WHEN 'ah_48.html' THEN 48
    END AS company_id,
    source_index,
    trim(f[2]) AS status,
    (trim(f[3]))::DOUBLE AS home,
    trim(f[4]) AS line_text,
    (trim(f[5]))::DOUBLE AS away,
    trim(f[6]) AS ts_local,
    '2026-' || trim(f[6]) AS ts_iso
  FROM fields
)
SELECT
  match_id, endpoint_key, company_id, source_index, status,
  home, line_text, away, ts_local, ts_iso
FROM parsed;

CREATE TEMP TABLE ou_history AS
WITH endpoints AS (
  SELECT
    match_id,
    endpoint_key,
    content
  FROM endpoint_payload
  WHERE endpoint_key LIKE 'ou_%'
),
matches AS (
  SELECT
    match_id,
    endpoint_key,
    unnest(regexp_extract_all(content, '\|\s*(?:即|早)\s*\|[^|]*\|[^|]*\|[^|]*\|[^|]*\|', 0)) AS record
  FROM endpoints
),
fields AS (
  SELECT
    match_id,
    endpoint_key,
    row_number() OVER (PARTITION BY endpoint_key) - 1 AS source_index,
    string_split(record, '|') AS f
  FROM matches
),
parsed AS (
  SELECT
    match_id,
    endpoint_key,
    CASE endpoint_key
      WHEN 'ou_1.html' THEN 1
      WHEN 'ou_3.html' THEN 3
      WHEN 'ou_8.html' THEN 8
      WHEN 'ou_12.html' THEN 12
      WHEN 'ou_42.html' THEN 42
      WHEN 'ou_47.html' THEN 47
      WHEN 'ou_48.html' THEN 48
    END AS company_id,
    source_index,
    trim(f[2]) AS status,
    (trim(f[3]))::DOUBLE AS over,
    trim(f[4]) AS line_text,
    (trim(f[5]))::DOUBLE AS under,
    trim(f[6]) AS ts_local,
    '2026-' || trim(f[6]) AS ts_iso
  FROM fields
)
SELECT
  match_id, endpoint_key, company_id, source_index, status,
  over, line_text, under, ts_local, ts_iso
FROM parsed;

CREATE TEMP TABLE eu_detail_history AS
WITH endpoints AS (
  SELECT
    match_id,
    endpoint_key,
    content
  FROM endpoint_payload
  WHERE endpoint_key LIKE 'eu_%'
),
matches AS (
  SELECT
    match_id,
    endpoint_key,
    unnest(regexp_extract_all(content, '\|\s*[0-9.]+\s*\|\s*[0-9.]+\s*\|\s*[0-9.]+\s*\|\s*[0-9.]+\s*\|\s*[^|]+\|\s*[0-9]{2}-[0-9]{2}\s+[0-9]{2}:[0-9]{2}\s*\|', 0)) AS record
  FROM endpoints
),
fields AS (
  SELECT
    match_id,
    endpoint_key,
    row_number() OVER (PARTITION BY endpoint_key) - 1 AS source_index,
    string_split(record, '|') AS f
  FROM matches
),
parsed AS (
  SELECT
    match_id,
    endpoint_key,
    CASE endpoint_key
      WHEN 'eu_1.html' THEN 80
      WHEN 'eu_3.html' THEN 545
      WHEN 'eu_8.html' THEN 281
      WHEN 'eu_12.html' THEN 90
      WHEN 'eu_47.html' THEN 177
      WHEN 'eu_48.html' THEN 432
    END AS company_id,
    source_index,
    trim(f[2])::DOUBLE AS home,
    trim(f[3])::DOUBLE AS draw,
    trim(f[4])::DOUBLE AS away,
    trim(f[5])::DOUBLE AS return_rate,
    (regexp_extract_all(trim(f[6]), '[0-9.]+', 0))[1]::DOUBLE AS kelly_home,
    (regexp_extract_all(trim(f[6]), '[0-9.]+', 0))[2]::DOUBLE AS kelly_draw,
    (regexp_extract_all(trim(f[6]), '[0-9.]+', 0))[3]::DOUBLE AS kelly_away,
    trim(f[7]) AS ts_local,
    '2026-' || regexp_replace(trim(f[7]), '\s+', ' ', 'g') AS ts_iso
  FROM fields
  WHERE length(f) >= 8
    AND trim(f[2]) <> ''
)
SELECT
  match_id, endpoint_key, company_id, source_index,
  home, draw, away, return_rate, kelly_home, kelly_draw, kelly_away,
  ts_local, ts_iso
FROM parsed;

CREATE TEMP TABLE injury AS
WITH raw AS (
  SELECT
    match_id,
    content
  FROM endpoint_payload
  WHERE endpoint_key = 'odds.html'
),
lineup_json AS (
  SELECT
    match_id,
    regexp_extract(content, '(?s)var lineupObj\s*=\s*(\{.*?\});', 1) AS lineup
  FROM raw
),
injuries AS (
  SELECT
    match_id,
    'home' AS side,
    unnest(json_extract(lineup, '$.lineup.homeInjury[*]')) AS player
  FROM lineup_json
  UNION ALL
  SELECT
    match_id,
    'away' AS side,
    unnest(json_extract(lineup, '$.lineup.guestInjury[*]')) AS player
  FROM lineup_json
),
parsed AS (
  SELECT
    match_id,
    side,
    row_number() OVER (PARTITION BY side) - 1 AS source_index,
    coalesce(trim(player->>'number', '"'), '') AS number,
    coalesce(trim(player->>'name', '"'), '') AS name,
    coalesce(trim(player->>'Id', '"'), '') AS player_id,
    coalesce(trim(player->>'pos', '"'), '') AS position,
    coalesce(trim(player->>'injuryReson', '"'), '') AS injury_reason,
    coalesce((player->>'captainType')::INTEGER, 0) AS captain_type,
    coalesce((player->>'playerKind')::INTEGER, 0) AS player_kind
  FROM injuries
)
SELECT
  match_id, side, source_index, number, name, player_id,
  position, injury_reason, captain_type, player_kind, 'odds.html' AS source_endpoint
FROM parsed;

CREATE TEMP TABLE lineup AS
WITH raw AS (
  SELECT
    match_id,
    content
  FROM endpoint_payload
  WHERE endpoint_key = 'odds.html'
),
lineup_json AS (
  SELECT
    match_id,
    try_cast(regexp_extract(content, '(?s)var lineupObj\s*=\s*(\{.*?\});', 1) AS JSON) AS lineup
  FROM raw
),
rosters AS (
  SELECT
    match_id,
    'home' AS side,
    'starter' AS role,
    unnest(json_extract(lineup, '$.lineup.homePlayerList[*]')) AS player,
    coalesce(json_extract_string(lineup, '$.lineup.homeFormation'), '') AS formation
  FROM lineup_json
  UNION ALL
  SELECT
    match_id,
    'home' AS side,
    'bench' AS role,
    unnest(json_extract(lineup, '$.lineup.homeBakPlayerList[*]')) AS player,
    coalesce(json_extract_string(lineup, '$.lineup.homeFormation'), '') AS formation
  FROM lineup_json
  UNION ALL
  SELECT
    match_id,
    'away' AS side,
    'starter' AS role,
    unnest(json_extract(lineup, '$.lineup.guestPlayerList[*]')) AS player,
    coalesce(json_extract_string(lineup, '$.lineup.guestFormation'), '') AS formation
  FROM lineup_json
  UNION ALL
  SELECT
    match_id,
    'away' AS side,
    'bench' AS role,
    unnest(json_extract(lineup, '$.lineup.guestBakPlayerList[*]')) AS player,
    coalesce(json_extract_string(lineup, '$.lineup.guestFormation'), '') AS formation
  FROM lineup_json
),
parsed AS (
  SELECT
    match_id,
    side,
    role,
    row_number() OVER (PARTITION BY side, role) - 1 AS source_index,
    coalesce(trim(player->>'number', '"'), '') AS number,
    coalesce(trim(player->>'name', '"'), '') AS name,
    coalesce(trim(player->>'Id', '"'), '') AS player_id,
    coalesce(trim(player->>'pos', '"'), '') AS position,
    formation
  FROM rosters
)
SELECT
  match_id, side, role, source_index, number, name, player_id,
  position, formation, 'odds.html' AS source_endpoint
FROM parsed;

CREATE TEMP TABLE team_stats AS
WITH raw AS (
  SELECT
    content
  FROM endpoint_payload
  WHERE endpoint_key = 'analysis.html'
),
j AS (
  SELECT
    regexp_extract(content, '(?s)var jsonData\s*=\s*(\{.*?\});', 1) AS s
  FROM raw
),
raw_analy AS (
  SELECT
    content
  FROM endpoint_payload
  WHERE endpoint_key = 'analy.json'
),
j_analy AS (
  SELECT
    regexp_extract(content, '(?s)var jsonData\s*=\s*(\{.*?\});', 1) AS s
  FROM raw_analy
),
features AS (
  SELECT
    unnest(json_extract(s, '$.matchFeature.features[*]')) AS feature
  FROM j
),
feature_rows AS (
  SELECT
    'matchFeature' AS section,
    'match' AS side,
    row_number() OVER (PARTITION BY feature->>'title') - 1 AS source_index,
    'matchFeature:' || coalesce(feature->>'title', 'unknown') AS item,
    e.key AS metric,
    try_cast(json_extract_string(feature, '$.' || e.key) AS DOUBLE) AS value,
    CASE
      WHEN try_cast(json_extract_string(feature, '$.' || e.key) AS DOUBLE) IS NULL
      THEN json_extract_string(feature, '$.' || e.key)
    END AS text_value
  FROM features,
  json_each(feature) e
  WHERE e.key <> 'title'
    AND (
      try_cast(feature->>'win' AS DOUBLE) IS NOT NULL
      OR try_cast(feature->>'draw' AS DOUBLE) IS NOT NULL
      OR try_cast(feature->>'loss' AS DOUBLE) IS NOT NULL
    )
),
xg_items AS (
  SELECT
    unnest(json_extract(s, '$.lastXgTechStat.itemList[*]')) AS item
  FROM j_analy
),
xg_sides AS (
  SELECT
    item,
    'home' AS side,
    json_extract(item, '$.home') AS side_obj
  FROM xg_items
  WHERE json_extract(item, '$.home') IS NOT NULL
  UNION ALL
  SELECT
    item,
    'away' AS side,
    json_extract(item, '$.away') AS side_obj
  FROM xg_items
  WHERE json_extract(item, '$.away') IS NOT NULL
),
xg_rows AS (
  SELECT
    'xg' AS section,
    side,
    row_number() OVER (PARTITION BY side) - 1 AS source_index,
    'xg' AS item,
    coalesce(item->>'kind', 'xg') AS metric,
    try_cast(side_obj->>'text' AS DOUBLE) AS value,
    nullif(trim(side_obj->>'text'), '') AS text_value
  FROM xg_sides
),
all_rows AS (
  SELECT * FROM feature_rows
  UNION ALL
  SELECT * FROM xg_rows
)
SELECT
  (SELECT match_id FROM endpoint_payload WHERE endpoint_key = 'analysis.html') AS match_id,
  section, side, item, metric, value, text_value,
  source_index,
  CASE WHEN section = 'xg' THEN 'analy.json' ELSE 'analysis.html' END AS source_endpoint
FROM all_rows
WHERE value IS NOT NULL
   OR nullif(trim(text_value), '') IS NOT NULL;

CREATE TEMP TABLE endpoint_parse_status AS
SELECT
  p.match_id,
  p.endpoint_key,
  CASE
    WHEN p.endpoint_key = '1x2d.js'
      THEN (SELECT COUNT(*) FROM euro_history h WHERE h.match_id = p.match_id)
    WHEN p.endpoint_key = 'analysis.html'
      THEN (SELECT COUNT(*) FROM team_stats t WHERE t.match_id = p.match_id AND t.source_endpoint = 'analysis.html')
    WHEN p.endpoint_key = 'odds.html'
      THEN (SELECT COUNT(*) FROM injury i WHERE i.match_id = p.match_id)
        + (SELECT COUNT(*) FROM lineup l WHERE l.match_id = p.match_id)
    WHEN p.endpoint_key = 'analy.json'
      THEN (SELECT COUNT(*) FROM team_stats t WHERE t.match_id = p.match_id AND t.source_endpoint = 'analy.json')
    WHEN p.endpoint_key LIKE 'ah_%'
      THEN (SELECT COUNT(*) FROM ah_history h WHERE h.match_id = p.match_id AND h.endpoint_key = p.endpoint_key)
    WHEN p.endpoint_key LIKE 'ou_%'
      THEN (SELECT COUNT(*) FROM ou_history h WHERE h.match_id = p.match_id AND h.endpoint_key = p.endpoint_key)
    WHEN p.endpoint_key LIKE 'eu_%'
      THEN (SELECT COUNT(*) FROM eu_detail_history h WHERE h.match_id = p.match_id AND h.endpoint_key = p.endpoint_key)
    WHEN p.endpoint_key = 'asian_odds.html'
      THEN (SELECT COUNT(*) FROM asian_odds a WHERE a.match_id = p.match_id)
    WHEN p.endpoint_key = 'over_under.html'
      THEN (SELECT COUNT(*) FROM over_under o WHERE o.match_id = p.match_id)
    ELSE 0
  END AS row_count,
  CASE
    WHEN p.state = 'failed' THEN 'unparsed'
    WHEN p.state = 'not_offered' THEN 'not_offered'
    WHEN p.endpoint_key = 'analy.json'
      AND (SELECT COUNT(*) FROM team_stats t WHERE t.match_id = p.match_id AND t.source_endpoint = 'analy.json') > 0
      THEN 'ok'
    WHEN p.endpoint_key = 'analy.json' THEN 'empty'
    WHEN p.content_type = 'empty' THEN 'empty'
    ELSE 'ok'
  END AS status,
  CASE
    WHEN p.state = 'not_offered' THEN 'declared empty state'
    WHEN p.state = 'failed' THEN 'classification failed; build gate blocks'
    WHEN p.endpoint_key = 'odds.html'
      AND (SELECT COUNT(*) FROM lineup l WHERE l.match_id = p.match_id) > 0
      THEN 'lineup_published'
    WHEN p.endpoint_key = 'odds.html' THEN 'lineup_not_published'
    WHEN p.endpoint_key = 'analy.json'
      AND (SELECT COUNT(*) FROM team_stats t WHERE t.match_id = p.match_id AND t.source_endpoint = 'analy.json') > 0
      THEN 'xg rows parsed'
    WHEN p.endpoint_key = 'analy.json'
      AND (SELECT
             (COALESCE(json_array_length(json_extract(j, '$.lastXgTechStat.itemList')), 0) > 0)
             OR (json_extract(j, '$.lastXgTechStat') IS NOT NULL
                 AND json_extract(j, '$.lastXgTechStat.itemList') IS NULL)
             FROM (SELECT TRY_CAST(regexp_extract(
                     content, '(?s)var jsonData\s*=\s*(\{.*?\});', 1
                   ) AS JSON) AS j
                   FROM endpoint_payload
                   WHERE endpoint_key = 'analy.json') src)
      THEN 'xg_parse_failed'
    WHEN p.endpoint_key = 'analy.json' THEN 'xg_not_present'
    ELSE 'derived from typed tables'
  END AS note
FROM endpoint_payload p;

-- Write only business facts into the seven final tables in the same working DB.
-- Temporary parse tables disappear with this DuckDB connection; the final SQLite file has seven tables only.
-- Fixed human order: match info -> home starters -> away starters -> home bench -> away bench -> home injuries -> away injuries.
INSERT INTO DB."球队基本情况" (
  "比赛ID", "数据类型", "联赛", "主队", "客队", "开球时间", "竞彩编号", "销售日",
  "队伍", "身份", "号码", "姓名", "位置", "伤停原因"
)
SELECT
  "比赛ID", "数据类型", "联赛", "主队", "客队", "开球时间", "竞彩编号", "销售日",
  "队伍", "身份", "号码", "姓名", "位置", "伤停原因"
FROM (
  SELECT
    m.match_id AS "比赛ID", '比赛信息' AS "数据类型", m.league AS "联赛",
    m.home_team AS "主队", m.away_team AS "客队", m.kickoff_at AS "开球时间",
    m.match_no AS "竞彩编号", m.sales_date AS "销售日",
    '比赛' AS "队伍", '比赛' AS "身份", NULL AS "号码", '' AS "姓名",
    NULL AS "位置", NULL AS "伤停原因", 0 AS "sort_index"
  FROM match_meta m
  UNION ALL
  SELECT
    l.match_id, '阵容', NULL, NULL, NULL, NULL, NULL, NULL,
    CASE l.side WHEN 'home' THEN '主队' WHEN 'away' THEN '客队' ELSE '未知队伍' END,
    CASE l.role WHEN 'starter' THEN '首发' WHEN 'bench' THEN '替补' ELSE '其他身份' END,
    l.number, l.name, l.position, NULL, l.source_index
  FROM lineup l
  UNION ALL
  SELECT
    i.match_id, '伤停', NULL, NULL, NULL, NULL, NULL, NULL,
    CASE i.side WHEN 'home' THEN '主队' WHEN 'away' THEN '客队' ELSE '未知队伍' END,
    '伤停', i.number, i.name, i.position, i.injury_reason, i.source_index
  FROM injury i
) AS team_info
ORDER BY
  CASE "数据类型" WHEN '比赛信息' THEN 0 WHEN '阵容' THEN 1 ELSE 2 END,
  CASE "身份" WHEN '首发' THEN 0 WHEN '替补' THEN 1 ELSE 2 END,
  CASE "队伍" WHEN '主队' THEN 0 WHEN '客队' THEN 1 ELSE 2 END,
  "sort_index";

INSERT INTO DB."欧指" (
  "比赛ID", "机构编号", "机构",
  "初盘主胜", "初盘平局", "初盘客胜", "初盘返还率(%)",
  "最新主胜", "最新平局", "最新客胜", "最新返还率(%)", "来源端点"
)
SELECT
  e.match_id, e.cid,
  CASE e.cid
    WHEN 80 THEN '澳彩' WHEN 545 THEN '皇冠' WHEN 281 THEN 'Bet365'
    WHEN 90 THEN '易胜博' WHEN 177 THEN '平博' WHEN 432 THEN '香港马会'
    WHEN 115 THEN '威廉希尔' WHEN 82 THEN '立博' WHEN 81 THEN '伟德'
    WHEN 104 THEN 'Interwetten' WHEN 255 THEN 'Bwin' WHEN 110 THEN 'SNAI'
    WHEN 2 THEN '必发' WHEN 474 THEN '利记' WHEN 649 THEN '沙巴'
    WHEN 800 THEN '马拉松' WHEN 482 THEN '必威' WHEN 386 THEN '优胜客'
    WHEN 826 THEN 'Paddy Power' WHEN 16 THEN '10Bet' WHEN 1129 THEN '中国体彩'
    ELSE e.bookmaker
  END,
  e.initial_home, e.initial_draw, e.initial_away, e.initial_return,
  e.latest_home, e.latest_draw, e.latest_away, e.latest_return, '1x2d.js'
FROM euro_snapshot e
ORDER BY e.cid;

INSERT INTO DB."欧指变盘" (
  "比赛ID", "机构编号", "机构", "变盘时间",
  "主胜赔率", "平局赔率", "客胜赔率", "凯利主胜", "凯利平局", "凯利客胜", "来源端点"
)
SELECT
  h.match_id, h.cid,
  CASE h.cid
    WHEN 80 THEN '澳彩' WHEN 545 THEN '皇冠' WHEN 281 THEN 'Bet365'
    WHEN 90 THEN '易胜博' WHEN 177 THEN '平博' WHEN 432 THEN '香港马会'
    WHEN 115 THEN '威廉希尔' WHEN 82 THEN '立博' WHEN 81 THEN '伟德'
    WHEN 104 THEN 'Interwetten' WHEN 255 THEN 'Bwin' WHEN 110 THEN 'SNAI'
    WHEN 2 THEN '必发' WHEN 474 THEN '利记' WHEN 649 THEN '沙巴'
    WHEN 800 THEN '马拉松' WHEN 482 THEN '必威' WHEN 386 THEN '优胜客'
    WHEN 826 THEN 'Paddy Power' WHEN 16 THEN '10Bet' WHEN 1129 THEN '中国体彩'
    ELSE CAST(h.cid AS VARCHAR)
  END,
  h.ts_iso, h.home, h.draw, h.away,
  h.kelly_home, h.kelly_draw, h.kelly_away, '1x2d.js'
FROM euro_history h
UNION ALL
SELECT
  d.match_id, d.company_id,
  CASE d.company_id
    WHEN 80 THEN '澳彩' WHEN 545 THEN '皇冠' WHEN 281 THEN 'Bet365'
    WHEN 90 THEN '易胜博' WHEN 177 THEN '平博' WHEN 432 THEN '香港马会'
    WHEN 115 THEN '威廉希尔' WHEN 82 THEN '立博' WHEN 81 THEN '伟德'
    WHEN 104 THEN 'Interwetten' WHEN 255 THEN 'Bwin' WHEN 110 THEN 'SNAI'
    WHEN 2 THEN '必发' WHEN 474 THEN '利记' WHEN 649 THEN '沙巴'
    WHEN 800 THEN '马拉松' WHEN 482 THEN '必威' WHEN 386 THEN '优胜客'
    WHEN 826 THEN 'Paddy Power' WHEN 16 THEN '10Bet' WHEN 1129 THEN '中国体彩'
    ELSE CAST(d.company_id AS VARCHAR)
  END,
  d.ts_iso, d.home, d.draw, d.away,
  d.kelly_home, d.kelly_draw, d.kelly_away, d.endpoint_key
FROM eu_detail_history d
ORDER BY 2, 4 ASC, 11;

INSERT INTO DB."亚盘" (
  "比赛ID", "机构编号", "机构",
  "初盘主水", "初盘盘口", "初盘客水", "最新主水", "最新盘口", "最新客水", "更新时间"
)
SELECT
  a.match_id, a.company_id, a.bookmaker,
  a.first_home, a.first_line, a.first_away, a.home, a.line, a.away, a.modify_iso
FROM asian_odds a
ORDER BY a.company_id, a.first_line;

INSERT INTO DB."亚盘变盘" (
  "比赛ID", "机构编号", "机构", "状态", "变盘时间", "主水", "盘口", "客水"
)
SELECT
  h.match_id, h.company_id,
  CASE h.company_id WHEN 1 THEN '澳彩' WHEN 3 THEN '皇冠' WHEN 8 THEN 'Bet365' WHEN 12 THEN '易胜博' WHEN 42 THEN '188Bet' WHEN 47 THEN '平博' WHEN 48 THEN '香港马会' ELSE CAST(h.company_id AS VARCHAR) END,
  h.status, h.ts_iso, h.home, h.line_text, h.away
FROM ah_history h
ORDER BY 2, 5 ASC;

INSERT INTO DB."大小球" (
  "比赛ID", "机构编号", "机构",
  "初盘大球", "初盘盘口", "初盘小球", "最新大球", "最新盘口", "最新小球", "更新时间"
)
SELECT
  o.match_id, o.company_id, o.bookmaker,
  o.first_over, o.first_line, o.first_under, o."over", o.line, o."under", o.modify_iso
FROM over_under o
ORDER BY o.company_id, o.first_line;

INSERT INTO DB."大小球变盘" (
  "比赛ID", "机构编号", "机构", "状态", "变盘时间", "大球", "盘口", "小球"
)
SELECT
  h.match_id, h.company_id,
  CASE h.company_id WHEN 1 THEN '澳彩' WHEN 3 THEN '皇冠' WHEN 8 THEN 'Bet365' WHEN 12 THEN '易胜博' WHEN 42 THEN '188Bet' WHEN 47 THEN '平博' WHEN 48 THEN '香港马会' ELSE CAST(h.company_id AS VARCHAR) END,
  h.status, h.ts_iso, h."over", h.line_text, h."under"
FROM ou_history h
ORDER BY 2, 5 ASC;
```

# GATE_FINAL

```yaml
name: GATE_FINAL
description: "Data quality gate for the seven final tables."
runs_as: DATA_QUALITY
active: true
```

## FinalSevenTables

```yaml
name: FinalSevenTables
description: "Seven tables, zero views, 27 data status rows, 22 bookmaker status rows."
connection: "duckdb:"
before_sql:
  - INSTALL sqlite
  - "ATTACH 'data/.build/build.db' AS DB (TYPE SQLITE)"
query: gate_final_direct
column: violations
check_only: true
after_sql:
  - USE memory
  - DETACH DB
active: true
```

```sql
-- gate_final_direct
WITH checks(gate, observed, expected) AS (
  SELECT 'final_table_total',
    (SELECT COUNT(*) FROM duckdb_tables() WHERE database_name = 'DB'), 7
  UNION ALL SELECT 'final_table_count',
    (SELECT COUNT(*) FROM duckdb_tables()
      WHERE database_name = 'DB'
        AND table_name IN ('球队基本情况', '欧指', '欧指变盘', '亚盘', '亚盘变盘', '大小球', '大小球变盘')), 7
  UNION ALL SELECT 'final_view_count',
    (SELECT COUNT(*) FROM duckdb_views() WHERE database_name = 'DB'), 0
  UNION ALL SELECT 'final_identity_match',
    CASE
      WHEN (SELECT COUNT(DISTINCT "比赛ID") FROM DB."球队基本情况") = 1
       AND (SELECT COUNT(DISTINCT "比赛ID") FROM DB."欧指") = 1
       AND (SELECT COUNT(DISTINCT "比赛ID") FROM DB."欧指变盘") = 1
       AND (SELECT COUNT(DISTINCT "比赛ID") FROM DB."亚盘") = 1
       AND (SELECT COUNT(DISTINCT "比赛ID") FROM DB."亚盘变盘") = 1
       AND (SELECT COUNT(DISTINCT "比赛ID") FROM DB."大小球") = 1
       AND (SELECT COUNT(DISTINCT "比赛ID") FROM DB."大小球变盘") = 1
      THEN 1 ELSE 0
    END, 1
  UNION ALL SELECT 'euro_rows', (SELECT COUNT(*) FROM DB."欧指"), 21
  UNION ALL SELECT 'euro_history_rows',
    CASE WHEN (SELECT COUNT(*) FROM DB."欧指变盘") > 0 THEN 1 ELSE 0 END, 1
  UNION ALL SELECT 'euro_history_sources',
    CASE WHEN (SELECT COUNT(DISTINCT "来源端点") FROM DB."欧指变盘") >= 2 THEN 1 ELSE 0 END, 1
  UNION ALL SELECT 'asian_rows',
    CASE WHEN (SELECT COUNT(*) FROM DB."亚盘") > 0 THEN 1 ELSE 0 END, 1
  UNION ALL SELECT 'asian_history_rows',
    CASE WHEN (SELECT COUNT(*) FROM DB."亚盘变盘") > 0 THEN 1 ELSE 0 END, 1
  UNION ALL SELECT 'ou_rows',
    CASE WHEN (SELECT COUNT(*) FROM DB."大小球") > 0 THEN 1 ELSE 0 END, 1
  UNION ALL SELECT 'ou_history_rows',
    CASE WHEN (SELECT COUNT(*) FROM DB."大小球变盘") > 0 THEN 1 ELSE 0 END, 1
  UNION ALL SELECT 'team_info_rows',
    CASE
      WHEN (SELECT COUNT(*) FROM DB."球队基本情况") =
           1
           + (SELECT COUNT(*) FROM DB."球队基本情况" WHERE "数据类型" = '阵容')
           + (SELECT COUNT(*) FROM DB."球队基本情况" WHERE "数据类型" = '伤停')
      THEN 1 ELSE 0
    END, 1
  UNION ALL SELECT 'team_info_types',
    CASE
      WHEN (SELECT COUNT(*) FROM DB."球队基本情况" WHERE "数据类型" = '比赛信息') = 1
       AND (SELECT COUNT(*) FROM DB."球队基本情况" WHERE "数据类型" = '阵容') > 0
       AND (SELECT COUNT(*) FROM DB."球队基本情况" WHERE "数据类型" = '伤停') > 0
      THEN 1 ELSE 0
    END, 1
)
SELECT COALESCE(SUM(CASE WHEN observed = expected THEN 0 ELSE 1 END), 0) AS violations FROM checks;
```
