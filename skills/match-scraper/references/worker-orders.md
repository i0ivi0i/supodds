# Worker 工单模板（主会话专用）

> 本文件只供主会话/编排读取。主会话把工单内容**内联**进 `delegate_task` / `invoke_subagent` 的 prompt；**进货 Worker** 不读本文件、不读任何磁盘规范，0 秒执行。**分析师 Worker** 是唯一例外：按模板读取 `MEMORY.md` 与 `skills/deep-analysis/SKILL.md` 两本指定规范，不读其他文档。Worker 的“抓取前零探索、零临时脚本、零盘赔思考”铁律不变；内联工单以 ≤2KB 为压缩目标，但不得删掉分析师必需的上述两项读取。

## 1. 标准进货 Worker（Data Ingest Worker）

```yaml
task:
  goal: "【阶段一专职搬运工官方礼貌进货工单】承包场次：{matchIds}，销售日：{销售日}。你拥有最高执行权限，【零探索铁律】：严禁调用 Get-ChildItem 或 read_file 翻看昨天历史文件摸索格式，严禁执行 curl/openssl/powershell 等终端探测命令，严禁阅读任何磁盘 .md/.py/.git 规范文档（无需翻书，开箱即用）！第 0 秒必须且只能直接调用官方 Scrapling Spider 工具（`skills/match-scraper/scripts/ingest_spider.py`）执行进货。以 `py -3.13 skills/match-scraper/scripts/ingest_spider.py --match-id {matchId} --sales-date {销售日} --home {主队} --away {客队} --output <仓库外临时.jsonl>`（可选 `--proxy` 通道兜底）一次运行完成双轨端点进货（Tier 1 聚合核心秒取 1x2d.js 21家欧指时序+goallottery亚大小初即+odds_jc，Tier 2 补充明细礼貌温和限流 2.0s 并发=1，启用 AutoThrottle 自适应退避）；随后先执行 `mkdir -p data/.build && rm -f data/.build/build.db && py -3.13 -c \"import sqlite3,pathlib; c=sqlite3.connect('data/.build/build.db'); c.executescript(pathlib.Path('data/schema.sql').read_text(encoding='utf-8')); c.close()\"` 建空七表工作库（`data/schema.sql` 只有最终七表；没有 staging、没有第二份 schema、没有 final.db），再执行 `C:/Users/home/AppData/Local/etlx/1.156.1-linking/etlx-windows-linking-amd64.exe -config data/pipeline.md -date {销售日} -file <临时.jsonl>`，由 ETLX 直接读取 JSONL 在 DuckDB 临时表解析并写入 `data/.build/build.db` 的七表；`GATE_FINAL` 通过后复制为活动库 `data/{销售日}/{matchId}.db`（最终七表：`球队基本情况`/`欧指`/`欧指变盘`/`亚盘`/`亚盘变盘`/`大小球`/`大小球变盘`；0 视图；Polymarket 不入分析库），人类简报 `data/{销售日}/{matchId}.md` 仅为可选看板，若生成也不得替代 `.db`；【立即回传】：确认真实落盘且 Schema 完备后立即回传「{matchIds} 进货完成」！【防手搓最高铁律】：绝对禁止编写或生成任何全语种（.py/.ps1/.js/.bat/.sh）临时脚本！绝对禁止在磁盘建立 tmp_* 暂存文件夹或倾倒 .txt 中转文件！绝对禁止思考盘赔逻辑或定性胜负！"
```

## 2. 标准推演分析师 Worker（Chief Match Analyst）

```yaml
task:
  goal: “深度分析 [{联赛}] {主队} vs {客队}（ID: {matchId}）。本批共 N 场，不写入 memory，只回传含 memory 摘要的结构化结果。必须首先读取 MEMORY.md 与 skills/deep-analysis/SKILL.md，严格按该 skill 的 EvoOntology 任务链、看数规则、10 步推演与认知契约卡执行；只读 data/{销售日}/{matchId}.db，严禁读 {matchId}.md、严禁网络抓取、严禁手搓临时脚本。结果与执行证据回传，不自行对外发布；Polymarket 链接由交付工位另行补挂。”
```

## 3. 验收纪律

- Worker 回传不是完成凭证；主会话必须核对落盘文件、`GATE_FINAL`、七表行数与契约卡数量，再写 memory。

## 4. 调度与隔离

- 主会话是唯一 Central Scheduler；Worker 完工回传后再补下一批，不轮询。
- 同一域名单并发；多场按 1–3 场分组串行；组批只做物理调度，不缩减推演总数。
- Hermes 最多 3 个单场子代理并行；子代理不嵌套；主会话负责验收、串行保存与统一汇总。
- Worker 五禁：不 `git` 探测、不想盘赔、不改代码、不写临时脚本、不调用 `execute_code` 做抓取/清洗/对账。
- 进货 Worker 只交付 `data/{销售日}/{matchId}.db` 与证据；Evo 只读入口由主会话在阶段 1 验收后建立，见 `skills/deep-analysis/references/evo-environment.md`。
