-- Physical SQLite schema for one match database.
-- This file owns staging tables and the seven final business tables.
-- Staging tables are temporary: the documented SQLite cleanup drops them after PUBLISH_FINAL and GATE_FINAL.
-- No views, no separate final database, no second schema file.
CREATE TABLE endpoint_payload (
  match_id TEXT NOT NULL,
  endpoint_key TEXT NOT NULL,
  content_type TEXT NOT NULL CHECK (content_type IN ('javascript', 'html', 'json', 'markdown', 'empty')),
  content TEXT NOT NULL,
  chars INTEGER NOT NULL CHECK (chars >= 0),
  raw_sha256 TEXT NOT NULL CHECK (length(raw_sha256) = 64),
  sha256 TEXT NOT NULL CHECK (length(sha256) = 64),
  source_url TEXT NOT NULL,
  fetched_at TEXT NOT NULL,
  status INTEGER NOT NULL,
  state TEXT NOT NULL,
  empty_state TEXT,
  PRIMARY KEY (match_id, endpoint_key)
) STRICT;
CREATE TABLE euro_snapshot (
  match_id TEXT NOT NULL,
  cid INTEGER NOT NULL,
  bookmaker TEXT NOT NULL,
  record_id TEXT NOT NULL,
  initial_home REAL NOT NULL CHECK (initial_home > 1.0),
  initial_draw REAL NOT NULL CHECK (initial_draw > 1.0),
  initial_away REAL NOT NULL CHECK (initial_away > 1.0),
  initial_prob_home REAL NOT NULL,
  initial_prob_draw REAL NOT NULL,
  initial_prob_away REAL NOT NULL,
  initial_return REAL NOT NULL CHECK (initial_return > 0.0 AND initial_return < 200.0),
  latest_home REAL NOT NULL CHECK (latest_home > 1.0),
  latest_draw REAL NOT NULL CHECK (latest_draw > 1.0),
  latest_away REAL NOT NULL CHECK (latest_away > 1.0),
  latest_prob_home REAL NOT NULL,
  latest_prob_draw REAL NOT NULL,
  latest_prob_away REAL NOT NULL,
  latest_return REAL NOT NULL CHECK (latest_return > 0.0 AND latest_return < 200.0),
  source_time TEXT NOT NULL,
  alias TEXT NOT NULL,
  PRIMARY KEY (match_id, cid),
  UNIQUE (match_id, record_id)
) STRICT;
CREATE TABLE euro_history (
  match_id TEXT NOT NULL,
  cid INTEGER NOT NULL,
  record_id TEXT NOT NULL,
  source_index INTEGER NOT NULL CHECK (source_index >= 0),
  ts_local TEXT NOT NULL,
  ts_iso TEXT NOT NULL CHECK (ts_iso GLOB '????-??-?? ??:??'),
  year INTEGER NOT NULL,
  home REAL NOT NULL CHECK (home > 1.0),
  draw REAL NOT NULL CHECK (draw > 1.0),
  away REAL NOT NULL CHECK (away > 1.0),
  kelly_home REAL NOT NULL,
  kelly_draw REAL NOT NULL,
  kelly_away REAL NOT NULL,
  PRIMARY KEY (match_id, cid, ts_iso, home, draw, away),
  FOREIGN KEY (match_id, cid) REFERENCES euro_snapshot(match_id, cid)
) STRICT;
CREATE TABLE asian_odds (
  match_id TEXT NOT NULL,
  company_id INTEGER NOT NULL,
  bookmaker TEXT NOT NULL,
  odds_id INTEGER NOT NULL,
  first_home REAL NOT NULL CHECK (first_home > 0.0),
  first_line REAL CHECK (first_line IS NULL OR first_line BETWEEN -10.0 AND 10.0),
  first_away REAL NOT NULL CHECK (first_away > 0.0),
  home REAL NOT NULL CHECK (home > 0.0),
  line REAL CHECK (line IS NULL OR line BETWEEN -10.0 AND 10.0),
  away REAL NOT NULL CHECK (away > 0.0),
  modify_ts INTEGER NOT NULL CHECK (modify_ts > 0),
  modify_iso TEXT NOT NULL CHECK (modify_iso GLOB '????-??-?? ??:??'),
  PRIMARY KEY (match_id, company_id, odds_id)
) STRICT;
CREATE TABLE over_under (
  match_id TEXT NOT NULL,
  company_id INTEGER NOT NULL,
  bookmaker TEXT NOT NULL,
  odds_id INTEGER NOT NULL,
  first_over REAL NOT NULL CHECK (first_over > 0.0),
  first_line REAL CHECK (first_line IS NULL OR first_line BETWEEN 0.0 AND 20.0),
  first_under REAL NOT NULL CHECK (first_under > 0.0),
  over REAL NOT NULL CHECK (over > 0.0),
  line REAL CHECK (line IS NULL OR line BETWEEN 0.0 AND 20.0),
  under REAL NOT NULL CHECK (under > 0.0),
  modify_ts INTEGER NOT NULL CHECK (modify_ts > 0),
  modify_iso TEXT NOT NULL CHECK (modify_iso GLOB '????-??-?? ??:??'),
  PRIMARY KEY (match_id, company_id, odds_id)
) STRICT;
CREATE TABLE ah_history (
  match_id TEXT NOT NULL,
  endpoint_key TEXT NOT NULL,
  company_id INTEGER NOT NULL,
  source_index INTEGER NOT NULL CHECK (source_index >= 0),
  status TEXT NOT NULL,
  home REAL NOT NULL CHECK (home > 0.0),
  line_text TEXT,
  away REAL NOT NULL CHECK (away > 0.0),
  ts_local TEXT NOT NULL,
  ts_iso TEXT NOT NULL CHECK (ts_iso GLOB '????-??-?? ??:??'),
  PRIMARY KEY (match_id, endpoint_key, source_index)
) STRICT;
CREATE TABLE ou_history (
  match_id TEXT NOT NULL,
  endpoint_key TEXT NOT NULL,
  company_id INTEGER NOT NULL,
  source_index INTEGER NOT NULL CHECK (source_index >= 0),
  status TEXT NOT NULL,
  over REAL NOT NULL CHECK (over > 0.0),
  line_text TEXT,
  under REAL NOT NULL CHECK (under > 0.0),
  ts_local TEXT NOT NULL,
  ts_iso TEXT NOT NULL CHECK (ts_iso GLOB '????-??-?? ??:??'),
  PRIMARY KEY (match_id, endpoint_key, source_index)
) STRICT;
CREATE TABLE eu_detail_history (
  match_id TEXT NOT NULL,
  endpoint_key TEXT NOT NULL,
  company_id INTEGER NOT NULL,
  source_index INTEGER NOT NULL CHECK (source_index >= 0),
  home REAL NOT NULL CHECK (home > 1.0),
  draw REAL NOT NULL CHECK (draw > 1.0),
  away REAL NOT NULL CHECK (away > 1.0),
  return_rate REAL NOT NULL CHECK (return_rate > 0.0 AND return_rate < 200.0),
  kelly_home REAL NOT NULL,
  kelly_draw REAL NOT NULL,
  kelly_away REAL NOT NULL,
  ts_local TEXT NOT NULL,
  ts_iso TEXT NOT NULL CHECK (ts_iso GLOB '????-??-?? ??:??'),
  PRIMARY KEY (match_id, endpoint_key, source_index)
) STRICT;
CREATE TABLE bookmaker_slots (
  match_id TEXT NOT NULL,
  bookmaker TEXT NOT NULL,
  euro_cid INTEGER,
  ah_cid INTEGER,
  ou_cid INTEGER,
  ah_status TEXT NOT NULL CHECK (ah_status IN ('supported', 'not_offered')),
  ou_status TEXT NOT NULL CHECK (ou_status IN ('supported', 'not_offered')),
  eu_status TEXT NOT NULL CHECK (eu_status IN ('supported', 'not_offered')),
  source_label TEXT NOT NULL,
  evidence TEXT NOT NULL,
  PRIMARY KEY (match_id, bookmaker)
) STRICT;
CREATE TABLE injury (
  match_id TEXT NOT NULL,
  side TEXT NOT NULL CHECK (side IN ('home', 'away')),
  source_index INTEGER NOT NULL CHECK (source_index >= 0),
  number TEXT NOT NULL,
  name TEXT NOT NULL,
  player_id TEXT NOT NULL,
  position TEXT NOT NULL,
  injury_reason TEXT NOT NULL,
  captain_type INTEGER NOT NULL,
  player_kind INTEGER NOT NULL,
  source_endpoint TEXT NOT NULL,
  PRIMARY KEY (match_id, side, player_id)
) STRICT;
CREATE TABLE lineup (
  match_id TEXT NOT NULL,
  side TEXT NOT NULL CHECK (side IN ('home', 'away')),
  role TEXT NOT NULL CHECK (role IN ('starter', 'bench')),
  source_index INTEGER NOT NULL CHECK (source_index >= 0),
  number TEXT NOT NULL,
  name TEXT NOT NULL,
  player_id TEXT NOT NULL,
  position TEXT NOT NULL,
  formation TEXT NOT NULL,
  source_endpoint TEXT NOT NULL,
  PRIMARY KEY (match_id, side, role, player_id)
) STRICT;
CREATE TABLE team_stats (
  match_id TEXT NOT NULL,
  section TEXT NOT NULL,
  side TEXT NOT NULL CHECK (side IN ('home', 'away', 'match')),
  item TEXT NOT NULL,
  metric TEXT NOT NULL,
  value REAL,
  text_value TEXT,
  source_index INTEGER NOT NULL CHECK (source_index >= 0),
  source_endpoint TEXT NOT NULL,
  PRIMARY KEY (match_id, section, side, item, metric, source_index)
) STRICT;
CREATE TABLE endpoint_parse_status (
  match_id TEXT NOT NULL,
  endpoint_key TEXT NOT NULL,
  row_count INTEGER NOT NULL CHECK (row_count >= 0),
  status TEXT NOT NULL CHECK (status IN ('ok', 'empty', 'not_offered', 'unparsed')),
  note TEXT,
  PRIMARY KEY (match_id, endpoint_key)
) STRICT;
CREATE TABLE build_manifest (
  build_id TEXT PRIMARY KEY,
  match_id TEXT NOT NULL,
  fetched_at TEXT NOT NULL,
  payload_rows INTEGER NOT NULL CHECK (payload_rows >= 0),
  euro_snapshot_rows INTEGER NOT NULL CHECK (euro_snapshot_rows >= 0),
  euro_history_rows INTEGER NOT NULL CHECK (euro_history_rows >= 0),
  asian_rows INTEGER NOT NULL CHECK (asian_rows >= 0),
  over_under_rows INTEGER NOT NULL CHECK (over_under_rows >= 0),
  slot_rows INTEGER NOT NULL CHECK (slot_rows >= 0),
  ah_history_rows INTEGER NOT NULL CHECK (ah_history_rows >= 0),
  ou_history_rows INTEGER NOT NULL CHECK (ou_history_rows >= 0),
  eu_detail_rows INTEGER NOT NULL CHECK (eu_detail_rows >= 0),
  injury_rows INTEGER NOT NULL CHECK (injury_rows >= 0),
  lineup_rows INTEGER NOT NULL CHECK (lineup_rows >= 0),
  team_stats_rows INTEGER NOT NULL CHECK (team_stats_rows >= 0),
  integrity_check TEXT NOT NULL,
  notes TEXT
) STRICT;
CREATE TABLE match_meta (
  match_id TEXT PRIMARY KEY,
  sales_date TEXT NOT NULL CHECK (sales_date GLOB '????-??-??'),
  match_no TEXT NOT NULL,
  league TEXT NOT NULL,
  home_team TEXT NOT NULL,
  away_team TEXT NOT NULL,
  kickoff_at TEXT NOT NULL CHECK (kickoff_at GLOB '????-??-?? ??:??'),
  source TEXT NOT NULL
) STRICT;

-- Read-only views are generated by data/pipeline.md (VIEWS step).
-- The seven final tables are created here too. PUBLISH_FINAL only writes rows;
-- CLEANUP drops every staging table/view so the match database ends with 7 tables.
CREATE TABLE "球队基本情况" (
  "比赛ID" TEXT NOT NULL,
  "数据类型" TEXT NOT NULL CHECK ("数据类型" IN ('比赛信息', '阵容', '伤停', '技术统计', '数据状态', '机构状态')),
  "联赛" TEXT,
  "主队" TEXT,
  "客队" TEXT,
  "开球时间" TEXT,
  "竞彩编号" TEXT,
  "销售日" TEXT,
  "队伍" TEXT NOT NULL,
  "身份" TEXT NOT NULL,
  "号码" TEXT,
  "姓名" TEXT NOT NULL,
  "球员ID" TEXT,
  "位置" TEXT,
  "队长" INTEGER,
  "球员类型" INTEGER,
  "伤停原因" TEXT,
  "项目" TEXT NOT NULL,
  "指标" TEXT,
  "数值" REAL,
  "文本值" TEXT,
  "机构编号" INTEGER,
  "机构" TEXT,
  "状态" TEXT,
  "数据指纹" TEXT,
  "采集时间" TEXT,
  "源序号" INTEGER NOT NULL,
  "来源端点" TEXT NOT NULL,
  PRIMARY KEY ("比赛ID", "数据类型", "来源端点", "队伍", "身份", "项目", "姓名", "源序号")
) STRICT;

CREATE TABLE "欧指" (
  "比赛ID" TEXT NOT NULL,
  "机构编号" INTEGER NOT NULL,
  "机构" TEXT NOT NULL,
  "机构顺序" INTEGER NOT NULL,
  "初盘主胜" REAL NOT NULL,
  "初盘平局" REAL NOT NULL,
  "初盘客胜" REAL NOT NULL,
  "初盘返还率(%)" REAL NOT NULL,
  "最新主胜" REAL NOT NULL,
  "最新平局" REAL NOT NULL,
  "最新客胜" REAL NOT NULL,
  "最新返还率(%)" REAL NOT NULL,
  "来源端点" TEXT NOT NULL,
  PRIMARY KEY ("比赛ID", "机构编号")
) STRICT;

CREATE TABLE "欧指变盘" (
  "比赛ID" TEXT NOT NULL,
  "机构编号" INTEGER NOT NULL,
  "机构" TEXT NOT NULL,
  "机构顺序" INTEGER NOT NULL,
  "源序号" INTEGER NOT NULL,
  "变盘时间" TEXT NOT NULL,
  "主胜赔率" REAL NOT NULL,
  "平局赔率" REAL NOT NULL,
  "客胜赔率" REAL NOT NULL,
  "凯利主胜" REAL NOT NULL,
  "凯利平局" REAL NOT NULL,
  "凯利客胜" REAL NOT NULL,
  "来源端点" TEXT NOT NULL,
  PRIMARY KEY ("比赛ID", "机构编号", "变盘时间", "主胜赔率", "平局赔率", "客胜赔率", "来源端点", "源序号")
) STRICT;

CREATE TABLE "亚盘" (
  "比赛ID" TEXT NOT NULL,
  "机构编号" INTEGER NOT NULL,
  "机构" TEXT NOT NULL,
  "机构顺序" INTEGER NOT NULL,
  "盘口序号" INTEGER NOT NULL,
  "源序号" INTEGER NOT NULL,
  "初盘主水" REAL NOT NULL,
  "初盘盘口" REAL,
  "初盘客水" REAL NOT NULL,
  "最新主水" REAL NOT NULL,
  "最新盘口" REAL,
  "最新客水" REAL NOT NULL,
  "更新时间" TEXT NOT NULL,
  PRIMARY KEY ("比赛ID", "机构编号", "盘口序号")
) STRICT;

CREATE TABLE "亚盘变盘" (
  "比赛ID" TEXT NOT NULL,
  "机构编号" INTEGER NOT NULL,
  "机构" TEXT NOT NULL,
  "机构顺序" INTEGER NOT NULL,
  "源序号" INTEGER NOT NULL,
  "状态" TEXT NOT NULL,
  "变盘时间" TEXT NOT NULL,
  "主水" REAL NOT NULL,
  "盘口" TEXT,
  "客水" REAL NOT NULL,
  PRIMARY KEY ("比赛ID", "机构编号", "变盘时间", "主水", "盘口", "客水", "源序号")
) STRICT;

CREATE TABLE "大小球" (
  "比赛ID" TEXT NOT NULL,
  "机构编号" INTEGER NOT NULL,
  "机构" TEXT NOT NULL,
  "机构顺序" INTEGER NOT NULL,
  "盘口序号" INTEGER NOT NULL,
  "源序号" INTEGER NOT NULL,
  "初盘大球" REAL NOT NULL,
  "初盘盘口" REAL,
  "初盘小球" REAL NOT NULL,
  "最新大球" REAL NOT NULL,
  "最新盘口" REAL,
  "最新小球" REAL NOT NULL,
  "更新时间" TEXT NOT NULL,
  PRIMARY KEY ("比赛ID", "机构编号", "盘口序号")
) STRICT;

CREATE TABLE "大小球变盘" (
  "比赛ID" TEXT NOT NULL,
  "机构编号" INTEGER NOT NULL,
  "机构" TEXT NOT NULL,
  "机构顺序" INTEGER NOT NULL,
  "源序号" INTEGER NOT NULL,
  "状态" TEXT NOT NULL,
  "变盘时间" TEXT NOT NULL,
  "大球" REAL NOT NULL,
  "盘口" TEXT,
  "小球" REAL NOT NULL,
  PRIMARY KEY ("比赛ID", "机构编号", "变盘时间", "大球", "盘口", "小球", "源序号")
) STRICT;
