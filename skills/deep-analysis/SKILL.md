---
name: deep-analysis
description: "深度分析技能：通过 EvoOntology 只读看数，按 10 步完成胜平负、让球与大小球推演，写【图谱认知基因】与【四维认知契约卡】，输出 announce 交接。用于「深度分析」「分析这场比赛」「详细看看」或赛程索引与进货之后。不抓取、不落库、不写 memory、不排版交付表。"
metadata: { "emoji": "📊" }
---
# 深度分析（deep-analysis）

## 运行指挥台

| 状态 | 下一步 | 过门条件 | 失败动作 |
|---|---|---|---|
| 接单 | 核对工单并停在开球前 | 工单完整、比赛未开球、身份一致 | 已开赛、身份不符或工单残缺 → 停线 |
| 看数 | 建 Evo Task，5 批核销 22 家，读七表 | 七表可见、22 家无 Gap/Block、时序成立 | 看不见、核销不完整或时序断裂 → 停线 |
| 推演 | 按固定 10 步走完，三端都写证据 | 10 步齐全，三端为何出/为何不出写清 | 证据不足或时序矛盾 → 回看数补证；仍不足 → 停线 |
| 落槌 | 过落槌五问，定首选/次选 | 三端裁决成立，首选≠次选，点概率合法 | 五问答不清或证据打架 → 停线，不交付 |
| 交接 | 写两张卡，装 `announce` 两段 | 字段齐全，无人类报告/原始盘口表 | 字段缺失或夹带展示表 → 停线，回落槌修正 |

**唯一停线总则**：任何硬门失败 → 停线；Graphify/论文不可用只降级并记录；不得用常识补赔率。停线只回到上一工位或主会话，不跨阶段硬推。

**阅读顺序**：先本页状态，再当前工位四格，再按读取门读当前 reference；不跳读。

```text
接单: 核对 work_order + 开球时间 + 主客队
看数: start_ontology_task(question_id="q_match_read_active", version="active", batch_id="{销售日}_{matchId}")
      -> browse_semantics(workspace=".evoontology", query="做市商 平博 澳彩")
      -> 5x resolve_ontology_task(task_id, mentions=[...])  # 每批 <=5
      -> execute_ontology_query(task_id, query, event_id)
      -> finish_ontology_task(task_id, final_answer=..., status="completed")
推演: devig_oo_epc(home_odds=..., draw_odds=..., away_odds=...)
      # 泊松暂停：不调用 poisson_dixon_coles
交接: comprehensive_assessment -> memory_summary
```

**禁止**：跳读、无回执继续、旧快照补洞、人类简报当输入、夹带展示表。

**参考文件与读取门**

| 进入 | 必读 | 回执 | 回到 |
|---|---|---|---|
| 工位 2：看数 | `references/01-看数与物理基准.md` | `REF01_LOADED` | 工位 2 |
| 第 1~3 步（若工位 2 未读） | `references/01-看数与物理基准.md` | `REF01_LOADED` | `3.0` 索引第 1~3 步 |
| 第 4~6 步：欧指/亚盘/大小球 | `references/02-三盘定价.md` | `REF02_LOADED` | `3.0` 索引第 4~6 步 |
| 第 7~10 步：裁决与风险 | `references/03-裁决与交接.md` | `REF03_LOADED` | `3.0` 索引第 7~10 步 |
| 工位 5：交接 | 若 `REF03_LOADED` 不在日志，补读 `03` | `REF03_LOADED` | 工位 5 |

`第 N 步` 只指十步推演；`步骤 1` 只指看数入口。**四维卡**是交接卡格式，**三维落槌**是胜平负裁决，两者不是两套结论。执行段细节在 references，主文件只列 10 步索引。

**未读即停线**：缺少 `loaded_ref` / `return_to` 回执，视为没读；不许用“我知道大概”代替。每个 reference 只服务一个阶段，读完回主文件对应门。

**术语（先定义再执行）**

- **22 家**：21 欧指 + 188Bet 亚盘。
- **核销**：Evo Task 内分 5 批调用 `resolve_ontology_task`；`skipped ≡ []` 且 22 家 `supported` 才算完整。
- **欧指覆盖分级（硬规则）**：实到 **21/21 = FULL**；**18–20/21 且核心 4 家齐 = PARTIAL**（必须列缺项、降信心，信心不得高于「中」，不得当串关核心，不得写成 FULL）；**<18 或核心 4 家缺一 = BLOCKED**（停线）。**18 是数据准入线，不是分析标准；本技能仍按 22 家名册核销，不得把 18 当完整。**
- **托盘**：工位间交接包；托盘 2 = `work_order`，托盘 3 = `announce` 两段。
- **OO-EPC**：`sports-math` 的 `devig_oo_epc` 去水概率；是市场映射，不是最终预测。
- **三端**：胜、平、负都写“为何出/为何不出”；平局必须写客胜更弱的当场证据。

**边界**：本技能只做看数、推演、写卡、交接。它不抓取、不落库、不改 Evo 环境、不写 memory、不排版交付表。数据只经 EvoOntology 官方工具；Graphify 只查三个固定触点；论文只在冲突时触发。数据抓取与七表 schema 归 `match-scraper`；Evo 环境、重绑与进化归 `post-review`；交付排版、链接与组合归 `recommendation`；memory 落盘归主会话。

## 工位 1：接单

**做什么**：核对工单、开球时间、比赛身份；只接收未开赛的合法工单。

**过门条件**：工单字段齐全，比赛未开球，主客队与开球时间核对一致。

**失败动作**：已开赛、身份不符、工单字段残缺 → 停线，交回主会话；不进入看数。

**产出**：接单结论与三问答案；不合格工单退回主会话。

### 接单门（三问）

接单时逐条回答三问：

1. **七表事实是否到手**：`欧指`、`欧指变盘`、`亚盘`、`亚盘变盘`、`大小球`、`大小球变盘`、`球队基本情况` 是否在 Evo 中可见？
2. **Evo/Graphify 是否可用**：Evo Task 能否建立，Graphify 能否查询？
3. **数据边界与停线**：七表之外的公开数据按设计跳过，不补、不编；Evo 不可见、22 家不完整、时序不成立、约束冲突或证据不足 → 停线。Graphify 或论文不可用只降级。

**输入边界**：只接收标准单场工单；不直接读原始 SQLite，不读人类简报，不抓取。可见数据只有七表（欧指、欧指变盘、亚盘、亚盘变盘、大小球、大小球变盘、球队基本情况：比赛信息/阵容/伤停）；七表之外的公开数据按设计不采集，不补、不编造，直接跳过。

### 工单

`主会话` 下发标准单场工单；本技能只接收未开赛的合法工单，不做二次路由：

`work_order` 必含字段：`matchId`、`league`、`kickoffTime`、`homeTeam`、`awayTeam`、`analysisUrl`、`lotteryNumber`、`status`、`ingestSpec`、`zeroExplorationRule`、`evoontologyRetina`、`contextSummary`、`method_notes`（`adopted_methods` / `active_hypotheses` / `league_profile`）、`prior_contract_card`。示例值不写入主文件；字段一个不少。

**标准零件托盘 2 原样接收**：`主会话` 的 `work_orders` 全字段保留；本技能消费 `matchId`、`league`、`kickoffTime`、`homeTeam`、`awayTeam`、`analysisUrl`、`contextSummary`、`method_notes`、`prior_contract_card`，其余字段（编号、状态、进货规格、零探索、Evo 预检标记）不改写、不丢弃。

### 分析员工单（本技能 owner）

主会话派单时只传 `work_order` 与本技能路径；分析师先读主文件，再按读取门读当前阶段 reference，未读即停线。`method_notes` 与 `prior_contract_card` 由主会话内联；不读 `MEMORY.md`、不读 `{matchId}.md`、不抓取、不写临时脚本、不写 memory。只回传 `announce` 两段，不对外发布；交付链接归 `recommendation`。

- **开球拦截**：若当前时间不早于开球时间，立即停止，标为已开赛跳过。
- **方法校准**：只使用 `method_notes`；缺失时按本技能内置规则继续，不读长期记忆文件，不读旧分析。
- **临盘复核**：工单带 `prior_contract_card` 时，按卡内反证阈值对照最新盘面；缺失时标注「无前序卡，按首次分析」。
- **数据来源**：只通过 EvoOntology 读取本场七表；不读原始 SQLite，不读 `{matchId}.md`，不抓取。

### 历史复演的输入边界（先于方法校准与推演）

- 区分实时赛前分析、未见答案的历史盲测、已知答案的历史复演；已知答案不得因换子代理就改称盲测，形成改进假设的案例不用于证明该改进有效。
- 只用模拟截至之前或当时已存在且严格早于开球的资料；记录执行时间、模拟截至、开球时间与每条资料的报价/发布时点及来源，注明时区；不把后来报价填入较早对齐行。
- 数据整理与预测上下文隔离；看到本场比分、半场或点球结果即记录污染位置，标为已知答案复演；仍可核查赛前解释，但不计入盲测有效性。

## 工位 2：看数

**做什么**：建 Evo Task，分 5 批核销 22 家，读本场七表并核对比赛身份、时序与约束。**必须另跑一条覆盖计数**：`SELECT COUNT(*) AS n, group_concat(机构编号) FROM 欧指`；`n=21` 才是 FULL，`18–20` 是 PARTIAL，`<18` 是 BLOCKED。不得用“22 家 supported”代替这条计数。

**过门条件**：Evo Task 已建立，七表可见，22 家 `coverage_status` 完整，**欧指覆盖计数已完成并落盘在回执**，时间轴成立。FULL/PARTIAL 可继续；BLOCKED 停线。

**失败动作**：七表不可见、22 家核销缺口、**欧指覆盖 BLOCKED**、Task 轨迹缺失、读侧身份不一致或时序断裂 → 停线，退回 `match-scraper`/`post-review`；Graphify/论文不可用只降级并记录。

**产出**：Evo Task 轨迹、七表核验结果、22 家 coverage、**欧指覆盖（FULL/PARTIAL + 实到/21 + 缺项）**、时间轴与知识触点记录。

**进入门**：先读 `references/01-看数与物理基准.md`；未读即停线。回执 `REF01_LOADED`；读完回本工位。

## 工位 3：推演

**做什么**：先用 `method_notes` 做方法校准，再按固定 10 步推演；三个固定知识触点按 `01` 的 `3.0.2` 查询；最后写三端证据与两张卡。

**过门条件**：10 步齐全，三端证据都写清，三个固定触点已按 `01` 的 `3.0.2` 查询。

**失败动作**：证据不足、三端写不清或时序矛盾 → 回看数工位补证；仍不足 → 停线。Graphify/论文不可用只降级并记录；阵容未核实 → 标「伤停未核实」，继续十步，禁止写成全主力。

**产出**：10 步分析证据、三维落槌草稿、两张卡草稿。

### 方法校准与临盘复核（进入十步前）

在看数入口完成后执行。**本段不是十步内第 2 步；第 2 步是伤停。**

1. **方法校准（只读工单）**：读取 `work_order.method_notes.adopted_methods`、`active_hypotheses` 与 `league_profile`。有则记录其对证据取舍的具体影响；为空则按本技能内置规则继续，不读长期记忆文件，不读旧分析。
2. **临盘复核（只读前序卡）**：工单带 `prior_contract_card` 时，提取卡内可推翻反证条件，对照看数入口的最新盘面逐条检验；触发条件则降信心、改写首选或标为观望。工单无前序卡时标注「无前序卡，按首次分析」。
3. **短时防误触**：同一场 10 分钟内重复分析，由主会话决定是否复看；本技能不读 memory，不自行改写前序结论。
4. **使用方式**：`method_notes` 与前序卡只作辅助校准与风险提炼，绝不替代看数入口的当场七表事实与 10 步推演。

### 3.0 十步总览（固定顺序）

每场比赛按以下 10 步依次分析，完整执行分析过程，输出单场推演结构化结果与【四维认知契约卡】（交付表由 `recommendation` 负责；主人明确要求查看过程时才展开单场分析过程）。

**统一顺序**：1 基本面 → 2 伤停 → 3 泊松（暂停，固定写“不做泊松”） → 4 欧指 → 5 亚盘 → 6 大小球 → 7 合理性 → 8 变动 → 9 关键点/疑点/矛盾 → 10 风险 → 交接 1 综合评估与推荐。十步均须保留；综合评估是十步后的输出，不另占一步。编号口径见上。

| 步骤 | 本步动作 | 产出 | 停线 |
|---|---|---|---|
| 第 1 步 基本面 | 核对身份、战意与可见事实；不补战绩 | 背景、战意、可见事实 | 身份不符或证据不足 |
| 第 2 步 伤停 | 读阵容/伤停；未披露标“未核实” | 缺阵名单与影响 | 伤停未核实只标注，不停线 |
| 第 3 步 泊松 | **暂停使用**：固定写“不做泊松（用户决策：容易被庄家反向利用）”；不算、不补、不猜 | 不输出 λ/比分概率；不调用 `poisson_dixon_coles` | 不停线 |
| 第 4 步 欧指 | 取初盘→变盘→最新；`devig_oo_epc`；查 RLM/诱买 | 初盘/变盘/最新与去水概率 | 时序断裂或欧指 BLOCKED；PARTIAL 必须列缺项并降信心 |
| 第 5 步 亚盘 | 定盘口类型；看盘口+水位；7 家交叉 | 盘口类型、水位、阻诱 | 盘口数据缺失 |
| 第 6 步 大小球 | 定盘口类型；看大/小水位；与欧亚交叉 | 盘口类型、水位、进球空间 | 大小球不可见 |
| 第 7 步 合理性 | 列三盘两两矛盾；让球防守优先 | 三盘矛盾与价值 | 矛盾无法解释 → 观望/停线 |
| 第 8 步 变动 | 判谁先动、是否同步、三线一致/错位 | 跨盘时序综合 | 时序矛盾 |
| 第 9 步 关键点 | 先写三端证据，再落槌；首选≠次选 | 三端证据与首选 | 三端写不清 → 停线 |
| 第 10 步 风险 | 列风险与反证；答落槌五问 | 风险清单与反证条件 | 五问答不清 → 停线 |

## 工位 4：落槌

**做什么**：用第 9 步三维落槌与第 10 步末尾落槌五问做最后校验；不重造卡片。

**过门条件**：第 9 步三维落槌成立，第 10 步风险清单完成，落槌五问能逐条回答。

**失败动作**：三端证据不成立或五问答不清 → 停线，不进入交接。

**产出**：最终首选/次选/观望结论与五问答案；不通过则停线。

**落槌五问**：看到什么 / 可能看错什么 / 哪端更弱 / 矛盾与不确定 / 敢不敢停；完整问法见 `references/03-裁决与交接.md`。

## 工位 5：交接

**做什么**：把两张卡定稿，装入 `announce` 两段；只做结构化交接，不做交付排版。

**过门条件**：两张卡定稿，`announce` 两段字段齐全，概率合法。

**交接物**：标准零件托盘 3（`announce` 两段）。

**失败动作**：`announce` 字段缺失，或夹带人类报告/原始盘口展示表 → 停线，回落槌工位修正。

**产出**：可被 `recommendation` 直接消费的 `announce.comprehensive_assessment` 与 `announce.memory_summary`；交接完成标志成立。

**`announce.comprehensive_assessment` 字段名**：推荐方向（胜平负首选/次选、让球、大小球）、泊松状态（暂停，固定未算）、OO-EPC 去水概率、**数据覆盖（FULL/PARTIAL + 实到/21 + 缺项）**、形态标记、认知留存、关键点/疑点/矛盾、信心度、风险。

**`announce.memory_summary` 字段名**：

- `card_version`
- `identity`：matchId、league、homeTeam、awayTeam、kickoffTime、analysisTime
- `data_ref`：db_path、db_sha256、odds_cutoff、devig、**coverage（FULL/PARTIAL + 实到/21 + 缺项）**、research
- `decision`：context、primary、secondary、three_dimensions、probabilities、confidence
- `context`：injury_verification、motivation、not_collected
- `three_dimensions`：winner、margin、total_goals
- `probabilities`：home、draw、away、source
- `mechanism`：graph_genes、contract_card、poisson
- `contract_card`：selection_and_exclusion、key_decision、bookmaker_hypothesis、competing_explanation、net_payout_logic、evo_block、derivation_chain、key_points、doubts、contradictions、risks
- `poisson`：status、reason、lambda、top6（暂停时 status=未算，lambda/top6 留空）
- `lambda`：home、away（暂停时均 null）
- `falsifiers`：id、statement、metric、trigger、deadline、source
- `premortem`：failed_because

**进入门**：完整 `announce` 写法与 YAML 只在 `references/03-裁决与交接.md`；`REF03_LOADED` 不在日志则先补读。字段缺失或夹带展示表 → 停线。

**交接完成标志**：两段都完整；首选、次选、点概率、信心度、风险与两张卡都在；`recommendation` 不需要猜字段。
