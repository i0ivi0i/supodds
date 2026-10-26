# 03 巡检与 Evo 环境

GATE_FOR: 步骤 8.5 / 心跳巡检 / EvoOntology 环境 / 进化
RETURN_TO: 执行步骤 8.5

### 步骤 8.5：官方图谱经验反思归卷（Graphify Reflect & 三 CLI 结果 + 两治理状态）

在完成记忆入账后，自动触发 Graphify 官方自进化反思飞轮，更新知识图谱工作记忆、错题集与置信度半衰期：
1. **沉淀实战记忆（Three CLI Outcomes + Two Governance States）**：
   复盘完成后，通过标准 `graphify save-result` 命令将每场博弈推演与实际对账结果写入工作记忆（`graphify-out/memory/`）。官方 CLI `--outcome` 只有 `{useful, dead_end, corrected}` 三个值；`retired` / `adopted` 是治理状态，不是 CLI 参数：`retired` 映射 `dead_end`，`adopted` 用 `useful` 记录并在 `MEMORY.md` 标记：
   - **`useful`（核心首选命中 · 验证中加权）**：赛前做市商博弈假说与落槌依据被赛果正面印证，强化相关论文节点与战法连接权重：
     `graphify save-result --question "{比赛ID/对阵 核心盘面特征}" --answer "{赛前推导与实际打出首选}" --nodes "{引用的论文或战法节点ID}" --outcome useful --memory-dir graphify-out/memory`
   - **`corrected`（失误反思纠偏 · 归因改进）**：首选未命中或发生重大偏差，启动决策归因审计，指出赛前被忽视的做市陷阱或偏见漏洞：
     `graphify save-result --question "{比赛ID/对阵 核心盘面特征}" --answer "{赛前推导与实际赛果}" --nodes "{引用的论文或战法节点ID}" --outcome corrected --correction "{纠偏发现与战法改进}" --memory-dir graphify-out/memory`
   - **`retired`（治理状态：假设被证伪淘汰；CLI 用 `dead_end`）**：针对步骤 4.6 判定为【已淘汰（证伪废弃）】或 21 天未触发的假设，使用官方 `--outcome dead_end` 标记死胡同，促使 `reflect` 施加半衰期惩罚并降权，同步在 `MEMORY.md` 标记为「已淘汰」：
     `graphify save-result --question "{比赛ID/对阵 假设特征}" --answer "{被证伪事实}" --nodes "{引用的论文或战法节点ID}" --outcome dead_end --memory-dir graphify-out/memory`
   - **`adopted`（治理状态：经验内化转正；CLI 用 `useful` 记录）**：针对满 5 场前瞻验证且支持率 $\ge 70\%$ 的成熟经验，在 `MEMORY.md` 标记为「已采用（内化为本能）」，其在 `graphify reflect` 中凭借多次 `--outcome useful` 的互证强化（`--min-corroboration 2`），正式固化为长期高频 God Node 骨干枢纽。
2. **聚合并反思自进化（Reflect Flywheel）**：
   运行官方反思算子：
   `graphify reflect --memory-dir graphify-out/memory --out graphify-out/reflections/LESSONS.md`
   聚合并自动刷新 `graphify-out/reflections/LESSONS.md` 与 `.graphify_learning.json`，确保推演大脑在次日分析时通过阶段二导览直接获取最新的实战教训与置信度修正。
3. **注入官方诚实证据链标准（Honesty Rules）**：
   所有复盘报告与经验总结中引述的学术论文原句、定理或历史战例，**强制要求带入真实确凿的 `source_location`**（包含具体文件名与段落/页码，如 `source_location: "docs/论文/2022_Constantinou_AH_1X2.pdf#p12"` 或 `source_location: "graphify-out/wiki/5._平博_欧亚双盘核心.md#L15"`），坚决杜绝“幻觉论文”、“口头断言”或凭空编造引用。



## 心跳与主动巡检补漏（Heartbeat & Patrol）

> 本节是系统唯一法定巡检清单（SSOT），直接定义心跳与巡检的完整规则；不依赖任何外部文件。巡检时读取实时北京时间与每日 memory，按实际场次、处理状态、待办和投递回执检查，不以标题存在判完成。补漏抓取独家调度官方 Scrapling Spider/原生流水线礼貌排队直取（单域名单并发），严禁调用外部独立浏览器（如 browseros-neo），严禁编写任何临时脚本。先查同一批次是否有仍在运行的 Cron/子任务，有则不重复启动。永久缺失赛前资料记「已完成但部分指标不可评分」，不伪称完整方法验证，不无限重跑。

### 1. 心跳 vs Cron 使用边界

- **使用心跳时**：多个检查可批量处理（赛前补漏 + 临盘复核 + 赛后补漏在一次轮询中）；需要来自最近消息的对话上下文；时间可略微漂移（每 ~30 分钟一次）。
- **使用 Cron 时**：精确时间很重要（11:10 赛程同步、17:00/21:00 赛前分析合一、10:30 赛后复盘）；任务需从主会话历史中隔离；想使用不同模型或思考级别。
- **保持安静 (HEARTBEAT_OK) 条件**：深夜（23:00-08:00）除非紧急；自上次检查以来无新内容；刚检查过（<30分钟）；已完成且无待办、无投递错误。
- **主动工作边界**：阅读和组织记忆文件；回顾和更新 MEMORY.md；更新文档与对账。

### 2. 三大主动巡检补漏实操清单

#### ① 赛前分析补漏清单

- **触发条件**：当前时间 **$\ge 17:00$（早盘仅补 $\le 22:00$ 场次）或 $\ge 21:00$（晚盘全量补漏）** 且 **未过当日竞彩销售截止**（周一至五 22:00、周六日 23:00）。赛前分析只有一条 Cron（17:00 与 21:00 各响一次）；补漏按开球窗口切场次。
- **状态机流转**：
  - 有 `## 跳过分析` → 跳过；
  - 有 `## 推荐` 或 `## 推荐（时间）` → 先按本地日期、早晚窗口和本批范围定位记录，取最新有效版本。核对本批全部 matchId 是否已处理及发布状态；只续未完成且尚未开球的场次。已存待发布内容只补投递，不重算；开球后禁止补成赛前预测。只有全部处理且无待办才跳过；
  - 有以 `## 赛程抓取` 开头的 section 且无 `## 深度分析` → 先核该 section 场次是否为零：非零则从深度分析步骤续做；零场则核该零场是否成功采集凭证，失败空返回按赛程失败待办恢复，成功核实的当日全量零场方可跳过；
  - 有 `## 深度分析` 但无 `## 推荐` → 从推荐步骤续做；
  - 什么都没有 → 执行赛前全流程；
  - 晚盘巡检同时核尚未开球的早盘待办，只续真实缺项；已开始场次严禁补成赛前预测。

#### ② 临盘决战动态复核补漏清单（开球前 30~45 分钟）

- **触发条件**：针对当日推荐中且尚未开赛的场次，当前时间处于 **开球前 30~45 分钟** 区间；
- **双轨刷新与视网膜看数**：
  - 检查是否有正式首发出炉或终盘剧烈异动的推演场次；
  - 启动临盘复核流水线：独家调度官方 Scrapling Spider/原生流水线礼貌排队直取（单域名单并发）最新微观首发与终盘流水；
  - **严禁只写单一 .md**：必须首先原子覆盖更新底层无损物理存证 `data/{销售日}/{matchId}.db`（最终七表；27 个分析端点回执与哈希留在抓取层 JSONL），再同步重新渲染可选人类可视化简报 `data/{销售日}/{matchId}.md`；
  - **看数必经 EvoOntology**：大模型严禁直接使用 `read_file` 裸视海量原始长文本，必须且只能依托 EvoOntology 官方 MCP 工具（`browse_semantics` ➔ `resolve_ontology_task`）核销 22 家并按 mapping 路径全量提取微观活水数据；
  - 输入原「认知契约卡」与新批次，由大模型通盘复核，驱动状态机输出【维持原判】、【微调修正】或【物理熔断】；
  - 若出现网络抓取失败、字段缺失或时点冲突，置顶报警并记录待办，绝不伪造复核记录。
- **执行分工**：刷新数据走 `skills/match-scraper`；复核推演走 `skills/deep-analysis` 的“方法校准与临盘复核（进入十步前）”；本技能只负责巡检触发、状态机与记录，不另写抓取脚本。

#### ③ 赛后复盘补漏清单

- **触发条件**：**当前时间 $\ge 10:30$**，检查昨日与前 3 天的推荐及复盘，并沿既有待办引用追踪更早延期场次；
- **补漏执行**：
  - 无复盘记录：按 post-review 启动；无推荐则记录无推荐，不增加统计；
  - 有复盘标题但状态不明：核实场次表、未结赛果、入账标识和投递记录一次，不直接视为完成；
  - 仍有待办/执行失败：只恢复可补部分；源站超时按技能重试一次，仍失败记原因和下次检查时点，不在同轮循环；
  - 已完成但部分指标不可评分：保留缺失说明，不反复抓数据伪造旧赛前证据；有新可核证据才重新评估；
  - 报告完成但投递失败/不明：查调度器投递记录，有成功回执则补标，没有则恢复报告投递，不重跑统计；
  - 补完同步销掉原日待办，累计按旧贡献替换新贡献；延期不因超过三天变为取消。

## EvoOntology 环境绑定、重绑与探针（唯一 owner）

> 本节是 EvoOntology 环境的唯一 owner。`match-scraper` 只交付 `.db`；`deep-analysis` 只读使用并停线；不再由主会话或 `deep-analysis` 持有环境细节。

### 1. 唯一入口
- `data/.evo/current.db` 必须是指向当前场次 `data/{销售日}/{matchId}.db` 的 NTFS **硬链接**；不是副本，不是第二个库。
- 每次最终 `.db` 落盘后重建入口；`cp` 会替换 inode，禁止用复制替代。
- 只读查询打开入口指向的当前 `.db`，不得在入口路径写业务数据。

### 2. 赛前触发（阶段 1→2）
- 本场 `.db` 过 `GATE_FINAL` 后，主会话在阶段 1 验收时按本节执行，重建硬链接并跑只读探针；探针未通过，阶段 2 不得开始。
- 分析师在 Task 开始前只做一致性检查：`project.json` 的 `data_source` 与当前 `data/.evo/current.db` 绝对路径相同；不同则停线交本节，不在旧路径推演。

### 3. 重绑步骤
1. 确认 `.db` 已过 `GATE_FINAL`，七表与 0 视图无异常。
2. 删除旧入口并重建硬链接（Windows NTFS）：
   ```bash
   mkdir -p data/.evo
   rm -f data/.evo/current.db
   cmd.exe /c "mklink /H data\\.evo\\current.db data\\{销售日}\\{matchId}.db"
   ```
3. 用官方 `configure_ontology_project(replace=true)` 把 `data_source` 写成当前入口的绝对路径。
4. 以现有问题重建 workload；运行 `validate_semantics`，再执行至少一次真实只读查询探针。
5. 只有 `validate_semantics` 通过且探针返回当前场次数据，才允许分析师进入 EvoOntology Task 链。

### 4. 七表或字段变更
- 七表名与列名不变：重写当前 `.db` 后重建硬链接即可；Evo 下一次只读查询以实际返回为准，若仍读到旧场次，立即重绑并复测。
- 若 `ALTER`/`DROP`/`RENAME` 七表或列名：同步更新 Mapping 与 Evidence，再跑 `validate_semantics` 和真实探针；`validate_semantics` 只校验本体结构，不校验底层列是否存在。

### 5. 运行态提交边界
- 可提交：`active.json`、`versions/*`；`evidence.source` 用逻辑库名，不写绝对路径。
- 不提交：`project.json`、`state.json`、`workload/questions.json`、`tasks/`、`trajectories/`、`reports/`、`visualizations/`、`evolution/`。
- 不把本机绝对路径、任务轨迹或运行态回执写进可提交的本体版本。

## 官方 EvoOntology 活体自进化闭环与防噪音立宪

复盘不是记流水账，而是驱动知识图谱与语义本体自愈自进化的源头活水。必须严格遵循 `ruc-datalab/EvoOntology` 官方四步闭环与防刻舟求剑纪律：

### 1. 官方任务轨迹核对（只读）
赛前分析已通过 `start_ontology_task` ➔ `resolve_ontology_task` / `execute_ontology_query` ➔ `finish_ontology_task` 生成官方轨迹 `.evoontology/trajectories/{task_id}.json`；任务 `batch_id` 固定为 `{销售日}_{matchId}`，复盘按此核对。复盘只读取并核验该轨迹，**绝对禁止用 `write_file` 另写 `task_{销售日}_{matchId}.json` 之类的自定义轨迹，也绝对禁止手工补造工具结果**。若本场没有官方轨迹，如实标注 `[赛前未记录官方轨迹]`，不补造、不冒充。

### 2. 进化门禁唤醒检测（Evolution Due Check）
复盘流程末尾必须调用 `mcp__evo-semantic__evolution_status(workspace=".evoontology")`：
- 若返回 `evolution_due: false`：在复盘报告末尾记录当前累积进度（例如：`新轨迹: 7/30 场，未达进化门禁`）；
- 若返回 `evolution_due: true`：立即在战报中置顶提示主人「🧬 **EvoOntology 累积已达进化门禁（新轨迹≥30场或周期≥7天），建议开启自进化复盘轮次！**」。

### 3. 防刻舟求剑与防死尺子四大禁令（Anti-Noise & Anti-Dead-Ruler Iron Laws）
1. **因果机制优先，严禁硬编码孤立数值**：提炼的 Candidate 必须具备跨联赛、跨机构的做市博弈因果机制（如平博低水测谎、马会哨兵防守、中盘假摔震仓），**绝对禁止将 $2.10 \to 4.00$ 或单一场次的孤立数字硬编码为死尺子！**
2. **偶发不可抗力严禁入本体**：凡因红牌罚下、意外乌龙折射、单方罢赛等突发偶发因素导致的赛果偏差，一律归为不可抗力随机方差，**绝对禁止将此类个案作为规则演化进入本体！**
3. **独立双盲验证池隔离（Validation Reserve）**：所有提出的 Candidate 补丁，必须在独立的 Validation Reserve（30% 保留池）上与 Parent 进行双盲对照测试，严禁拿训练集本身自圆其说；
4. **零负面回归合并门禁（Zero Regression Gate）**：Candidate 在独立验证集上必须同时满足：① 综合博弈识别准确率提升；② **历史已通过的合格战例负面回归率严格为 0%（决不能治好一个新病打翻三个旧病）**！不达标者强制判定为 Reject，宁缺毋滥，保持本体 100% 纯净度！



RETURN_TO: 执行步骤 8.5
