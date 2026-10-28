---
name: match-scraper
description: "马斯克超级工厂工位 1（全权数据进货局）：基于 scrapling-official 的项目适配器，负责球探体育(titan007) 27 个分析端点、22 家做市商核销与七表 SQLite 落盘；出厂交付 data/{销售日}/{matchId}.db。在用户说「抓取赛程」「获取今日比赛」「进货」「拉取推演源数据」或阶段零、阶段一时使用。"
license: Complete terms in LICENSE.txt
metadata:
  homepage: "https://scrapling.readthedocs.io/en/latest/index.html"
  openclaw: "🕷️"
  version: "0.6"
  requires: "python3 (3.13) + pip"
---

# 赛程与推演源数据采集（match-scraper）· 马斯克超级工厂工位 1

> **数据路径（最高优先）**：唯一持久化真相是 `data/{销售日}/{matchId}.db` 的最终七表。本工位用 `ingest_spider.py` 抓取并导出仓库外临时 JSONL；ETLX 直接读取 JSONL，在 DuckDB 临时表中解析，只写七张最终表。没有 staging 物理表、没有视图、没有 ETLX 之后的 Python 清理、没有第二个库。`{matchId}.md` 仅为可选人类看板。
>
> **EvoOntology 边界**：EvoOntology 是下游只读层，不属于本工位。本工位只交付 `.db` 与可选人类简报，不配置、不校验、不进化本体。Evo 入口与重绑归复盘工位，读契约归分析工位。

## 0. 运行控制台

| # | 检查点 | 何时进入 | 必须通过 | 失败怎么办 | 交付什么 |
|---:|---|---|---|---|---|
| 1 | 接单与边界 | 用户给出赛程、场次或编号 | 场次/销售日/主客队齐全；模式已选 | 缺字段就问；不猜 | 一张自包含工单 |
| 2 | 模式一·赛程 Feed | `抓取赛程` / `获取今日比赛` | Feed 解析完成；`meta.md` 与 memory 已落盘 | 置顶报警，保留错误 | 赛程索引 |
| 3 | 模式二·27 端点 | 指定单场或编号 | 26 请求；27 行 JSONL；22 家核销 | 停线；不晋升 | 仓库外 JSONL |
| 4 | ETLX 七表 | JSONL 已过完整性门 | 7 表；0 视图；`GATE_FINAL` 通过 | 保留 `build.db`，不动旧库 | 工作库 |
| 5 | 过验与交接 | ETLX 成功 | 七表行数、哈希、`integrity_check` 通过 | 不交接；回传失败 | 最终 `.db` |

**分支**：`§1` 先选模式。模式一只走 `§2` 后结束；模式二继续 `§3 → §4 → §5`。`§0`、`§6`、`§7`、`§8` 是控制台和附录，不是流水线阶段。

### 0.1 一眼看懂

- **27 个端点** = 4 个核心 + 7 个亚盘 + 7 个大小球 + 7 个欧指 + 2 个全景；`eu_42.html` 占位不发请求，所以实际 **26 个请求**。
- **22 家机构** = 21 个 Euro CID + 188Bet 的 42 槽位（188Bet 没有 Euro CID）；分 5 批核销。**21 个 Euro CID 是名册，不是每次都满额**：核心 4 家（澳彩、皇冠、Bet365、平博）必须有，实到 **≥18/21** 才允许落 `.db`；少 1～3 家只记覆盖警告，不伪造行。
- **7 张最终表**、0 视图、`球队基本情况` 14 列；`GATE_FINAL` 是唯一放行门。
- **可选人看板**分六个栏目；**六道防错门**是广告、表格炸裂、死占位、22 家、初盘、时序；另加行数不截断。所有命令在 **Git Bash** 运行；Windows 绝对路径用引号包住；`py -3.13` 是本机 Python 启动器。

## 1. 接单与边界

### 1.1 输入与模式

- 模式一输入：赛程日期、销售日、竞彩编号或“今天/明天”的赛程请求。
- 模式二输入：`matchId`、销售日、主队、客队；缺一项就停，不用常识补。
- 本工位只负责阶段 0/1 的物理进货，不做阶段 2 的盘赔推演，不定胜负，不写 memory。
- 唯一机器真相：`data/{销售日}/{matchId}.db` 的最终七表。人类简报不是机器输入。

### 1.2 读取门

| 进入 | 读者 | 必须先读 | 回到 |
|---|---|---|---|
| 模式二抓取前 | 主会话 | `references/ingest-contract.md` + `references/data-integrity-gates.md` | Stage 3 |
| 派单前 | 主会话 | `references/worker-orders.md` | Stage 3 |
| ETLX 前 | 主会话 | `ingest-contract.md` 的 ETLX 段；`data/pipeline.md` | Stage 4 |

进货 Worker 只接收主会话内联的工单，**不读任何磁盘规范**；主会话负责读门，Worker 从第 0 秒执行。

### 1.3 硬边界

- 不抓赛程以外的东西，不做赔率分析，不把 `.md` 当推演数据。
- 未开盘只能写 `[官方未开盘]`；没有真实抓取就不写赔率。
- 任何场次失败都停在本场，不用另一场的数据补洞。

## 2. 模式一·赛程 Feed

### 2.1 直取

首选 `scrapling` MCP 的 `make_request`，纯 HTTP、零浏览器：

```json
{
  "url": "https://jc.titan007.com/xml/bf_jc.txt?{timestamp}",
  "extraction_type": "text",
  "impersonate": "safari184_ios",
  "stealthy_headers": true
}
```

`index.aspx` 只是人类浏览入口，没有比赛行，不能当数据源。Feed 只在内存解析，读完即弃；禁止落盘 `bf_jc.txt` 或任何 `.txt` 中转文件。403/反爬盾可升阶到 `fetch` 或 `stealthy_fetch`；仍打不开就置顶报警「🚨 球探赛程 Feed 无法打开，数据通道受阻！」，保留工具错误并停止。

### 2.2 字段

Feed 前段是联赛字典（`#` 分隔）；后段每条记录以 `!` 分隔，字段以 `^` 分隔：

- `[0]` 比赛 ID；`[1]` 开球时间 `Y,M0,D,h,m,s`（**月份 0 基**）；`[3]` 状态；`[4]` 竞彩编号；`[5]` 联赛 ID；`[8]` 主队；`[10]` 客队；`[11–16]` 比分（赛前为空）。
- 按 `周四` 或销售日过滤；跨日记录不得误算进当日；字段缺失如实报错，不猜。

### 2.3 落盘

1. 写 `data/{YYYY-MM-DD}/meta.md` 赛程总览。
2. 追加 `memory/{YYYY-MM-DD}.md` 的 `## 赛程抓取（{HH:MM}）` 段。
3. 完成标准：< 2 秒；一次工具调用完成两份落盘；随后放行到阶段一。

## 3. 模式二·27 端点

### 3.1 主路径

```bash
JSONL="C:/Users/home/AppData/Local/hermes/cache/scratch/match-{matchId}.jsonl"
py -3.13 skills/match-scraper/scripts/ingest_spider.py \
  --match-id {matchId} --sales-date {YYYY-MM-DD} \
  --home {主队} --away {客队} \
  --output "$JSONL" [--force]
```

脚本按 `config/endpoints.json` 发 **26 个请求**（`eu_42.html` 是 188Bet 的无欧指占位，`skip_request=true`，不单发请求），导出 **27 行**分析端点 JSONL；`ah_42.html`、`ou_42.html` 仍按 42 槽位正常抓取。机器契约只有 `config/endpoints.json`；完整键表在 `ingest-contract.md`。

同一输出文件 10 分钟内、且缓存是同一场比赛的完整 27 行时自动跳过（输出 `ok:false` + `cached:true`）；只有主人明确说“重新分析”才加 `--force`。不得用旧盘口补新场。

### 3.2 22 家与空态

法定 22 家、21 个 Euro CID、188Bet 独立槽位、5 批核销、完整 CID 表都在 `ingest-contract.md`。抓取后逐家核销：
- **核心 4 家**（80 澳彩、545 皇冠、281 Bet365、177 平博）缺失 → 失败，整场停线。
- 核心齐、实到 **≥18/21** → 可落 `.db`；缺 1～3 家写入 `warnings`，不伪造行。
- 实到 **<18** → 失败，停线。
- `eu_12.html` 这类次级欧指变盘空壳 → `not_offered` 警告，不单独卡死；主时序以 `1x2d.js` 为准。
官方未开盘项写 `[官方未开盘]`；绝不静默漏报，绝不伪造一行。

### 3.3 防串号与防假成功

- URL 与 `matchId` 显式绑定；返回报文双向核验主队/客队；对阵不符立即丢弃重拉。
- 特征词断言：亚盘 `Crown 亚让/让球`；欧指 `百家做市/返还率`；大小球 `高于/低于`。命中错位即阻断。
- 按 manifest 或页面 meta 声明的编码解码；历史变盘页若声明 `gb2312`/`GB18030`，按 `GB18030`；不得用默认 UTF-8 强解汉字。
- `1x2d.js` 必须含 **核心 4 家**（80/545/281/177）原始行、可反序列化，且实到 **≥18/21**；缺失的 1～3 家写入 `warnings`，不得补假行。`analysis.html` 不得是只有表头的空壳；`odds.html` 必须含 `lineupObj`；`asian_odds.html` / `over_under.html` 必须是有效 JSON。
- 页面 `<tr>` 少于 2 且含动态脚本时，升阶 `browser_fetch(network_idle=true)`；仍空就判失败，不把空壳当成功。
- 403/429：先退避；仍失败就升阶；不得把 WAF 页面写成正常数据。

### 3.4 失败的真实行为

端点失败时，脚本仍写出 27 行 JSONL，`state=failed`，stdout 为 `{"ok":false,"failed":[...]}`，退出码 **0**。这是“采集完成但有失败端点”，不是成功；下游 `GATE_FINAL` 阻断晋升。**只缺 1～3 个非核心欧指 CID 时，`1x2d.js` 保持 `state=ok`，把缺失写入 `warnings`；`eu_12.html` 空壳按 `not_offered` 记警告，不算失败。**

致命异常或 JSONL 导出失败时，退出码 **1**，不写完整 JSONL。两种情况都保留现场；不把失败端点改写为 `[官方未开盘]`。

### 3.5 MCP 降级诊断

只在单端点诊断或 Spider 不可用时使用，不得冒充 27 端点批量装配：

1. `open_request_session`（`impersonate=safari184_ios`）。
2. 同会话 `session_make_request`：脚本/JSON 走 `text`；分析 DOM 走 `html`；历史表走 `markdown` + `#odds2 table`；全景表走 JSON。
3. `close_session` 释放句柄。

选择器和编码由 `config/endpoints.json` 提供；Worker 不手写选择器。

## 4. ETLX 七表

### 4.1 建空库并装配

```bash
set -e
JSONL="C:/Users/home/AppData/Local/hermes/cache/scratch/match-{matchId}.jsonl"
mkdir -p data/.build
rm -f data/.build/build.db
ETLX="C:/Users/home/AppData/Local/etlx/1.156.2-linking/etlx-windows-linking-amd64.exe"
"$ETLX" -config data/pipeline.md -date {销售日} -file "$JSONL"
```

禁止用 `py -3.13 -c` 建库。`data/pipeline.md` 的 7 个 `DDL_*` 步骤先用 `sqlite3:` 建七张 STRICT 最终表，顺序固定：`球队基本情况` → `欧指` → `欧指变盘` → `亚盘` → `亚盘变盘` → `大小球` → `大小球变盘`；`BUILD_FINAL` 再用 DuckDB 装载。没有 `schema.sql`、staging、视图、第二库、ETLX 后的 Python 清理或 VACUUM。

`BUILD_FINAL` 用 DuckDB `CREATE TEMP TABLE` 在内存解析，只执行 7 条 `INSERT INTO DB."<表>"`；临时表随连接销毁，落盘库天然只有七表。没有 staging、没有 `schema_final.sql`、没有第二库、没有 ETLX 后的 Python 清理或 VACUUM。

### 4.2 GATE_FINAL

必须断言：`final_table_total=7`、`final_table_count=7`、`final_view_count=0`、`final_identity_match=1`、`euro_rows>=18`（且核心 4 家 80/545/281/177 必须存在）、`euro_history_rows>0`、`euro_history_sources>=2`、`asian_rows>0`、`asian_history_rows>0`、`ou_rows>0`、`ou_history_rows>0`、`team_info_rows=1+阵容+伤停`、`team_info_types=1`。`team_info_types` 只要求比赛信息 1 行、伤停大于 0；阵容是可选数据，0 行也算通过。`PRAGMA integrity_check` 必须 `ok`。

`球队基本情况` 固定 14 列：`比赛ID`、`数据类型`、`联赛`、`主队`、`客队`、`开球时间`、`竞彩编号`、`销售日`、`队伍`、`身份`、`号码`、`姓名`、`位置`、`伤停原因`。主键为 `比赛ID + 数据类型 + 队伍 + 身份 + 姓名 + 号码`；比赛信息的 `号码` 用空串，阵容/伤停用真实号码。行顺序：比赛信息 → 主队首发 → 客队首发 → 主队替补 → 客队替补 → 主队伤停 → 客队伤停。阵容是可选数据，有就写，没有可缺；伤停仍必须。

官方首发一般在开球前 **60 分钟**（德国杯/德甲；欧战 75 分钟）发布。未发布时 `阵容` 为空，不得用上一场首发、媒体预测阵容或页面“上一场评分”冒充本场首发，也不得因阵容为空阻断 `.db`。

`亚盘`、`大小球` 同一机构同一初盘盘口出现多条记录时，初盘三列取时间最早的一条，最新三列取时间最晚的一条，`更新时间` 取最晚时间；不能整行取最新，否则会把后开的初盘误当成初盘。

### 4.3 晋升

```bash
if [ -f "data/{销售日}/{matchId}.db" ]; then
  cp "data/{销售日}/{matchId}.db" "data/{销售日}/{matchId}.db.previous"
fi
cp data/.build/build.db "data/{销售日}/{matchId}.db"
rm -rf data/.build
```

失败时保留 `data/.build/build.db` 供检查，不动旧最终库。`Error loading .env file` 只有 exit 0 且 SQLite 行数/`integrity_check` 都通过时才算非致命；不能只看 ETLX 退出码。

## 5. 过验与交接

- 模式一交付：`data/{销售日}/meta.md` + `memory/{销售日}.md` 的赛程段。
- 模式二交付：`data/{销售日}/{matchId}.db`（七表、0 视图）；可选 `{matchId}.md` 只能是人看板；仓库外 JSONL 成功晋升后删除。人看板若生成，必须过六个栏目、六道防错门（广告、表格炸裂、死占位、22 家、初盘、时序）和行数不截断；细则见 `ingest-contract.md`。
- 放行：`.db` 新鲜（<30 分钟）、`PRAGMA integrity_check=ok`、`GATE_FINAL=0`、主客队与 `matchId` 一致。
- Worker 只回传文件与证据；不写 memory、不改代码、不思考盘赔。主会话核对落盘、`GATE_FINAL`、七表行数后才写 memory。
- 单场也必须“搬运 → 过验 → 主会话路由”；多场按 1–3 场串行，同一域名单并发。

## 6. 禁令与抗封

- **零临时脚本**：禁止 `.py/.ps1/.js/.bat/.sh` 临时脚本、`python -c`、`tmp_*` 目录、`.txt` 中转、`raw/*.json` 或 `slices/*.json`。唯一生产脚本是 `scripts/ingest_spider.py`。
- **原样入库**：七表只投影源值；禁止 `MIN/MAX/COUNT/SUM/AVG`、概率换算、缺失填充、跨行估算。统计与推演由 AI 读取后现场做，不写回业务表。
- **时序**：初盘是最早记录，最新盘是最后一笔；分析时按 `Sort by Timestamp ASC`；禁止用行号或排版方向代替时间戳。
- **每次重抓**：Adaptive 只记 DOM 骨架，不缓存赔率；每次重新分析必须重新抓；10 分钟完整 JSONL cooldown 只是防重复，不是旧盘口复用。
- **`--ai-targeted`**：`scrapling extract` CLI 必须带，过滤隐藏杂质与广告；本适配器 `ingest_spider.py` 没有该参数，用选择器下推达到同等效果。
- **单并发**：同一域名单并发；基础延迟 1.0–3.0 秒随机抖动；AutoThrottle 自适应；403/429 指数退避 `2→4→8→16` 秒，封顶 15 秒（当前脚本 `autothrottle_max_delay`）。
- **隐身**：`impersonate=safari184_ios`；UA 统一为 iPhone OS 18_4 / Safari 18.4；补 `Referer: https://m.titan007.com/analy/Analysis/{mid}.htm`；默认 HTTP/2，协议错误自动降级 HTTP/1.1（也可用 `--http1` 强制）；代理用 `--proxy` 或 `ALL_PROXY/HTTPS_PROXY/HTTP_PROXY`。
- **防错位**：`parts[0]` 才是 CID，禁用 `parts[1]`；欧指列序主/平/客，亚盘主水/盘口/客水，大小球大水/盘口/小水；`matchId` 跨比赛隔离；`188Bet` 只走 42。
- **不造假**：JSONL 必须来自真实响应；`chars` 与 `sha256/raw_sha256` 必须匹配；未开盘写 `[官方未开盘]`；不伪造伤停、赔率或链接。

## 7. 异常与停线

- Scrapling 四级升阶仍打不开：置顶「🚨 数据抓取通道受阻！」，报告失败并结束；不写残缺 memory，不静默。
- 错位、场次缺失、**22 家核销缺口或核心 4 家缺失**、`GATE_FINAL` 失败：立即停线，保留原始错误与 `build.db`，不动旧最终库。**只缺 1～3 个非核心欧指 CID 时按 `PARTIAL` 继续，不得当成 22 家完整。**
- 赛程 Feed、单场抓取、ETLX、晋升四类失败都不跨场补洞；下一场仍按单场串行。
- **主数据源**：titan007 球探。**阵容伤停双引擎**：FPL `injury-service.js`；Big Balls Sports Data API（`~/.gemini/config/bigballs_token.txt`）。**交叉验证**：Football-Data.org（`~/.gemini/config/football_data_tokens.json`）。
- 赛后完场比分是 `post-review` 的职责；本工位只保留 Feed/单场通道指针，不在这里做复盘评分。

## 8. 参考文件

| 文件 | 何时读 | 读完回到 |
|---|---|---|
| `references/ingest-contract.md` | 模式二抓取前；ETLX 前 | Stage 3 / Stage 4 |
| `references/data-integrity-gates.md` | 模式二抓取前 | Stage 3 |
| `references/worker-orders.md` | 主会话派单前 | Stage 3 |

参考文件只保持一级；不要把参考文件再链接到另一个参考文件。通用 Scrapling 安装、CLI、Docker、Shadow DOM、Spider 模板与迁移手册归 `scrapling-official`，本技能只保留项目适配规则。
