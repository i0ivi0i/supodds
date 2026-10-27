# 数据进货 Worker 工单模板（主会话专用）
> 只供主会话/编排读取；主会话把工单内容**内联**进 `delegate_task` / `invoke_subagent` 的 prompt。**进货 Worker 不读本文件、不读任何磁盘规范**，0 秒执行。内联工单以 ≤2KB 为压缩目标。
## 1. 标准进货 Worker
```yaml
task:
  goal: |
    【阶段一搬运工】承包场次：{matchIds}，销售日：{销售日}。
    【零探索铁律】不调用 read_file/Get-ChildItem 翻历史；不读任何 .md/.py/.git 规范；不运行 curl/openssl/powershell 探测；第 0 秒直接执行下面命令。
    1) 抓取并导出 27 行 JSONL（26 请求；eu_42.html 是 188Bet 无欧指占位，skip_request=true）：
       set -e
       JSONL="C:/Users/home/AppData/Local/hermes/cache/scratch/match-{matchId}.jsonl"
       py -3.13 skills/match-scraper/scripts/ingest_spider.py \
         --match-id {matchId} --sales-date {销售日} \
         --home {主队} --away {客队} \
         --output "$JSONL" [--proxy http://127.0.0.1:10808]
       同域名单并发；基础延迟 1.0–2.0 秒抖动；403/429 指数退避；不手写选择器。
    2) 清空工作库（不手写建表；pipeline 的 7 个 DDL 步骤会建七张 STRICT 表）：
       mkdir -p data/.build && rm -f data/.build/build.db
    3) ETLX 直装（任一步非 0 立即停，不晋升）：
       ETLX="C:/Users/home/AppData/Local/etlx/1.156.2-linking/etlx-windows-linking-amd64.exe"
       "$ETLX" -config data/pipeline.md -date {销售日} -file "$JSONL"
    4) 只有 GATE_FINAL=0、7 表、0 视图、PRAGMA integrity_check=ok 才晋升：
       SQLITE3="C:/Users/home/AppData/Local/sqlite/3.54.1/sqlite3.exe"
       "$SQLITE3" data/.build/build.db "SELECT COUNT(*) FROM sqlite_master WHERE type='table';" | grep -qE '^7\r?$'
       "$SQLITE3" data/.build/build.db "SELECT COUNT(*) FROM sqlite_master WHERE type='view';" | grep -qE '^0\r?$'
       "$SQLITE3" data/.build/build.db "PRAGMA integrity_check;" | grep -qE '^ok\r?$'
       if [ -f "data/{销售日}/{matchId}.db" ]; then
         cp "data/{销售日}/{matchId}.db" "data/{销售日}/{matchId}.db.previous"
       fi
       cp data/.build/build.db "data/{销售日}/{matchId}.db"
       rm -rf data/.build
       成功后删除仓库外 JSONL；{matchId}.md 只是可选看板，不能替代 .db。
    【禁令】不写临时脚本（.py/.ps1/.js/.bat/.sh）、不建 tmp_*、不落 .txt、不做盘赔思考、不定胜负、不改代码、不写 memory、不 git 探测、不调用 execute_code 做抓取/清洗/对账。
    【回传】只回传 matchId、最终 .db 路径、26/27 计数、七表行数、GATE_FINAL 结果和失败项。
```
## 2. 验收纪律
- Worker 回传不是完成凭证；主会话必须核对落盘文件、`GATE_FINAL`、七表行数，再写 memory。
- 主会话是唯一 Central Scheduler；同一域名单并发；多场按 1–3 场分组串行；不轮询。
- Worker 只交付 `data/{销售日}/{matchId}.db` 与证据；Evo 只读入口由 `post-review` 在阶段 1 验收后建立并跑探针。
