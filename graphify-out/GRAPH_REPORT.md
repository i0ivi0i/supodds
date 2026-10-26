# Graph Report - 倍率分析推演  (2026-10-26)

## Corpus Check
- 94 files · ~385,111 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2222 nodes · 4416 edges · 191 communities (171 shown, 20 thin omitted)
- Extraction: 56% EXTRACTED · 44% INFERRED · 0% AMBIGUOUS · INFERRED: 1927 edges (avg confidence: 0.93)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `9acf5eb6`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- 累计战绩
- Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)
- assess_payload
- 四维认知契约卡（Aiyer/Wheatcroft/Giacomini/Choe学术防线）
- 晚盘深度分析（22:30 CST）
- Graphify 官方体系全景集成手册与实操排错指南 (Official Integration Guide)
- 泊松分布λ攻防建模与波胆比分矩阵
- 深度分析
- 极小化最大损失
- 庄家净赔付最小化（Minimax第一性原理）
- 条件预测能力与滚动样本外检验
- 深度分析
- 深度分析
- 各场景的 Subagent 用法
- 知情交易与尖锐资金
- IngestSpider
- 足球倍率全周期真实变盘时序形态学手册
- Forecast Evaluation for Data Scientists: Common Pitfalls and Best Practices
- 深度分析
- 场次认知契约卡与核心做市推导链
- 比分建模与投注手册（泊松版）
- OO-EPC去水模型（Shin/Power/Probit合成）
- ingest_spider.py
- 赔率分析推演十大公理与四大物理不变量
- load_contract
- Egidi, Pauli & Torelli (2018) 结合历史进球数据与庄家隐含赔率的层次贝叶斯泊松模型
- 赛后复盘先审过程再揭比分与Graphify自愈闭环
- 全市场共识与定价锚点
- 纠偏规则（corrected）：平手盘主队高水不得单凭伤停直接定性为诱主而一票否决主胜，需双向核实高水阻筹属性
- 步骤 1：EvoOntology 看数与核验（全量字段接入、导航与硬核验）
- Wheatcroft (2019) 足球比赛概率预测评分规则评估：批判RPS并确立对数无知评分(IGN)
- IngestSpiderTest
- 盘口与走势阅读手册（简版）
- 赔率与泊松比较：何时值得下注（案例详解）
- ContractDataTest
- 盘赔分析系统化框架（2026-03-17 整理 · 主人亲授）
- 2026-10-22 记忆日志
- Market Efficiency and Behavioral Biases: Evidence from an Online Betting Exchange
- 双变量泊松与相依性修正
- Data Integrity Gates for Scraped Tables
- 欧指1X2热门-冷门偏差（FLB：低概率十分位亏损17% vs 高概率仅亏2%，简单去水严重高估冷门）
- 盘赔分析系统化框架（2026-03-17 整理 · 主人亲授）
- 03 裁决与交接
- PipelineContractTest
- SchemaContractTest
- 模型扩展与组合手册（除泊松之外）
- Choe & Ramdas (2023) 跨时间与博弈论视角下的序贯预测者比较 (Operations Research)
- 盘口分类体系（主人亲授 · 2026-03-18）
- 论文库实战映射总纲 (paper-application-v2)
- 结果偏见与过程审计分离
- Giacomini & White (2006) 条件预测能力检验 (Tests of Conditional Predictive Ability, Econometrica)
- 2026-10-20 每日记忆
- 十步深度分析推演闭环 (基本面/伤停/泊松/欧亚大小时序/合理性/三维落槌)
- 赛后复盘
- 下注决策手册（版本 1）
- 两赛季滚动样本外保序回归校准（Isotonic Regression f:[0,1]->[0.05,0.95] 阶梯单调映射与重归一化）
- json
- Beating the bookies with their own numbers - and how the online sports betting market is rigged
- 赛后复盘
- 单场进货契约（27 端点 / 22 家 / JSONL / ETLX）
- FinalSchemaContractTest
- 通用足球庄家倍率精算 AI 智能体体系 (Pansuan Engine)
- Page 22: Figure 1. Bookmakers prediction power.
- Page 30: Supplementary Figure 1.
- 二、全周期真实变盘时序窗口解析 (Verbatim Raw Wire)
- Page 08: 3 Data Description
- 真实攻防压制力（滚动xG/射正/角球）结合Spike-and-Slab动态先验对泊松强度 lambda 的修正机制
- 联赛配置手册（泊松 + 盘口）
- Page 21: References
- Page 28: Table 1: Literature on the Efficiency of Sports Betting Markets
- Page 15: 第 15 页
- 3.2 三盘定价（第 4~6 步）
- 盘路母型：整球设障御敌防小胜型（让一球中低水设障+泊松共振锁1球小胜）
- 三、盘口与走势过滤危险热门
- 三、四大经典微观做市形态库
- Q: 2026-10-14 欧冠与英冠晚盘复盘：曼城、科莫、博德闪耀实战推演认知修正
- 泊松概率计算手册（足彩用）
- Q: 欧冠杯科莫vs曼联退平手挂超高水诱买做市博弈破译
- Q: 欧冠杯葡萄牙体育体彩关闭HAD仅开让球盘大冷
- Q: 欧罗巴杯格拉茨风暴vs马赛商业庄主胜大跌平博未跟
- 步骤 1.5：校验【推演源数据】赔率与数据完整性 (物理卡死硬门禁与真实性防伪)
- 异常处理
- Stable Reliability Diagrams Using CORP and Isotonic Recalibration
- 预测与复盘论文（本项目）
- 第二部分：模式二·单场【推演源数据】采集与门禁质检（阶段一专属搬运工）
- Q: 2026-10-12 10场全量赛后复盘：四维认知契约卡对账与做市破译验真
- 数据进货 Worker 工单模板（主会话专用）
- AGENTS.md - 足彩分析工作流操作手册
- 盘路母型：豪门客战中盘跳档诱多型（Head-Fake假摔）
- 2026-10-25 记忆日志
- 执行流程
- 深度分析（deep-analysis）
- AGENTS.md 足彩分析工作流操作手册
- 赛前分析推演（{HH:MM} 全量/精选推演）
- 无额外进球预感定理：扣除累积xG差与红牌后，庄家赔率与散户注额在进球前均无异常预测力
- 步骤 3：10 步分析过程（固定顺序）
- 倍率分析推演 (Pansuan Engine) Strategy
- 球队风格判定手册（简版）
- 杯赛防守脆断与进球肥尾
- 贝叶斯动态离散时间加权
- 一、工作流程总览
- 深度分析推送通知模板
- 极速单动执行规约（Scrapling MCP 官方极速通道）
- Aiyer et al. (2023) 结果偏见与决策评价预注册复制与扩展研究 (N=692)
- {联赛} {主队} vs {客队}（编号: {编号} 比赛ID: {matchId}，开球: {开球时间}，分析: {YYYY-MM-DD HH:mm}）
- Beating the bookies with their own numbers - and how the online sports betting market is rigged
- Forecasting Football Match Outcomes: Evidence from the 1X2 and Asian Handicap Betting Markets
- 盘路母型：均势浅盘底线低平赔型（初盘平赔<2.90+即时抬升分流两头）
- 003 场完整分析案例（2026-03-18 反思）
- 深度分析
- 2784765 场（意甲 拉齐奥 1-0 AC 米兰）复盘总结
- Page 09: Data Description (continued)
- Page 25: Figures 1 and 2: Average realized returns
- Page 26: Figures 3 and 4: Bettor distributions
- Page 23: 第 23 页
- Page 29: 第 29 页
- Page 09: Table 1: Description of the 22 football leagues included in the dataset
- Page 23: Figure 5: Average Payouts By Probability Deciles For Asian Handicap Bets
- 纠偏规则（corrected）：升水不等于不出、降水不等于必出，超高水禁作一票否决去水大项的死尺子
- Page 01: Market Efficiency and Behavioral Biases in the Sports Betting Market
- Page 02: 1 Introduction
- Page 03: Introduction (continued)
- Page 04: Introduction (continued)
- Page 05: 2 Literature Review
- Page 06: Literature Review (continued)
- Page 07: Literature Review (continued)
- Page 10: 4 Empirical Tests of Favorite-Longshot Bias
- Page 11: Aggregate-level Analysis (continued)
- Page 12: Aggregate-level Analysis (continued)
- Page 13: Aggregate-level Analysis (continued)
- Page 16: Individual-level Analysis (continued)
- Page 17: 5 Empirical Tests of Home Bias
- Page 18: Home Bias (continued)
- Page 19: 6 Conclusion
- Page 20: Conclusion (continued)
- Page 22: References (continued)
- Page 23: References (continued)
- Page 27: Figure 5: Wagers on home-area-team matches
- Page 31: Table 5: Objective versus Implied Win Probabilities – Two-way
- Page 33: Table 7: Actual versus Implies Probability
- Page 04: 第 04 页
- Page 05: Methods
- Page 06: 第 06 页
- Page 07: 第 07 页
- Page 08: 第 08 页
- Page 09: 第 09 页
- Page 10: Strategy implementation
- Page 11: Strategy Outcome
- Page 12: 第 12 页
- Page 17: Discussion
- Page 18: 第 18 页
- Page 19: 第 19 页
- Page 21: Figures and Tables
- Page 26: References
- Page 27: 第 27 页
- Page 01: Forecasting Soccer Matches With Betting Odds: A Tale of Two Markets
- Page 02: Forecasting Soccer Matches With Betting Odds: A Tale of Two Markets
- Page 03: 1. Introduction
- Page 04: 第 04 页
- Page 06: 2.2. How Asian Handicap Betting Works
- Page 08: 第 08 页
- Page 11: 第 11 页
- Page 13: 3.3. Implications of Favourite-Longshot Bias
- Page 14: 3.4. Ex Ante versus Ex Post Outcomes
- Page 16: Figure 4: Actual Ex Post Loss Rates on an Equally-Weighted Portfolio of Home, Away & Draw Bets Sorted By Ex Ante Expected Loss Rate
- Page 18: Asian Handicap Ends in .25
- Page 19: Asian Handicap Ends in 0.75
- Page 20: 4.2. Evidence on Predictability of Refunds
- Page 21: Table 4: WLS Regression Predicting Refunds
- Page 22: 4.3. Favourite-Longshot Bias?
- Page 24: Table 5: WLS Regression for Payouts for Asian Handicap Bets on Probability Decile Dummies
- Page 25: 4.4. Accuracy of Probability Estimates
- Page 26: Figure 6: Actual Fraction of Full Wins on Asian Handicap Bets Sorted by Estimated Probability of a Full Win
- Page 29: Figure 7: Losses Rates on an Equally-Weighted Portfolio of Home and Away Asian Handicap Bets By Ex Ante Expected Loss Rate
- Page 30: 5. Conclusions
- Page 31: References
- 变动历史分析示例（大小球，必须像这样写）
- 四、Memory 写入规则
- 快速调用命令
- Page 11: 798 H. Hewamalage et al.
- Page 27: Section 4: Base Errors & Scale Invariant Formulations
- Page 09: 796 H. Hewamalage et al.
- Page 16: Forecast evaluation for... 803
- Page 17: 804 H. Hewamalage et al.
- Page 19: 806 H. Hewamalage et al.
- Page 29: Table 8: Error Measure Definitions (Scale-Dependent & Percentage)
- Page 35: Table 9: Checklist for Selecting Error Measures
- 核对记录.md

## God Nodes (most connected - your core abstractions)
1. `Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)` - 634 edges
2. `庄家净赔付最小化（Minimax第一性原理）` - 328 edges
3. `知情交易与尖锐资金` - 191 edges
4. `全市场共识与定价锚点` - 179 edges
5. `四维认知契约卡（Aiyer/Wheatcroft/Giacomini/Choe学术防线）` - 162 edges
6. `泊松分布λ攻防建模与波胆比分矩阵` - 110 edges
7. `赔率分析推演十大公理与四大物理不变量` - 51 edges
8. `条件预测能力与滚动样本外检验` - 51 edges
9. `极小化最大损失` - 51 edges
10. `散户偏见与非对称收割` - 51 edges

## Surprising Connections (you probably didn't know these)
- `庄家净赔付最小化（Minimax第一性原理）` --semantically_synonymous_庄家_机构_精算师--> `PDF原件：2017_Kaunitz_用庄家赔率寻找足球错价_arXiv_v2.pdf`  [INFERRED]
  skills/deep-analysis/SKILL.md → docs/论文/2017_Kaunitz_用庄家赔率寻找足球错价_arXiv_v2.pdf
- `庄家净赔付最小化（Minimax第一性原理）` --semantically_synonymous_庄家_机构_精算师--> `PDF原件：2403.16282_足球博彩演进_机器学习预测与庄家赔率估算.pdf`  [INFERRED]
  skills/deep-analysis/SKILL.md → docs/论文/2403.16282_足球博彩演进_机器学习预测与庄家赔率估算.pdf
- `OO-EPC去水模型（Shin/Power/Probit合成）` --semantically_similar_to--> `两赛季滚动样本外保序回归校准（Isotonic Regression f:[0,1]->[0.05,0.95] 阶梯单调映射与重归一化）`  [INFERRED] [semantically similar]
  skills/deep-analysis/SKILL.md → docs/论文/2026_Wilkens_德甲预测与滚动验证.calibrated.md
- `庄家净赔付最小化（Minimax第一性原理）` --semantically_synonymous_庄家_机构_精算师--> `PDF原件：1802.08848_结合历史数据与庄家赔率预测足球比分.pdf`  [INFERRED]
  skills/deep-analysis/SKILL.md → docs/论文/1802.08848_结合历史数据与庄家赔率预测足球比分.pdf
- `比分预测统计` --semantically_synonymous_大小球_进球数_OU--> `Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)`  [INFERRED]
  MEMORY.md → docs/论文/2022_Constantinou_亚洲让球与胜平负市场效率_arXiv_v2.calibrated.md

## Import Cycles
- None detected.

## Communities (191 total, 20 thin omitted)

### Community 0 - "累计战绩"
Cohesion: 0.11
Nodes (19): 8 维度清单（每次分析必须逐项填写）, MEMORY.md - 长期记忆, 串关统计, 为什么必须完整？, 关键教训, 各玩法命中率, 各联赛命中率, ⚠️ 基本面分析强制规则（2026-03-18 主人强调） (+11 more)

### Community 1 - "Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)"
Cohesion: 0.04
Nodes (70): 数据源与全网API矩阵手册, Football-Data.org与The Odds API海外储备验真矩阵, 英超FPL与Big Balls五大联赛伤停辅源双引擎, 中国体彩官方网关（getMatchCalculatorV1）场次代号与休市核对, 球探网（titan007）主源盘口时序与阵容伤停基准, 3.1 长期大小球盘, 3.2 让球盘表现, 5.1 大小球方向 (+62 more)

### Community 2 - "assess_payload"
Cohesion: 0.12
Nodes (12): Project wiring (football scraper), assess_payload(), _duplicate_rows(), EuroHistoryPoint, extract_euro_cids(), _js_array_body(), _mobile_stream_rows(), parse_euro_history() (+4 more)

### Community 3 - "四维认知契约卡（Aiyer/Wheatcroft/Giacomini/Choe学术防线）"
Cohesion: 0.05
Nodes (64): 四维认知契约卡（Aiyer/Wheatcroft/Giacomini/Choe学术防线）, Answer, Outcome, Q: 复盘如何与九篇论文打通且不把每句话变成门禁, Source Nodes, Answer, Outcome, Q: 2026-10-11 全量25场赛后复盘与认知契约卡对账 (+56 more)

### Community 4 - "晚盘深度分析（22:30 CST）"
Cohesion: 0.06
Nodes (30): 1. 架构升级与系统演进, 2026-10-21 记忆日志, 📊 全量 13 场真实赛果对账审计总表, 周三001 FC东京 vs 柏太阳神（matchId: 3000494）, 周三002 川崎前锋 vs 神户胜利船（matchId: 3000495）, 周三003 RB大宫松鼠 vs 富山胜利（matchId: 3000127）, 周三004 科莫 vs 曼联（matchId: 3073171）, 周三005 里尔 vs 加拉塔萨雷（matchId: 3073188） (+22 more)

### Community 5 - "Graphify 官方体系全景集成手册与实操排错指南 (Official Integration Guide)"
Cohesion: 0.08
Nodes (25): 1.1 认知外脑核心定位, 1.2 零伪命令行绝对铁律 (Zero Pseudo-CLI Invariant), 1. 战前初诊：广度扫描 (BFS), 2. 客观因果：深度溯源 (DFS), 3. 理论冲突与背离裁决：最短路径 (shortest_path), 4.1 三大战区主动调兵矩阵, 4.2 脱靶自愈操作规程 (Missed-Target Self-Healing), 4. 脱靶自愈：调取骨干枢纽 (god_nodes) (+17 more)

### Community 6 - "泊松分布λ攻防建模与波胆比分矩阵"
Cohesion: 0.10
Nodes (35): 泊松分布λ攻防建模与波胆比分矩阵, 2.1 用泊松算出基础概率, 2.2 欧指平均：胜平负 EV, 2.3 欧指平均：大小球 EV（可选）, 二、价值扫描（泊松 + 欧指平均）, 1.1 双泊松模型（Bivariate Poisson）, 1.2 Dixon–Coles 修正, 一、在进球 / 比分层面增强泊松 (+27 more)

### Community 7 - "深度分析"
Cohesion: 0.08
Nodes (25): 2026-10-18 每日记忆, 关键技术认知固化（Scrapling 官方指纹库与 Polymarket 官方规范）, 【周日006】奥萨苏纳 vs 桑坦德 (西甲), 【周日007】天狼星 vs 埃夫斯堡 (瑞典超), 【周日008】库奥皮奥 vs 瓦萨 (芬超冠), 【周日009】萨普斯堡 vs 罗森博格 (挪超), 【周日017】洛里昂 vs 摩纳哥 (法甲), 【周日018】诺丁汉 vs 阿森纳 (英超) (+17 more)

### Community 8 - "极小化最大损失"
Cohesion: 0.11
Nodes (52): NBER WORKING PAPER SERIES, Page 01: NBER WORKING PAPER SERIES, Page 02: How Do Markets Function? An Empirical Analysis of, Page 03: There are many parallels between trading in financial markets and sports wagerin, Page 04: of bettors whose skills allow them to achieve positive expected profits could pr, Page 05: probability that a bet placed on either side of a wager is a winner). Although t, Page 06: allows me to determine whether the bookmaker appears to be equalizing the amount, Page 07: are able to set odds such that favorites and home teams win less than fifty perc (+44 more)

### Community 9 - "庄家净赔付最小化（Minimax第一性原理）"
Cohesion: 0.08
Nodes (43): 0. AI 大模型推演主权与严禁代码僭越铁律, 1. 庄家运作的底层逻辑（庄家第一性原理）, 2. 站在庄家视角精准预测「胜平负」的核心方法, 三、技能流程指引, 核心心法：足球庄家精算视角与净赔付最小化破译（第一性原理）, 庄家净赔付最小化（Minimax第一性原理）, 1. 大模型心算的系统性弊端, 1. 工具路径与调用时机 (+35 more)

### Community 10 - "条件预测能力与滚动样本外检验"
Cohesion: 0.08
Nodes (49): 3.2.1. Alternative hypothesis, 3.2. One-Step Conditional Predictive Ability Test, 3.3. Multistep Conditional Predictive Ability Test, 3.4. Multistep Unconditional Predictive Ability Test, 5.1. Size Properties, Page 01: Econometrica, Vol. 74, No. 6 (November, 2006), 1545–1578, Page 02: 1546 R. GIACOMINI AND H. WHITE, Page 03: TESTS OF PREDICTIVE ABILITY 1547 (+41 more)

### Community 11 - "深度分析"
Cohesion: 0.08
Nodes (24): 2026-10-15 每日记忆, 优质 2 串 1 组合方案, 【周四001】里昂 vs 水晶宫 (欧罗巴杯), 【周四002】杜连斯 vs 桑德兰 (欧罗巴杯), 【周四003】波兹南莱赫 vs 勒沃库森 (欧罗巴杯), 【周四004】圣吉罗斯 vs 皇家社会 (欧罗巴杯), 【周四005】萨尔茨堡 vs AC米兰 (欧罗巴杯), 【周四006】克拉约瓦大学 vs 赫塔菲 (欧协联) (+16 more)

### Community 12 - "深度分析"
Cohesion: 0.08
Nodes (23): 2026-10-16 每日记忆, 【周五001】悉尼FC vs 西悉尼流浪者 (澳超), 【周五002】科特布斯 vs 纽伦堡 (德乙), 【周五003】布洛马波卡纳 vs 尤尔加登 (瑞典超), 【周五004】海伦芬 vs SBV精英 (荷甲), 【周五005】邓伯什 vs 奥斯 (荷乙), 【周五006】法兰克福 vs 科隆 (德甲), 【周五007】弗洛西诺尼 vs 萨索洛 (意甲) (+15 more)

### Community 13 - "各场景的 Subagent 用法"
Cohesion: 0.14
Nodes (16): Subagent 编排与阶段工种硬隔离架构, Subagent 注意事项, 不使用 Subagent 的情况, 主人中途干预, 五、Subagent 编排规则, 各场景的 Subagent 用法, 场景 1：赛前全流程（「给推荐」/ cron 17:00 与 21:00）, 场景 2：手动分析（「分析 2950979」/「帮我看看 A 和 B」/「分析 001」） (+8 more)

### Community 14 - "知情交易与尖锐资金"
Cohesion: 0.09
Nodes (39): Page 03: Introduction, Page 13: 第 13 页, Page 14: 第 14 页, Page 16: 第 16 页, Page 24: Figures 2. Two analysis with historical data demonstrate the effectiveness of our betting strategy., Page 28: Supplementary Materials, 区域 1：Box 1. Glossary, 区域 1：Eq.8与时序采样段 (+31 more)

### Community 15 - "IngestSpider"
Cohesion: 0.15
Nodes (4): Named-source completeness, decode_body(), extract_entity(), IngestSpider

### Community 16 - "足球倍率全周期真实变盘时序形态学手册"
Cohesion: 0.13
Nodes (14): 四项论文质问清单（Levitt偏见/Goto去水/Winkelmann假摔/Constantinou底线）, Constantinou (2022) & Hegarty-Whelan (2023) 欧亚双盘背离与让球防守底线优先律, Kaunitz (2017) 平博/必发锐利标尺与多机构共识离群检验, Levitt (2004) 台阶式真实防守与极小化最大损失做市定理, Macri (2025) 临盘洗盘期贝叶斯动态离散时间加权模型, 剧烈震荡洗盘（Volatility Wash）与死锁不动引流池（Static Trap）, Winkelmann (2026) 隐状态空间假摔突破形态（Head-Fake瞬态流动性诱买）, 1. 多机构协同对账战区（严禁单看皇冠） (+6 more)

### Community 17 - "Forecast Evaluation for Data Scientists: Common Pitfalls and Best Practices"
Cohesion: 0.05
Nodes (38): Forecast Evaluation for Data Scientists: Common Pitfalls and Best Practices, Page 01: Data Mining and Knowledge Discovery (2023) 37:788–832, Page 02: Forecast evaluation for... 789, Page 03: 790 H. Hewamalage et al., Page 04: Forecast evaluation for... 791, Page 05: 792 H. Hewamalage et al., Page 06: Forecast evaluation for... 793, Page 07: 794 H. Hewamalage et al. (+30 more)

### Community 18 - "深度分析"
Cohesion: 0.10
Nodes (19): 2026-10-17 每日记忆, 🎯 2串1 组合建议, 【周六001】麦克阿瑟FC vs 珀斯光荣 (澳超), 【周六002】鹿岛鹿角 vs 长崎成功丸 (日职联), 【周六013】埃沃斯堡 vs 奥格斯堡 (德甲), 【周六014】不来梅 vs 帕德博恩 (德甲), 【周六015】沙尔克04 vs 美因茨 (德甲), 【周六016】汉堡 vs 斯图加特 (德甲) (+11 more)

### Community 19 - "场次认知契约卡与核心做市推导链"
Cohesion: 0.10
Nodes (19): 1. 【周一005】托特纳姆热刺 vs 考文垂（ID: 3003918 ｜ 03:00 开球）, 2026-10-19 每日记忆, 2. 【周一006】赫塔菲 vs 巴列卡诺（ID: 3013726 ｜ 03:00 开球）, 3. 【周一008】科林蒂安 vs 维多利亚（ID: 2910931 ｜ 07:00 开球）, 4. 【周一007】布拉加 vs 吉维森特（ID: 3023443 ｜ 03:15 开球）, 5. 【周一003】帕尔马 vs 都灵（ID: 2993821 ｜ 02:45 开球）, 6. 【周一004】罗德兹 vs 蒙彼利埃（ID: 2997752 ｜ 02:45 开球）, 优质 2 串 1 组合建议 (+11 more)

### Community 20 - "比分建模与投注手册（泊松版）"
Cohesion: 0.12
Nodes (15): 平局比分累积占比（0:0/1:1/2:2）辅助盘口防平决策, 基于胜平负方向、大小球与球队风格的比分二次加权筛选 S(i:j)=P(i:j)*w(i:j), 1.1 单场比分概率 P(i:j), 1.2 胜平负与比分的关系, 2.1 基本思路, 2.2 操作步骤, 4.1 从胜平负 / 亚盘反推比分范围, 4.2 用比分辅助「盘口纠结」 (+7 more)

### Community 21 - "OO-EPC去水模型（Shin/Power/Probit合成）"
Cohesion: 0.23
Nodes (14): 平局偏差定理与双参数FL-GLM（平局FLB弱于分胜负项，单参数去水系统性低估平局，需分离 beta_decisive 与 beta_draw）, 算法6与命题4-6（FL-GLM广义线性模型）：单参数幂律 X_ij^{-beta}/sum X_ik^{-beta} 统一乘法去水与Power去水并量化庄家FLB系数, 算法5与命题3（OO-EPC等利润条件去水）：按逆赔率标准误 sigma_i=sqrt(1-x_i^-1) 等比例扣减 z=(s-t)/sum(sigma_i), OO-EPC去水模型（Shin/Power/Probit合成）, 跨市场抽水与热门-冷门偏差（FLB）扭曲图谱：欧指高抽水强FLB vs 亚盘低抽水零FLB vs 平局弱FLB, 命题1与命题2：证伪Shin模型底层假设（Shin隐含低抽水庄家知情交易z->0更不准，与Pinnacle低水高准事实矛盾）, 数据完整性检验与验收标准手册（重定向索引与CLI速查）, OO-EPC无偏胜率与亚盘让球门槛几何折合校验 (+6 more)

### Community 22 - "ingest_spider.py"
Cohesion: 0.09
Nodes (10): _cached_capture_is_valid(), _duplicate_table_rows(), _has_no_open_marker(), _has_table(), main(), _now(), parser(), _sha256() (+2 more)

### Community 23 - "赔率分析推演十大公理与四大物理不变量"
Cohesion: 0.13
Nodes (7): 赔率分析推演十大公理与四大物理不变量, 盘路母型：豪门客战中盘跳档诱多型（Head-Fake假摔）, 实战判例：巴西甲桑托斯2:2弗拉门戈（受让0.82超低水锁死防守+3.60冷平）, Winkelmann et al. (2026) 异常赔率移动与状态空间滤波：识别退盘震仓（Shakeout）, 物理不变量二：胜平负/让球/大小球背后的进球数守恒, 物理不变量三：庄家抽水率（Overround）与返还率守恒边界, 物理不变量四：T0初盘→T4终盘不可逆时间因果序

### Community 24 - "load_contract"
Cohesion: 0.13
Nodes (6): Bookmaker, Contract, EndpointSpec, load_contract(), _session_kwargs(), _validate_contract()

### Community 25 - "Egidi, Pauli & Torelli (2018) 结合历史进球数据与庄家隐含赔率的层次贝叶斯泊松模型"
Cohesion: 0.23
Nodes (11): Beta-Binomial混合贝叶斯网络因果链：RDL → 控球率(PS) → 射门差(SD) → 射正差(STD) → 净胜球(GD) → 1X2/AH (Fig. 1), 改进型动态Pi-ratings评分系统：主客场双轨评分与最优学习率 λ=0.018, γ=0.70 (Eq. 1-6, Table 6), 历史统计强度θ与庄家隐含强度λ的凸组合先验 p·θ + (1-p)·λ (Eq. 3.3, 3.7), 赛季内时间段动态自回归攻防演化 att_{t,τ} ~ N(att_{t,τ-1}, σ²) (Eq. 3.9), 双泊松进球分布与对数线性攻防强度模型 θ_m1, θ_m2 (Eq. 3.3-3.4), Basic基础比例去水(Eq. 2.1)与Shin知情交易占比z去水(Eq. 2.2)对比, 基于Skellam分布(PD)从欧赔去水概率反演庄家隐含进球率 θ̂_m1, θ̂_m2 (Eq. 3.2), 球队攻防参数零和可识别性约束 Σatt_t=0, Σdef_t=0 (Eq. 3.5-3.6) (+3 more)

### Community 26 - "赛后复盘先审过程再揭比分与Graphify自愈闭环"
Cohesion: 0.11
Nodes (18): 基于E-过程（E-process）与经验Bernstein置信序列的长期推演胜率/ROI序贯无偏审计机制, 赛后复盘先审过程再揭比分与Graphify自愈闭环, Wilkens (2021) 与 Hewamalage (2023) 预测模型特征克制与基准校准定理, 工作记忆问答：复盘如何与九篇论文打通且不把每句话变成门禁, 盘路母型：深盘热门欧深亚浅避险型（欧指<1.45卡一球超低水不升盘）, 实战判例：芬超冠古比斯0:1奥卢（密集防守弱旅低xG偷袭12%尾部方差）, Aiyer (2023) 决策过程审计：分离12%物理尾部方差与战意叙事盲区, 盘路母型：极端高平赔脱靶型（全网平赔3.80~4.10高挂但密防0:0闷平打出） (+10 more)

### Community 27 - "全市场共识与定价锚点"
Cohesion: 0.11
Nodes (32): Page 05: 2. Betting Markets for European Soccer, Page 07: 2.3. Data Description, Page 10: 3. The Home, Away & Draw Betting Market, Page 12: Figure 2: Average Payouts for the Probability Deciles of Home/Away/Draw Bets, Page 17: 4. The Asian Handicap Market, 区域 1：Figure 2, 区域 1：半球与整数盘口方法和公式9–14, 区域 1：商业模式正文及脚注4/5 (+24 more)

### Community 28 - "纠偏规则（corrected）：平手盘主队高水不得单凭伤停直接定性为诱主而一票否决主胜，需双向核实高水阻筹属性"
Cohesion: 0.24
Nodes (11): Answer, Outcome, Q: 【超高水逆向打出型】亚盘让球方挂满水超1.05+是否等于出货诱买一票否决（案例：巴西甲巴西国际2:1科林蒂安）, Source Nodes, Answer, Outcome, Q: 2026-10-11 英超 水晶宫 vs 诺丁汉森林 (3003903) 平手高水误判诱主失误反思, Source Nodes (+3 more)

### Community 29 - "步骤 1：EvoOntology 看数与核验（全量字段接入、导航与硬核验）"
Cohesion: 0.12
Nodes (15): 01 看数与物理基准, 1.1 官方只读边界, 1.2 官方 MCP 语义导航与 Task 轨迹（Semantic Navigation）, 1.3 核心约束强阻断与对质（Constraint Enforcement & Auto-Debate）, 1.4 EvoOntology 工具链与提取契约, 1.5 数据质量边界, 1.6 分析依据与做市定位, 1.7 核心先决工序：倍率时序轴理清与变盘时间先后标定（Timeline First Invariant） (+7 more)

### Community 30 - "Wheatcroft (2019) 足球比赛概率预测评分规则评估：批判RPS并确立对数无知评分(IGN)"
Cohesion: 0.14
Nodes (18): Aiyer et al. (2023) 确认偏误：既有判断形成后对反面信号权重打折 (Step 9反证卡依据), 13个英超赛季(2006/07-2018/19)预测精度基准：1X2平均RPS=0.195，亚盘平均Brier=0.248，需至少5赛季数据训练 (Table 7-8), 传统固定分箱(Binning and Counting)可靠性图的不一致性与超参数敏感性批判 (Fig. 1), 连续预测下CORP估计均方误差(MSE)最优收敛速率 O(n^{-2/3}) 与离散速率 O(n^{-1}) (Page 8), CORP精确评分分解定理 S̄_X = MCB - DSC + UNC (Theorem 1, Eq. 2-3)：保证失准度MCB≥0、区分度DSC≥0恒成立, CORP特征(Consistent, Optimally Binned, Reproducible, PAV-based)：基于池相邻违背算法(PAV)的非参数保序重校准, 失准度(MCB = S̄_X - S̄_C)与区分度(DSC = S̄_R - S̄_C)正交解耦：对角线偏离测度失准，水平台阶测度区分度丧失, Theorem 2：当经验条件事件频率单调不减时，Brier评分下CORP分解(MCB/DSC/UNC)与经典Murphy分解(REL/RES/UNC)完全等价 (+10 more)

### Community 31 - "IngestSpiderTest"
Cohesion: 0.17
Nodes (6): 5. Filled happy path, build_request_plan(), content_type_for(), EndpointAssessment, RequestPlan, IngestSpiderTest

### Community 32 - "盘口与走势阅读手册（简版）"
Cohesion: 0.07
Nodes (26): 欧指平均定价值、平博看冷热、亚盘四家看资金、客群盘看本地情绪的角色分工, 盘位+水位+时间序列+多家公司对比的四维看盘法, 4.1 看初盘：谁是庄家心里的「正路上盘」, 4.2 看盘变：盘口往哪边走, 4.3 看水位：顺资金，还是反资金, 4.4 非EV版的小结（纯看盘时的方向感）, 6.1 盘位：这场的基础强弱框架, 6.2 水位：当前谁贵谁便宜 (+18 more)

### Community 33 - "赔率与泊松比较：何时值得下注（案例详解）"
Cohesion: 0.15
Nodes (11): 泊松概率对比庄家隐含概率及期望值EV>1三案例实证（布伦特福德/赫尔蒙德/巴列卡诺）, 总结：怎么比较才叫“值得下注”, 案例一：布伦特福德 vs 狼队（真实赔率）, 案例二：赫尔蒙德 vs 坎布尔（假设赔率：主队被低估）, 步骤 1：赔率 → 隐含概率, 步骤 1：赔率 → 隐含概率, 步骤 2：逐项比较, 步骤 2：逐项比较 (+3 more)

### Community 35 - "盘赔分析系统化框架（2026-03-17 整理 · 主人亲授）"
Cohesion: 0.18
Nodes (11): 001 场案例分析, 判断速查表, 升盘 + 升水的双重性（难点）, 后续行动, 如何区分阻 vs 诱？, 我们的局限与应对, 核心认知（庄家视角）, 案例验证表（持续更新） (+3 more)

### Community 36 - "2026-10-22 记忆日志"
Cohesion: 0.18
Nodes (10): 1. 架构升级与系统演进, 📊 2026-10-22 真实赛果对账审计总表, 2026-10-22 记忆日志, 待复盘, 🎯 战绩统计与做市商博弈反思, 欧罗巴杯 格拉茨风暴 vs 马赛（周四001）, 深度分析, 🚨 赛前无卡漏推置顶红线报警 (+2 more)

### Community 37 - "Market Efficiency and Behavioral Biases: Evidence from an Online Betting Exchange"
Cohesion: 0.10
Nodes (20): Market Efficiency and Behavioral Biases: Evidence from an Online Betting Exchange, Page 14: Aggregate-level Analysis (continued), Page 24: References (continued), Page 29: Table 2: Summary Statistics of Bookmaker's Odds, Page 30: Table 4: Objective versus Implied Win Probabilities, Page 32: Table 6: Linear Probability Model of Match Outcomes, Table 2: Summary Statistics of Bookmaker's Odds across 1X2 Outcomes, Table 3: Summary Statistics of Bet Characteristics (+12 more)

### Community 39 - "Data Integrity Gates for Scraped Tables"
Cohesion: 0.18
Nodes (10): Choose the fetch path, Data Integrity Gates for Scraped Tables, DOM table is a view, not the dataset, Empty state versus success, Flattened Markdown streams, JS globals and stored-shell false negatives, Layout-only "tables" (no `<table>`), MCP sequence for a JS-rendered table (+2 more)

### Community 40 - "欧指1X2热门-冷门偏差（FLB：低概率十分位亏损17% vs 高概率仅亏2%，简单去水严重高估冷门）"
Cohesion: 0.33
Nodes (9): 欧指1X2热门-冷门偏差（FLB：低概率十分位亏损17% vs 高概率仅亏2%，简单去水严重高估冷门）, 半球盘（.5）无走水解析概率公式 P_S = O_W/(O_S+O_W), mu = O_S*O_W/(O_S+O_W), 整数盘走水率不变性定律（P_S1 ≈ 0.254 跨赔率与赛季恒定 R^2=0.003）与胜率剥离公式, 四分之一球盘（.25/.75）输半/赢半非对称概率修正项 ±(P_S1/2)*O/(O_S+O_W), 亚盘整数盘退本走水率物理常数（P_S1 ≈ 25.4% 跨联赛跨赔率恒定不变量）, 亚盘AH无偏45度线校准效率（消除1X2冷门高估偏差，具备极高定价效率）, Soft庄家（欧指高抽水6.46%/限额赢家）与Sharp庄家（Pinnacle亚盘低抽水3.61%/欢迎套利）双轨生态, Hegarty & Whelan (2023) 欧洲22联赛84,230场欧指1X2与亚盘AH双市场预测效率对比 (MPRA 116925) (+1 more)

### Community 41 - "盘赔分析系统化框架（2026-03-17 整理 · 主人亲授）"
Cohesion: 0.12
Nodes (15): 标准7列交付表格与Polymarket交叉验证, 1. Football-Data.org, 1. 赔率时序与全盘指数（主源：titan007）, 2. The Odds API (`the-odds-api.com`), 2. 主源失败怎么办, 3. BrowserOS neo 真实浏览器直连通道, 3. 微观阵容与伤停双引擎, 4. Sofascore 手机免密钥数据流 (+7 more)

### Community 42 - "03 裁决与交接"
Cohesion: 0.20
Nodes (9): 03 裁决与交接, 3.3 交叉裁决（第 7~9 步）, 3.4 风险封口（第 10 步）, 交接 1：announce.comprehensive_assessment（综合评估与推荐）, 交接 2：announce.memory_summary（单场认知契约卡与推演摘要）, 第 10 步：风险提示, 第 7 步：赔率合理性评估, 第 8 步：赔率变动解读 (+1 more)

### Community 45 - "模型扩展与组合手册（除泊松之外）"
Cohesion: 0.10
Nodes (18): 联赛五维基准参数表（G_league均值/典型大小球线/平局倾向/主场优势/盘口习惯）, 联赛配置手册（泊松+盘口）, Poisson回归多特征λ建模与Logit/XGBoost第二曲线交叉验证, 2.1 Poisson 回归 / 负二项回归, 3.1 Logistic / 多项 Logit, 3.2 树模型 / 集成模型（Random Forest / XGBoost / LightGBM）, 4.1 多家赔率反演的「综合隐含概率」, 7.1 总体原则 (+10 more)

### Community 46 - "Choe & Ramdas (2023) 跨时间与博弈论视角下的序贯预测者比较 (Operations Research)"
Cohesion: 0.15
Nodes (20): 定理3：次指数E-过程（E-process）与随时有效P-过程检验弱原假设 H_0^w: Delta_t <= 0, 定理2：Empirical Bernstein方差自适应置信序列（内禀时间 hat_V_t 与次指数 Gamma-Exponential 混合边界）, 多模型非参数显著性检验（Friedman秩检验与Nemenyi/Hochberg临界距离CD图）, 博弈论序贯预测协议（Forecasters p_t/q_t × Reality r_t × Statistician 双重滤子 F_t/G_t）, 定理1：Hoeffding型次高斯置信序列（Sub-Gaussian psi_N 与正态混合边界 u_alpha^CM）, 赛前T4终盘截断与滚球1Hz状态空间的时序物理边界（严禁赛后/滚球数据逆向污染赛前推演）, MLB十年25,165场实证：Vegas终盘赔率序贯显著击败FiveThirtyEight (E_T=2979.0), 非平稳单位根/随机游走序列Naïve基准最优定律（复杂DL模型Autoformer/Informer常败于Naïve） (+12 more)

### Community 47 - "盘口分类体系（主人亲授 · 2026-03-18）"
Cohesion: 0.22
Nodes (9): 一、盘口大类, 三、浅盘三种形态（重点）, 二、错盘分类, 五、分析框架（完整版）, 六、案例记录, 四、其他错盘类型, 浅盘阻上 vs 浅盘诱上 对比, 盘口分类体系（主人亲授 · 2026-03-18） (+1 more)

### Community 48 - "论文库实战映射总纲 (paper-application-v2)"
Cohesion: 0.06
Nodes (41): 纯汇总赔率不可识别定理：单凭公开赔率无法剥离散户认知偏差、风险偏好与庄家主动调价, 平局与高赔冷门严重负回报：平局平均回报-11.20%、长赔平局回报低至-22.50%至-25.65% (Table 4), 冷热偏差(FLB)三重检验：分组z检验、LPM线性概率回归(F=55.85)与Yatchew半参数差分估计 (Table 4-7), 个体投注者行为异质性：仅38%高频博冷、6%显著亏损于冷门、2%正向剥削强队 (Section 4.1), 前景理论概率权重扭曲 w(p) 与偏度偏好(Skewness Preference)博弈机制, 本土与情感忠诚偏差(Loyalty/Home Bias)：约4%玩家对本国/死忠球队承受显著超额负回报 (Table 10), 庄家防御知情交易者(Insiders)导致的冷门端高额内嵌抽水机制, Buhamra (2024) 概率估计误差下Kelly注码收缩因子 α∈(0,1) (Step 10仓位红线) (+33 more)

### Community 49 - "结果偏见与过程审计分离"
Cohesion: 0.18
Nodes (21): Outcome Bias and Evaluations of Decisions: A Replication and Extension of Baron and Hershey (1988), Page 01: Outcomes Affect, Page 02: Aiyer et al. International Review of Social Psychology DOI: 10.5334/irsp.751 2, Page 03: Aiyer et al. International Review of Social Psychology DOI: 10.5334/irsp.751 3, Page 04: Aiyer et al. International Review of Social Psychology DOI: 10.5334/irsp.751 4, Page 05: Aiyer et al. International Review of Social Psychology DOI: 10.5334/irsp.751 5, Page 06: Section 3: Dependent Measures & Table 5, Page 07: Aiyer et al. International Review of Social Psychology DOI: 10.5334/irsp.751 7 (+13 more)

### Community 50 - "Giacomini & White (2006) 条件预测能力检验 (Tests of Conditional Predictive Ability, Econometrica)"
Cohesion: 0.33
Nodes (7): 条件预测能力原假设 H_0: E[ΔL_{m,t+τ} | G_t] = 0 与检验函数h_t (Eq. 2-3), 对Diebold-Mariano-West (DMW)无条件总体参数检验的批判：忽略滚动窗口与估计噪声, 有限滑动估计窗口设计 (m ≤ m̄ < ∞)：保留渐近非退化参数估计不确定性, 嵌套模型偏差-方差权衡定理：有限样本下精简误设模型可击败冗余真实模型 (Propositions 5-6, Eq. 9-12), 两步条件预测切换决策规则：基于当前信息集δ̂'_n h_T > c动态切换预测模型 (Section 4), 条件预测能力Wald统计量 T_{m,n}^h = n·Z̄'Ω̂⁻¹Z̄ → χ²_q 及多步HAC协方差矩阵 (Theorem 1-3, Eq. 4-6), Giacomini & White (2006) 条件预测能力检验 (Tests of Conditional Predictive Ability, Econometrica)

### Community 51 - "2026-10-20 每日记忆"
Cohesion: 0.22
Nodes (8): 2026-10-20 每日记忆, 全量十场深度推演总表（2026-10-20 销售日晚盘终审）, 认知复盘与立宪刻录：EvoOntology 官方双层闭环真谛与反造假戒律（20:35）, 赛前深度推演：周二001 欧冠杯 费内巴切 vs 斯拉维亚（20:15）, 赛程列表, 赛程抓取（10:57）, 赛程抓取与003真相对账验真（18:15）, 超级记忆固化：EvoOntology 原生结构化解析与真实 JSON 归位（21:56）

### Community 52 - "十步深度分析推演闭环 (基本面/伤停/泊松/欧亚大小时序/合理性/三维落槌)"
Cohesion: 0.24
Nodes (14): Graphify 三大战区标准化检索规范 (BFS初诊/DFS物理基准/BFS时序穿透), Graphify三大战区图谱穿透检索（BFS/DFS）, 主人亲授亚盘分类体系 (实盘/错盘/深盘/浅盘阻上与浅盘诱上), 十步深度分析推演闭环 (基本面/伤停/泊松/欧亚大小时序/合理性/三维落槌), 第一步：积分排名、赛程背景与真实战意解构, 第二步：核心伤停、阵容身价与双赛体能负荷穿透, 第三步：技统压制力（控球/射正/危险进攻/角球）与球风相克, 第四步：泊松分布λ期望进球与OO-EPC去水真值碰撞 (+6 more)

### Community 53 - "赛后复盘"
Cohesion: 0.22
Nodes (8): 2026-10-23 记忆日志, 待复盘, 🎯 战绩统计与学术反思, 数据进货（12:59）, 样本数据（结构化，供后续程序抽取）, 📊 赛前推演与赛果全对账总表（标准 7 列 · 胜负平+让球双对账）, 赛后复盘, 赛程抓取（11:10）

### Community 54 - "下注决策手册（版本 1）"
Cohesion: 0.07
Nodes (26): 10.1 串关：用 EV 和相关性约束, 10.2 特殊盘口的期望拆分, 1.1 必须直接跳过的场次（乱局）, 4.1 真实赢盘概率（用比分表聚合）, 4.2 水位 ≈ 赔率，算 EV, 4.3 盘感只做辅助，不做自动信号, 6.1 四项论文质问清单（大模型主观判断压力测试）, 7.1 下注频率：宁少不多 (+18 more)

### Community 55 - "两赛季滚动样本外保序回归校准（Isotonic Regression f:[0,1]->[0.05,0.95] 阶梯单调映射与重归一化）"
Cohesion: 0.32
Nodes (7): 客胜系统性负收益陷阱（德甲盈利10%~14.9%全部来自主胜与平局，盲目博取客胜长期亏损-16.6%）, 分数凯利（Fractional Kelly f=0.50）与正期望值（EV_min）风控护盾, 两赛季滚动样本外保序回归校准（Isotonic Regression f:[0,1]->[0.05,0.95] 阶梯单调映射与重归一化）, 价值投注三维过滤网格（EV_min × odds_max × Delta_p_min, odds_min=1.25）与分数凯利（f=0.50降回撤92%）, 主客场分离近3场（n=3）滚动xG均值泊松-Skellam概率模型（德甲主客场+0.34 xG优势）, 异方差加权最小二乘（WLS）与保序回归（Isotonic Regression）双轨概率校准器, Wilkens (2026) 德甲11赛季3,366场基于滚动xG与保序回归校准的博彩盈利检验 (JSA)

### Community 56 - "json"
Cohesion: 0.14
Nodes (3): DownstreamContractTest, header_only_payload(), html_table_payload()

### Community 57 - "Beating the bookies with their own numbers - and how the online sports betting market is rigged"
Cohesion: 0.25
Nodes (7): Beating the bookies with their own numbers - and how the online sports betting market is rigged, Page 01: Beating the bookies with their own numbers - and how the online sports betting market is rigged, 区域 1：居中题名及作者机构, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 58 - "赛后复盘"
Cohesion: 0.25
Nodes (7): 2026-10-24 记忆日志, 待复盘, 🎯 战绩统计与学术反思, 样本数据（结构化，供后续程序抽取）, 📊 赛前推演与赛果全对账总表（标准 7 列 · 胜负平+让球双对账）, 赛后复盘, 赛程抓取（11:10）

### Community 59 - "单场进货契约（27 端点 / 22 家 / JSONL / ETLX）"
Cohesion: 0.25
Nodes (7): 1. 27 endpoint keys, 2. 22-bookmaker roster, 3. JSONL row, 4. ETLX and seven tables, 6. Filled stop-line, 7. Optional human brief, 单场进货契约（27 端点 / 22 家 / JSONL / ETLX）

### Community 61 - "通用足球庄家倍率精算 AI 智能体体系 (Pansuan Engine)"
Cohesion: 0.11
Nodes (17): 1. 通用环境准备, 2. 各平台运行方式, 使用方式, 功能概览, 多平台 AI Agent 原生适配, 开发者工具：口径一致性自检（可选）, 快速上手与运行环境, 手动模式 (+9 more)

### Community 62 - "Page 22: Figure 1. Bookmakers prediction power."
Cohesion: 0.29
Nodes (7): Page 22: Figure 1. Bookmakers prediction power., 区域 1：概率散点图, 区域 2：Figure 1题注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 63 - "Page 30: Supplementary Figure 1."
Cohesion: 0.29
Nodes (7): Page 30: Supplementary Figure 1., 区域 1：B — Bets List截图, 区域 2：Supplementary Figure 1题注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 64 - "二、全周期真实变盘时序窗口解析 (Verbatim Raw Wire)"
Cohesion: 0.33
Nodes (6): 1. 初盘骨架期 (T0：开盘 ～ 赛前 24 小时), 2. 早盘试探期 (T1：赛前 24 小时 ～ 赛前 8 小时), 3. 中盘拉扯期 (T2：赛前 8 小时 ～ 赛前 3 小时), 4. 临盘洗盘期 (T3：赛前 3 小时 ～ 赛前 1 小时), 5. 终局出清期 (T4：赛前 1 小时 ～ 开球), 二、全周期真实变盘时序窗口解析 (Verbatim Raw Wire)

### Community 65 - "Page 08: 3 Data Description"
Cohesion: 0.33
Nodes (6): Page 08: 3 Data Description, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 66 - "真实攻防压制力（滚动xG/射正/角球）结合Spike-and-Slab动态先验对泊松强度 lambda 的修正机制"
Cohesion: 0.23
Nodes (10): 战术量化演进链：从Charles Reep长传记号分析到现代核心特征工程（xG/xGA/SCA射门创造/GCA进球创造）, 真实攻防压制力（滚动xG/射正/角球）结合Spike-and-Slab动态先验对泊松强度 lambda 的修正机制, 机器学习窗口敏感性与平局类别极化（10周短窗准确率崩盘至38%~47%，平局F1仅0.10~0.35）, 六大进球数与净胜球分布族（DP双泊松/BP二元泊松/DIBP平局膨胀/NB负二项/SM Skellam/ZISM零膨胀Skellam）, 半正态尖峰-平板（Spike-and-Slab）加权动态可公度先验 phi_{k,tau} ~ N+(100,0.1)(1-p_l) + N+(0,5)p_l, 攻防能力参数零和可识别性约束（sum beta_{i,tau} = 0）与MCMC收敛保障, Karlis & Ntzoufras (2003) 二元泊松分布（主客进球协方差参数 lambda_3,n 与平局膨胀 DIBP）, Macrì-Demartino, Egidi & Torelli (2025) 足球贝叶斯加权动态可公度先验模型 (arXiv:2508.05891) (+2 more)

### Community 67 - "联赛配置手册（泊松 + 盘口）"
Cohesion: 0.17
Nodes (11): 3.1 在 λ 与风格判定中的使用, 3.2 在比分权重与大小球中的使用, 3.3 在盘深 / 盘浅判断中的使用, 4.1 荷乙, 4.2 意乙, 一、为什么要按联赛配置？, 三、如何在现有手册中使用联赛配置, 二、每个联赛需要配置哪些东西？ (+3 more)

### Community 68 - "Page 21: References"
Cohesion: 0.33
Nodes (6): Page 21: References, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 69 - "Page 28: Table 1: Literature on the Efficiency of Sports Betting Markets"
Cohesion: 0.33
Nodes (6): Page 28: Table 1: Literature on the Efficiency of Sports Betting Markets, 区域 1：Table 1, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 70 - "Page 15: 第 15 页"
Cohesion: 0.33
Nodes (6): Page 15: 第 15 页, 区域 1：纸面、实盘与随机检验结果, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 71 - "3.2 三盘定价（第 4~6 步）"
Cohesion: 0.33
Nodes (5): 02 三盘定价, 3.2 三盘定价（第 4~6 步）, 第 4 步：欧洲指数（胜平负）赔率分析, 第 5 步：亚盘赔率分析, 第 6 步：进球数赔率分析

### Community 72 - "盘路母型：整球设障御敌防小胜型（让一球中低水设障+泊松共振锁1球小胜）"
Cohesion: 0.21
Nodes (8): 盘路母型：整球设障御敌防小胜型（让一球中低水设障+泊松共振锁1球小胜）, 实战判例：巴西甲帕尔梅拉斯1:0巴伊亚（一球走水+1:0波胆与让平共振）, 盘路母型：豪门客战深盘让球防小胜与波胆约束型, 实战判例：欧国联克罗地亚1:2西班牙（客战深盘防大胜+泊松共振精准命中1:2波胆）, 实战判例：2026-10-10 德甲 斯图加特0:2帕德博恩（客让一球低水设防+Crown波胆0:2）, Egidi (2018) 历史技统与庄家赔率隐含进球率凸组合双泊松模型, 实战判例：2026-10-10 西甲 阿拉维斯1:2马德里竞技（客让半一满水防1球小胜让平）, Hegarty & Whelan (2023) 1X2与AH双市场定价异同与四分盘拆分机制

### Community 73 - "三、盘口与走势过滤危险热门"
Cohesion: 0.40
Nodes (5): 3.1 平博：尖锐参考盘（胜平负 / 亚盘 / 大小球）, 3.2 亚盘四家：澳彩 / 皇冠 / Bet365 / 易胜博, 3.3 欧指客群盘：威廉 / Interwetten / 马会 / 中国竞彩网, 3.4 过滤规则, 三、盘口与走势过滤危险热门

### Community 74 - "三、四大经典微观做市形态库"
Cohesion: 0.40
Nodes (5): 1. 假摔突破形态 (Head-Fake) —— 锚定：Winkelmann (2026) 状态空间模型, 2. 台阶式真实防守 (Step-Defense) —— 锚定：Levitt (2004) 极小化损失定理, 3. 剧烈震荡洗盘 (Volatility Wash), 4. 死锁不动引流 (Static Trap), 三、四大经典微观做市形态库

### Community 75 - "Q: 2026-10-14 欧冠与英冠晚盘复盘：曼城、科莫、博德闪耀实战推演认知修正"
Cohesion: 0.40
Nodes (4): Answer, Outcome, Q: 2026-10-14 欧冠与英冠晚盘复盘：曼城、科莫、博德闪耀实战推演认知修正, Source Nodes

### Community 76 - "泊松概率计算手册（足彩用）"
Cohesion: 0.12
Nodes (16): 保守资金管理与相关性逻辑分桶注码上限（单场<=3%B，单日<=6%B）, 四大乱局识别过滤（极端伤停/战意怪局/末轮练兵/样本不足）, 下注决策手册（版本1）, 双泊松模型（Bivariate Poisson）与Dixon-Coles低比分相关性修正, 主客场(0.7)与近6场(0.3)加权合成攻防预期进球λ公式, Dixon-Coles低比分集合{0:0,1:0,0:1,1:1}经验修正系数与归一化, 轻微/中度/重度三档伤停对λ1与λ2的加减修正规则, 10.1 离线拟合思路（以后可精细化） (+8 more)

### Community 77 - "Q: 欧冠杯科莫vs曼联退平手挂超高水诱买做市博弈破译"
Cohesion: 0.40
Nodes (4): Answer, Outcome, Q: 欧冠杯科莫vs曼联退平手挂超高水诱买做市博弈破译, Source Nodes

### Community 78 - "Q: 欧冠杯葡萄牙体育体彩关闭HAD仅开让球盘大冷"
Cohesion: 0.40
Nodes (4): Answer, Outcome, Q: 欧冠杯葡萄牙体育体彩关闭HAD仅开让球盘大冷, Source Nodes

### Community 79 - "Q: 欧罗巴杯格拉茨风暴vs马赛商业庄主胜大跌平博未跟"
Cohesion: 0.40
Nodes (4): Answer, Outcome, Q: 欧罗巴杯格拉茨风暴vs马赛商业庄主胜大跌平博未跟, Source Nodes

### Community 80 - "步骤 1.5：校验【推演源数据】赔率与数据完整性 (物理卡死硬门禁与真实性防伪)"
Cohesion: 0.40
Nodes (5): 1. 确认分析依据公司列表, 2. 赔率数据归属与整理, 3. 赔率数据整理规则, 4. 存档原始赔率数据, 步骤 1.5：校验【推演源数据】赔率与数据完整性 (物理卡死硬门禁与真实性防伪)

### Community 81 - "异常处理"
Cohesion: 0.40
Nodes (5): 异常处理, 抓取异常, 数据源限流/网络异常, 部分完成场景, 频率控制

### Community 83 - "Stable Reliability Diagrams Using CORP and Isotonic Recalibration"
Cohesion: 0.14
Nodes (13): Page 01: Stable reliability diagrams for probabilistic classifiers, Page 02: ENS / Binning and Counting ENS / CORP, Page 03: A EMOS / 9 Equidistant Bins B EMOS / 10 Equidistant Bins, Page 04: constitutes both the nonparametric isotonic least squares and operate in the dis, Page 05: 1.00 1.00, Page 06: Here, we adopt the general score decomposition introduced n1 , . . . , nk times,, Page 07: Table 1: Scoring Rules & CORP Decomposition (Table 2), Page 08: and associated realizations y1 , . . . , yn ∈ {0, 1} from an order n α for α ∈ ( (+5 more)

### Community 84 - "预测与复盘论文（本项目）"
Cohesion: 0.50
Nodes (3): 十九篇的执行落点与原文锚点, 预测 → 推荐 → 复盘的实际闭环, 预测与复盘论文（本项目）

### Community 85 - "第二部分：模式二·单场【推演源数据】采集与门禁质检（阶段一专属搬运工）"
Cohesion: 0.22
Nodes (9): 0. 单场/多场极速进货执行路径（搬运工 Subagent 专属操作规程）, 1. 亚盘与大小球 7 大法定机构并发直取, 2. 欧洲指数 23 家法定机构全覆盖与全时序解构（抓取时内存提纯，严禁 Raw Dump）, 3. 单场 5 大数据源抓取时精准提取规范（Scrapling 官方选择器下推）, 4. 组装落盘与物理门禁核验（进货合格线）, 5. 多场与全量场次分批进货规约（Batch Ingest Protocol）, 异常处理, 第二部分：模式二·单场【推演源数据】采集与门禁质检（阶段一专属搬运工） (+1 more)

### Community 86 - "Q: 2026-10-12 10场全量赛后复盘：四维认知契约卡对账与做市破译验真"
Cohesion: 0.50
Nodes (3): Answer, Q: 2026-10-12 10场全量赛后复盘：四维认知契约卡对账与做市破译验真, Source Nodes

### Community 87 - "数据进货 Worker 工单模板（主会话专用）"
Cohesion: 0.50
Nodes (3): 1. 标准进货 Worker, 2. 验收纪律, 数据进货 Worker 工单模板（主会话专用）

### Community 88 - "AGENTS.md - 足彩分析工作流操作手册"
Cohesion: 0.13
Nodes (16): AGENTS.md - 足彩分析工作流操作手册, 七、红线与安全, 九、群聊规则, 二、数据来源, 八、心跳机制, 六、可配置参数, 心跳 vs Cron：何时使用哪一个, 心跳期间的行为 (+8 more)

### Community 89 - "盘路母型：豪门客战中盘跳档诱多型（Head-Fake假摔）"
Cohesion: 0.32
Nodes (3): 盘路母型：欧亚共振升盘降赔型（主胜破1.50+平赔4.40+关门+升一球压水防穿）, 实战判例：芬超冠赫尔辛基6:0VPS瓦萨（五巨头共振降赔升盘狂轰6球穿盘）, 实战判例：2026-10-10 德甲 RB莱比锡6:0法兰克福（一球退半一震仓洗盘误判诱客反思）

### Community 91 - "执行流程"
Cohesion: 0.25
Nodes (8): 4 家一致的“操盘手法一致”识别（亚盘专用）, 4 家一致的“操盘手法一致”识别（大小球专用）, 执行流程, 检查与加载专属【推演源数据】, 步骤 1：只读加载并核验【推演源数据】（推演物理原材料）, 步骤 2：历史记忆召回与方法校准, 输出 1：综合评估与推荐, 输出 2：写入记忆

### Community 92 - "深度分析（deep-analysis）"
Cohesion: 0.25
Nodes (8): 数据抓取方式（强制）, 方式 1：来自初筛流程（默认）, 方式 2：主人指定比赛 ID, 方式 3：主人提供分析页 URL, 方式 4：主人指定竞彩编号, 深度分析（deep-analysis）, 输入, 输出

### Community 93 - "AGENTS.md 足彩分析工作流操作手册"
Cohesion: 0.20
Nodes (8): AGENTS.md 足彩分析工作流操作手册, MEMORY.md 长期记忆中枢与智慧芯片, README.md 倍率分析推演系统架构总览, skills/deep-analysis/SKILL.md 比赛深度分析十步法核心大脑, skills/recommendation/SKILL.md 推荐汇总与7列表格交付技能, 推荐输出（recommendation）, 输入, STRATEGY.md 足球赛事盘赔分析与赛果推演系统战略大图

### Community 94 - "赛前分析推演（{HH:MM} 全量/精选推演）"
Cohesion: 0.67
Nodes (3): 🎯 2 串 1 组合推荐, 📊 深度推演总表（法定 7 列规范）, 赛前分析推演（{HH:MM} 全量/精选推演）

### Community 95 - "无额外进球预感定理：扣除累积xG差与红牌后，庄家赔率与散户注额在进球前均无异常预测力"
Cohesion: 0.27
Nodes (10): 进球冲击非对称市场动态：冷门爆冷进球引爆潜状态与注额（+0.285/+0.685），热门顺理成章进球反而平息市场（-0.379）, 投注者相对注额零一膨胀Beta状态空间模型（BEINF + 潜市场活跃度AR(1)状态 phi=0.974~0.984）, 两部跨栏对数正态ARX(1)状态空间模型（Hurdle pi=0.094 + 潜市场兴奋度状态 s_t=phi*s_{t-1}+x*omega+eps, phi=0.985）, 盘中隐含概率动态回归模型（improbpre + 时间t/t^2 + 红牌效应-12%/+17.3% + 累积xG差速率 xgdiff/t）, 中盘T2/T3假摔震仓（Head-Fake Shakeout）识别：结合状态空间残差与多庄协同背离穿透诱筹, 无额外进球预感定理：扣除累积xG差与红牌后，庄家赔率与散户注额在进球前均无异常预测力, 基于状态空间残差剥离的异常赔率波动与假摔震仓（Head-Fake / Match-Fixing）监测法, Kitagawa (1987) 网格离散化（m=100）与HMM前向递归似然算法（复杂度从 O(Tm^T) 降至 O(Tm^2)） (+2 more)

### Community 96 - "步骤 3：10 步分析过程（固定顺序）"
Cohesion: 0.18
Nodes (11): 1. 高频多触点深广检索（三大战区主动调兵）, 2. 可自愈机制（脱靶自愈与理论矛盾收敛）, 3. 论文主动纠偏与认知校准闭环（五步压力测试）, 4. 各阶段论文与心法执行准则, 步骤 3：10 步分析过程（固定顺序）, 第 1 步：基本面分析, 第 2 步：伤情分析, 第 3 步：泊松建模（比分概率） (+3 more)

### Community 97 - "倍率分析推演 (Pansuan Engine) Strategy"
Cohesion: 0.17
Nodes (11): Boundaries, Key metrics, Positioning, Purpose, Tracks, Users, 倍率分析推演 (Pansuan Engine) Strategy, 博弈认知深化与学术前沿扩展 (+3 more)

### Community 98 - "球队风格判定手册（简版）"
Cohesion: 0.18
Nodes (10): 场均进失球相对联赛均值G_league的3×3攻防强弱矩阵, 球队A/B/C三类风格划分（偏大球对攻/中性/偏小球防守）, 2.1 判定总进球倾向, 2.2 进攻 / 防守强弱, 2.3 主客场 & 近况修正, 一、你到底需要什么级别的「风格」？, 二、从硬数据判定球队风格, 六、最低可执行版本（给自己一个懒人流程） (+2 more)

### Community 104 - "一、工作流程总览"
Cohesion: 0.20
Nodes (10): 一、工作流程总览, 单场推演两阶段硬隔离执行标准（严禁单体兼职、严禁黑盒盲等与视觉倒置）, 多场与全量场次流水线执行标准（4大护城河铁律：分批进货、故障隔离、滑动队列、单写封存）, 手动交互模式, 🌟 指令范围四级立宪契约（主得意图拥有系统最高裁决权）, 状态推送规则, 赛前分析流程（早盘 17:00 / 晚盘 21:00 双轨制；同一条定时任务）, 赛后复盘流程（每日 10:30） (+2 more)

### Community 105 - "深度分析推送通知模板"
Cohesion: 0.12
Nodes (15): 先结论后过程推送结构与4000字分段折叠规范, 十步分析过程完整性与多机构同时间点交叉认证检查清单, 1. 标题与场次信息（首段开头）, 2. 分析过程（结论之后发送，可多段）, 3. 结论（生成在十步之后，发送在第 1 段，必须含以下全部）, 一、推送结构总览, 三、检查清单（主人/复盘用）, 二、必含块（下列按编写顺序列出，发送时先结论、后过程） (+7 more)

### Community 109 - "极速单动执行规约（Scrapling MCP 官方极速通道）"
Cohesion: 0.17
Nodes (12): skills/match-scraper/SKILL.md 赛程同步与五维并发进货技能, 前提条件, 极速单动执行规约（Scrapling MCP 官方极速通道）, 查看其他日期赛程, 步骤 1：协议流直取球探竞足页, 步骤 2：直接解析 Markdown 表格行, 步骤 3：原子落盘 `meta.md` 与追加 `memory.md`, 步骤 5：结构化输出 (+4 more)

### Community 111 - "Aiyer et al. (2023) 结果偏见与决策评价预注册复制与扩展研究 (N=692)"
Cohesion: 0.33
Nodes (8): 有意识去偏失效定律（明确声明不应看结果的被试仍表现强烈结果偏见 d=0.64）, 反事实规范理论（Norm Theory）在足球爆冷/绝杀赛后归因中的认知纠偏, 结果偏见定理（Outcome Bias：相同事前概率8%下成败导致事后评价极显著背离 d=0.77~1.10）, 专业决策者失利严惩非对称性（医生失败受罚显著重于患者本人 t=-2.91, d=-0.31）, 感知社会规范对结果偏见的间接中介机制（Perceived Social Norms f=0.18）, Aiyer et al. (2023) 结果偏见与决策评价预注册复制与扩展研究 (N=692), Baron & Hershey (1988) 结果偏见经典实验1 (冠脉搭桥8%死亡率相同事前概率), Kahneman & Miller (1986) 规范理论与事后反事实可变性（Norm Theory）

### Community 118 - "{联赛} {主队} vs {客队}（编号: {编号} 比赛ID: {matchId}，开球: {开球时间}，分析: {YYYY-MM-DD HH:mm}）"
Cohesion: 0.50
Nodes (4): 深度分析, 综合评估, {联赛} {主队} vs {客队}（编号: {编号} 比赛ID: {matchId}，开球: {开球时间}，分析: {YYYY-MM-DD HH:mm}）, 赔率摘要

### Community 125 - "Beating the bookies with their own numbers - and how the online sports betting market is rigged"
Cohesion: 0.33
Nodes (6): Page 02: Abstract, 区域 1：Abstract正文与脚注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 126 - "Forecasting Football Match Outcomes: Evidence from the 1X2 and Asian Handicap Betting Markets"
Cohesion: 0.25
Nodes (7): Forecasting Football Match Outcomes: Evidence from the 1X2 and Asian Handicap Betting Markets, Page 15: Section 3.2: 1X2 Market Ex Ante vs Ex Post Loss Rates (Table 3), Page 27: Section 4.4: Asian Handicap Outcomes vs Probabilities (Table 6), Page 28: Section 4.5: Asian Handicap Ex Ante vs Ex Post Loss Rates (Table 7), Table 3: Average Expected Ex Ante Loss Rates Compared with Actual Average Loss Rates for the Home/Away/Draw (1X2) Market, Table 6: Comparing Calculated Probabilities with Actual Outcomes for Each Handicap Type, Table 7: Mean Expected Ex Ante Loss Rates Compared with Mean Actual Loss Rates for Different Betting Strategies in the Asian Handicap Market

### Community 127 - "盘路母型：均势浅盘底线低平赔型（初盘平赔<2.90+即时抬升分流两头）"
Cohesion: 0.39
Nodes (4): 盘路母型：均势浅盘底线低平赔型（初盘平赔<2.90+即时抬升分流两头）, 实战判例：巴西甲巴拉纳竞技2:2米内罗竞技（体彩2.85/澳彩2.97锁平读秒2:2）, 盘路母型：国家队均势浅盘低平赔防守型（体彩与澳彩平赔2.85锁定防守）, 实战判例：欧国联哈萨克斯坦2:2法罗群岛（体彩澳彩2.85平赔双锁单选平局命中）

### Community 128 - "003 场完整分析案例（2026-03-18 反思）"
Cohesion: 0.25
Nodes (8): 003 场完整分析案例（2026-03-18 反思）, 8 维度完整分析, 关键信号识别, 反思（核心教训）, 实际结果：1-1 平局 ✅, 比赛信息, 盘赔分析, 综合判断

### Community 131 - "深度分析"
Cohesion: 0.05
Nodes (40): 2026-10-14 比赛记忆, 待复盘, 📊 晚盘深度推演总表（法定 7 列规范）, 样本数据（结构化，供后续程序抽取）, 欧冠杯 LASK林茨 vs 利物浦（编号: 周三006 比赛ID: 3073122，开球: 2026-10-15 00:45，分析: 2026-10-14 21:40）, 欧冠杯 博德闪耀 vs 多特蒙德（编号: 周三009 比赛ID: 3073150，开球: 2026-10-15 03:00，分析: 2026-10-14 21:40）, 欧冠杯 曼彻斯特城 vs 巴黎圣日耳曼（编号: 周三011 比赛ID: 3073074，开球: 2026-10-15 03:00，分析: 2026-10-14 21:40）, 欧冠杯 皇家贝蒂斯 vs 波尔图（编号: 周三010 比赛ID: 3073140，开球: 2026-10-15 03:00，分析: 2026-10-14 21:40） (+32 more)

### Community 133 - "2784765 场（意甲 拉齐奥 1-0 AC 米兰）复盘总结"
Cohesion: 0.25
Nodes (8): 2784765 场（意甲 拉齐奥 1-0 AC 米兰）复盘总结, 主人点评, 亚盘数据, 基本面 8 维度, 核心教训, 浅盘形态判断, 盘口类型判断, 赛果验证

### Community 137 - "Page 09: Data Description (continued)"
Cohesion: 0.29
Nodes (7): Page 09: Data Description (continued), 区域 1：正文与原文标注, 区域 2：底部脚注6（续于下一页）, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 138 - "Page 25: Figures 1 and 2: Average realized returns"
Cohesion: 0.29
Nodes (7): Page 25: Figures 1 and 2: Average realized returns, 区域 1：上方Figure 1, 区域 2：下方Figure 2, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 139 - "Page 26: Figures 3 and 4: Bettor distributions"
Cohesion: 0.29
Nodes (7): Page 26: Figures 3 and 4: Bettor distributions, 区域 1：上方Figure 3, 区域 2：下方Figure 4, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 140 - "Page 23: 第 23 页"
Cohesion: 0.29
Nodes (7): Page 23: 第 23 页, 区域 1：Panel A, 区域 2：Panel B, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 141 - "Page 29: 第 29 页"
Cohesion: 0.29
Nodes (7): Page 29: 第 29 页, 区域 1：Box 1续表, 区域 2：A — Dashboard, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 142 - "Page 09: Table 1: Description of the 22 football leagues included in the dataset"
Cohesion: 0.29
Nodes (7): Page 09: Table 1: Description of the 22 football leagues included in the dataset, 区域 1：Table 1, 区域 2：Figure 1, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 143 - "Page 23: Figure 5: Average Payouts By Probability Deciles For Asian Handicap Bets"
Cohesion: 0.29
Nodes (7): Page 23: Figure 5: Average Payouts By Probability Deciles For Asian Handicap Bets, 区域 1：US市场比较续段, 区域 2：Figure 5, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 144 - "纠偏规则（corrected）：升水不等于不出、降水不等于必出，超高水禁作一票否决去水大项的死尺子"
Cohesion: 0.48
Nodes (5): 盘路母型：超高水逆向打出型（亚盘让球方挂超满水>1.05阻筹打出）, 实战判例：巴西甲巴西国际2:1科林蒂安（主让平半1.09超满水+40.8%去水第一大项打出）, Levitt (2004) 庄家非对称定价：利用>1.05超高水制造心理畏惧以阻截上盘筹码, 盘路母型：同城德比客让设障型（客队历史客胜率低但德比战客让平半挂满水设障）, 实战判例：巴西甲博塔弗戈1:2达伽马（德比战客让平半满水设障御敌2:1客胜）

### Community 150 - "Page 01: Market Efficiency and Behavioral Biases in the Sports Betting Market"
Cohesion: 0.33
Nodes (6): Page 01: Market Efficiency and Behavioral Biases in the Sports Betting Market, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 151 - "Page 02: 1 Introduction"
Cohesion: 0.33
Nodes (6): Page 02: 1 Introduction, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 152 - "Page 03: Introduction (continued)"
Cohesion: 0.33
Nodes (6): Page 03: Introduction (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 153 - "Page 04: Introduction (continued)"
Cohesion: 0.33
Nodes (6): Page 04: Introduction (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 154 - "Page 05: 2 Literature Review"
Cohesion: 0.33
Nodes (6): Page 05: 2 Literature Review, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 155 - "Page 06: Literature Review (continued)"
Cohesion: 0.33
Nodes (6): Page 06: Literature Review (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 156 - "Page 07: Literature Review (continued)"
Cohesion: 0.33
Nodes (6): Page 07: Literature Review (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 157 - "Page 10: 4 Empirical Tests of Favorite-Longshot Bias"
Cohesion: 0.33
Nodes (6): Page 10: 4 Empirical Tests of Favorite-Longshot Bias, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 158 - "Page 11: Aggregate-level Analysis (continued)"
Cohesion: 0.33
Nodes (6): Page 11: Aggregate-level Analysis (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 159 - "Page 12: Aggregate-level Analysis (continued)"
Cohesion: 0.33
Nodes (6): Page 12: Aggregate-level Analysis (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 160 - "Page 13: Aggregate-level Analysis (continued)"
Cohesion: 0.33
Nodes (6): Page 13: Aggregate-level Analysis (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 163 - "Page 16: Individual-level Analysis (continued)"
Cohesion: 0.33
Nodes (6): Page 16: Individual-level Analysis (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 164 - "Page 17: 5 Empirical Tests of Home Bias"
Cohesion: 0.33
Nodes (6): Page 17: 5 Empirical Tests of Home Bias, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 165 - "Page 18: Home Bias (continued)"
Cohesion: 0.33
Nodes (6): Page 18: Home Bias (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 166 - "Page 19: 6 Conclusion"
Cohesion: 0.33
Nodes (6): Page 19: 6 Conclusion, 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 167 - "Page 20: Conclusion (continued)"
Cohesion: 0.33
Nodes (6): Page 20: Conclusion (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 168 - "Page 22: References (continued)"
Cohesion: 0.33
Nodes (6): Page 22: References (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 169 - "Page 23: References (continued)"
Cohesion: 0.33
Nodes (6): Page 23: References (continued), 区域 1：正文与原文标注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 171 - "Page 27: Figure 5: Wagers on home-area-team matches"
Cohesion: 0.33
Nodes (6): Page 27: Figure 5: Wagers on home-area-team matches, 区域 1：Figure 5与统计框, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 172 - "Page 31: Table 5: Objective versus Implied Win Probabilities – Two-way"
Cohesion: 0.33
Nodes (6): Page 31: Table 5: Objective versus Implied Win Probabilities – Two-way, 区域 1：Table 5三组结果, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 173 - "Page 33: Table 7: Actual versus Implies Probability"
Cohesion: 0.33
Nodes (6): Page 33: Table 7: Actual versus Implies Probability, 区域 1：Table 7说明与估计, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 175 - "Page 04: 第 04 页"
Cohesion: 0.33
Nodes (6): Page 04: 第 04 页, 区域 1：单栏策略论证, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 176 - "Page 05: Methods"
Cohesion: 0.33
Nodes (6): Page 05: Methods, 区域 1：方法引言和正文, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 177 - "Page 06: 第 06 页"
Cohesion: 0.33
Nodes (6): Page 06: 第 06 页, 区域 1：样本、公式与定义, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 178 - "Page 07: 第 07 页"
Cohesion: 0.33
Nodes (6): Page 07: 第 07 页, 区域 1：分箱与错价论证, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 179 - "Page 08: 第 08 页"
Cohesion: 0.33
Nodes (6): Page 08: 第 08 页, 区域 1：期望收益公式与解释, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 180 - "Page 09: 第 09 页"
Cohesion: 0.33
Nodes (6): Page 09: 第 09 页, 区域 1：投注条件与α选择, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 181 - "Page 10: Strategy implementation"
Cohesion: 0.33
Nodes (6): Page 10: Strategy implementation, 区域 1：实时实施与结果标题, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 182 - "Page 11: Strategy Outcome"
Cohesion: 0.33
Nodes (6): Page 11: Strategy Outcome, 区域 1：回归续段、Strategy Outcome及脚注3, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 183 - "Page 12: 第 12 页"
Cohesion: 0.33
Nodes (6): Page 12: 第 12 页, 区域 1：随机模拟与赔率精度段, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 186 - "Page 17: Discussion"
Cohesion: 0.33
Nodes (6): Page 17: Discussion, 区域 1：Discussion、引言及脚注4, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 187 - "Page 18: 第 18 页"
Cohesion: 0.33
Nodes (6): Page 18: 第 18 页, 区域 1：群体预测与效率续段, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 188 - "Page 19: 第 19 页"
Cohesion: 0.33
Nodes (6): Page 19: 第 19 页, 区域 1：市场限制、法律类比及脚注5, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 190 - "Page 21: Figures and Tables"
Cohesion: 0.33
Nodes (6): Page 21: Figures and Tables, 区域 1：标题与Table 1, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 191 - "Page 26: References"
Cohesion: 0.33
Nodes (6): Page 26: References, 区域 1：悬挂缩进参考文献, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 192 - "Page 27: 第 27 页"
Cohesion: 0.33
Nodes (6): Page 27: 第 27 页, 区域 1：悬挂缩进参考文献, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 194 - "Page 01: Forecasting Soccer Matches With Betting Odds: A Tale of Two Markets"
Cohesion: 0.33
Nodes (6): Page 01: Forecasting Soccer Matches With Betting Odds: A Tale of Two Markets, 区域 1：MPRA标识、文献与存档信息, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 195 - "Page 02: Forecasting Soccer Matches With Betting Odds: A Tale of Two Markets"
Cohesion: 0.33
Nodes (6): Page 02: Forecasting Soccer Matches With Betting Odds: A Tale of Two Markets, 区域 1：题名、作者、Abstract与通讯脚注, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 196 - "Page 03: 1. Introduction"
Cohesion: 0.33
Nodes (6): Page 03: 1. Introduction, 区域 1：引言正文及脚注1–3, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 197 - "Page 04: 第 04 页"
Cohesion: 0.33
Nodes (6): Page 04: 第 04 页, 区域 1：效率与识别续段, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 198 - "Page 06: 2.2. How Asian Handicap Betting Works"
Cohesion: 0.33
Nodes (6): Page 06: 2.2. How Asian Handicap Betting Works, 区域 1：盘口规则与圆点项目, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 199 - "Page 08: 第 08 页"
Cohesion: 0.33
Nodes (6): Page 08: 第 08 页, 区域 1：最高赔率与盘口赔率分布论证, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 200 - "Page 11: 第 11 页"
Cohesion: 0.33
Nodes (6): Page 11: 第 11 页, 区域 1：组成效应、WLS及公式3, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 201 - "Page 13: 3.3. Implications of Favourite-Longshot Bias"
Cohesion: 0.33
Nodes (6): Page 13: 3.3. Implications of Favourite-Longshot Bias, 区域 1：概率与赔付推导公式4–8, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 202 - "Page 14: 3.4. Ex Ante versus Ex Post Outcomes"
Cohesion: 0.33
Nodes (6): Page 14: 3.4. Ex Ante versus Ex Post Outcomes, 区域 1：校准和实际损失检验, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 203 - "Page 16: Figure 4: Actual Ex Post Loss Rates on an Equally-Weighted Portfolio of Home, Away & Draw Bets Sorted By Ex Ante Expected Loss Rate"
Cohesion: 0.33
Nodes (6): Page 16: Figure 4: Actual Ex Post Loss Rates on an Equally-Weighted Portfolio of Home, Away & Draw Bets Sorted By Ex Ante Expected Loss Rate, 区域 1：Figure 4, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 204 - "Page 18: Asian Handicap Ends in .25"
Cohesion: 0.33
Nodes (6): Page 18: Asian Handicap Ends in .25, 区域 1：整数识别与四分盘口公式15–23, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 205 - "Page 19: Asian Handicap Ends in 0.75"
Cohesion: 0.33
Nodes (6): Page 19: Asian Handicap Ends in 0.75, 区域 1：四分盘上下侧推导公式24–32, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 206 - "Page 20: 4.2. Evidence on Predictability of Refunds"
Cohesion: 0.33
Nodes (6): Page 20: 4.2. Evidence on Predictability of Refunds, 区域 1：退款回归与脚注8/9, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 207 - "Page 21: Table 4: WLS Regression Predicting Refunds"
Cohesion: 0.33
Nodes (6): Page 21: Table 4: WLS Regression Predicting Refunds, 区域 1：Table 4, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 208 - "Page 22: 4.3. Favourite-Longshot Bias?"
Cohesion: 0.33
Nodes (6): Page 22: 4.3. Favourite-Longshot Bias?, 区域 1：赔率偏差检验及公式34, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 209 - "Page 24: Table 5: WLS Regression for Payouts for Asian Handicap Bets on Probability Decile Dummies"
Cohesion: 0.33
Nodes (6): Page 24: Table 5: WLS Regression for Payouts for Asian Handicap Bets on Probability Decile Dummies, 区域 1：Table 5, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 210 - "Page 25: 4.4. Accuracy of Probability Estimates"
Cohesion: 0.33
Nodes (6): Page 25: 4.4. Accuracy of Probability Estimates, 区域 1：总体校准、分盘型校准和脚注10, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 211 - "Page 26: Figure 6: Actual Fraction of Full Wins on Asian Handicap Bets Sorted by Estimated Probability of a Full Win"
Cohesion: 0.33
Nodes (6): Page 26: Figure 6: Actual Fraction of Full Wins on Asian Handicap Bets Sorted by Estimated Probability of a Full Win, 区域 1：Figure 6, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 212 - "Page 29: Figure 7: Losses Rates on an Equally-Weighted Portfolio of Home and Away Asian Handicap Bets By Ex Ante Expected Loss Rate"
Cohesion: 0.33
Nodes (6): Page 29: Figure 7: Losses Rates on an Equally-Weighted Portfolio of Home and Away Asian Handicap Bets By Ex Ante Expected Loss Rate, 区域 1：Figure 7, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 213 - "Page 30: 5. Conclusions"
Cohesion: 0.33
Nodes (6): Page 30: 5. Conclusions, 区域 1：结论四段, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 214 - "Page 31: References"
Cohesion: 0.33
Nodes (6): Page 31: References, 区域 1：参考文献, 布局地图, 按区域确认内容, 视觉备注, 页面目的

### Community 233 - "变动历史分析示例（大小球，必须像这样写）"
Cohesion: 0.40
Nodes (5): 变动历史分析示例（大小球，必须像这样写）, 第 10 步：风险提示, 第 7 步：赔率合理性评估, 第 8 步：赔率变动解读, 第 9 步：关键点 / 疑点 / 矛盾分析

### Community 235 - "四、Memory 写入规则"
Cohesion: 0.50
Nodes (4): 写下来 — 不要"心里记着", 四、Memory 写入规则, 每日记忆（memory/YYYY-MM-DD.md）, 长期记忆（MEMORY.md）

### Community 264 - "Page 11: 798 H. Hewamalage et al."
Cohesion: 0.67
Nodes (3): Page 11: 798 H. Hewamalage et al., Table 2: Results from several reruns of the FiLM model in the work by Zhou et al. (2022a), Table 3: Results from the naïve forecast and the Autoformer model on the exchange rate dataset

## Knowledge Gaps
- **34 isolated node(s):** `先结论后过程推送结构与4000字分段折叠规范`, `球探网5大核心接口并发直取与推演源数据装配`, `Macri (2025) 临盘洗盘期贝叶斯动态离散时间加权模型`, `物理不变量四：T0初盘→T4终盘不可逆时间因果序`, `STRATEGY.md 足球赛事盘赔分析与赛果推演系统战略大图` (+29 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 607 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **20 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Work-memory lessons

**Preferred sources** — corroborated by past sessions; start here.
- `poisson_lib.py` (2× useful, score=1.336455691) _(code changed — re-verify)_
- `赛后复盘（post-review）` (2× useful, score=1.24885729)

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)` connect `Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)` to `累计战绩`, `四维认知契约卡（Aiyer/Wheatcroft/Giacomini/Choe学术防线）`, `泊松分布λ攻防建模与波胆比分矩阵`, `极小化最大损失`, `庄家净赔付最小化（Minimax第一性原理）`, `各场景的 Subagent 用法`, `知情交易与尖锐资金`, `足球倍率全周期真实变盘时序形态学手册`, `Forecast Evaluation for Data Scientists: Common Pitfalls and Best Practices`, `比分建模与投注手册（泊松版）`, `OO-EPC去水模型（Shin/Power/Probit合成）`, `赔率分析推演十大公理与四大物理不变量`, `Egidi, Pauli & Torelli (2018) 结合历史进球数据与庄家隐含赔率的层次贝叶斯泊松模型`, `赛后复盘先审过程再揭比分与Graphify自愈闭环`, `全市场共识与定价锚点`, `纠偏规则（corrected）：平手盘主队高水不得单凭伤停直接定性为诱主而一票否决主胜，需双向核实高水阻筹属性`, `Wheatcroft (2019) 足球比赛概率预测评分规则评估：批判RPS并确立对数无知评分(IGN)`, `盘口与走势阅读手册（简版）`, `盘赔分析系统化框架（2026-03-17 整理 · 主人亲授）`, `Market Efficiency and Behavioral Biases: Evidence from an Online Betting Exchange`, `欧指1X2热门-冷门偏差（FLB：低概率十分位亏损17% vs 高概率仅亏2%，简单去水严重高估冷门）`, `盘赔分析系统化框架（2026-03-17 整理 · 主人亲授）`, `模型扩展与组合手册（除泊松之外）`, `Choe & Ramdas (2023) 跨时间与博弈论视角下的序贯预测者比较 (Operations Research)`, `盘口分类体系（主人亲授 · 2026-03-18）`, `论文库实战映射总纲 (paper-application-v2)`, `结果偏见与过程审计分离`, `Giacomini & White (2006) 条件预测能力检验 (Tests of Conditional Predictive Ability, Econometrica)`, `十步深度分析推演闭环 (基本面/伤停/泊松/欧亚大小时序/合理性/三维落槌)`, `下注决策手册（版本 1）`, `两赛季滚动样本外保序回归校准（Isotonic Regression f:[0,1]->[0.05,0.95] 阶梯单调映射与重归一化）`, `通用足球庄家倍率精算 AI 智能体体系 (Pansuan Engine)`, `Page 08: 3 Data Description`, `真实攻防压制力（滚动xG/射正/角球）结合Spike-and-Slab动态先验对泊松强度 lambda 的修正机制`, `联赛配置手册（泊松 + 盘口）`, `Page 21: References`, `Page 28: Table 1: Literature on the Efficiency of Sports Betting Markets`, `盘路母型：整球设障御敌防小胜型（让一球中低水设障+泊松共振锁1球小胜）`, `三、盘口与走势过滤危险热门`, `泊松概率计算手册（足彩用）`, `四大主动纠偏质问 (Levitt/Tversky/Gilovich/Constantinou)`, `Stable Reliability Diagrams Using CORP and Isotonic Recalibration`, `第二部分：模式二·单场【推演源数据】采集与门禁质检（阶段一专属搬运工）`, `AGENTS.md - 足彩分析工作流操作手册`, `盘路母型：豪门客战中盘跳档诱多型（Head-Fake假摔）`, `执行流程`, `无额外进球预感定理：扣除累积xG差与红牌后，庄家赔率与散户注额在进球前均无异常预测力`, `步骤 3：10 步分析过程（固定顺序）`, `倍率分析推演 (Pansuan Engine) Strategy`, `球队风格判定手册（简版）`, `Aiyer et al. (2023) 结果偏见与决策评价预注册复制与扩展研究 (N=692)`, `Forecasting Football Match Outcomes: Evidence from the 1X2 and Asian Handicap Betting Markets`, `盘路母型：均势浅盘底线低平赔型（初盘平赔<2.90+即时抬升分流两头）`, `003 场完整分析案例（2026-03-18 反思）`, `2784765 场（意甲 拉齐奥 1-0 AC 米兰）复盘总结`, `Page 09: Data Description (continued)`, `Page 25: Figures 1 and 2: Average realized returns`, `Page 26: Figures 3 and 4: Bettor distributions`, `Page 23: Figure 5: Average Payouts By Probability Deciles For Asian Handicap Bets`, `纠偏规则（corrected）：升水不等于不出、降水不等于必出，超高水禁作一票否决去水大项的死尺子`, `Page 01: Market Efficiency and Behavioral Biases in the Sports Betting Market`, `Page 02: 1 Introduction`, `Page 03: Introduction (continued)`, `Page 04: Introduction (continued)`, `Page 05: 2 Literature Review`, `Page 06: Literature Review (continued)`, `Page 07: Literature Review (continued)`, `Page 10: 4 Empirical Tests of Favorite-Longshot Bias`, `Page 11: Aggregate-level Analysis (continued)`, `Page 12: Aggregate-level Analysis (continued)`, `Page 13: Aggregate-level Analysis (continued)`, `Page 16: Individual-level Analysis (continued)`, `Page 17: 5 Empirical Tests of Home Bias`, `Page 18: Home Bias (continued)`, `Page 19: 6 Conclusion`, `Page 20: Conclusion (continued)`, `Page 22: References (continued)`, `Page 23: References (continued)`, `Page 27: Figure 5: Wagers on home-area-team matches`, `Page 31: Table 5: Objective versus Implied Win Probabilities – Two-way`, `Page 33: Table 7: Actual versus Implies Probability`, `Page 11: Strategy Outcome`, `Page 06: 2.2. How Asian Handicap Betting Works`, `Page 08: 第 08 页`, `Page 13: 3.3. Implications of Favourite-Longshot Bias`, `Page 14: 3.4. Ex Ante versus Ex Post Outcomes`, `Page 16: Figure 4: Actual Ex Post Loss Rates on an Equally-Weighted Portfolio of Home, Away & Draw Bets Sorted By Ex Ante Expected Loss Rate`, `Page 18: Asian Handicap Ends in .25`, `Page 19: Asian Handicap Ends in 0.75`, `Page 22: 4.3. Favourite-Longshot Bias?`, `Page 24: Table 5: WLS Regression for Payouts for Asian Handicap Bets on Probability Decile Dummies`, `Page 26: Figure 6: Actual Fraction of Full Wins on Asian Handicap Bets Sorted by Estimated Probability of a Full Win`, `Page 29: Figure 7: Losses Rates on an Equally-Weighted Portfolio of Home and Away Asian Handicap Bets By Ex Ante Expected Loss Rate`, `变动历史分析示例（大小球，必须像这样写）`, `Page 11: 798 H. Hewamalage et al.`?**
  _High betweenness centrality (0.395) - this node is a cross-community bridge._
- **Are the 620 inferred relationships involving `Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)` (e.g. with `2. 站在庄家视角精准预测「胜平负」的核心方法` and `跨智能体平台适配机制`) actually correct?**
  _`Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)` has 620 INFERRED edges - model-reasoned connections that need verification._
- **What connects `先结论后过程推送结构与4000字分段折叠规范`, `球探网5大核心接口并发直取与推演源数据装配`, `Macri (2025) 临盘洗盘期贝叶斯动态离散时间加权模型` to the rest of the system?**
  _34 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `累计战绩` be split into smaller, more focused modules?**
  _Cohesion score 0.10526315789473684 - nodes in this community are weakly interconnected._
- **Why does `庄家净赔付最小化（Minimax第一性原理）` connect `庄家净赔付最小化（Minimax第一性原理）` to `Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)`, `四维认知契约卡（Aiyer/Wheatcroft/Giacomini/Choe学术防线）`, `极小化最大损失`, `Page 23: 第 23 页`, `Page 29: 第 29 页`, `知情交易与尖锐资金`, `足球倍率全周期真实变盘时序形态学手册`, `纠偏规则（corrected）：升水不等于不出、降水不等于必出，超高水禁作一票否决去水大项的死尺子`, `OO-EPC去水模型（Shin/Power/Probit合成）`, `赔率分析推演十大公理与四大物理不变量`, `Egidi, Pauli & Torelli (2018) 结合历史进球数据与庄家隐含赔率的层次贝叶斯泊松模型`, `赛后复盘先审过程再揭比分与Graphify自愈闭环`, `纠偏规则（corrected）：平手盘主队高水不得单凭伤停直接定性为诱主而一票否决主胜，需双向核实高水阻筹属性`, `Wheatcroft (2019) 足球比赛概率预测评分规则评估：批判RPS并确立对数无知评分(IGN)`, `盘口与走势阅读手册（简版）`, `赔率与泊松比较：何时值得下注（案例详解）`, `盘赔分析系统化框架（2026-03-17 整理 · 主人亲授）`, `Market Efficiency and Behavioral Biases: Evidence from an Online Betting Exchange`, `欧指1X2热门-冷门偏差（FLB：低概率十分位亏损17% vs 高概率仅亏2%，简单去水严重高估冷门）`, `Page 04: 第 04 页`, `论文库实战映射总纲 (paper-application-v2)`, `Page 05: Methods`, `Page 06: 第 06 页`, `Page 07: 第 07 页`, `十步深度分析推演闭环 (基本面/伤停/泊松/欧亚大小时序/合理性/三维落槌)`, `Page 08: 第 08 页`, `Page 09: 第 09 页`, `两赛季滚动样本外保序回归校准（Isotonic Regression f:[0,1]->[0.05,0.95] 阶梯单调映射与重归一化）`, `Page 10: Strategy implementation`, `Beating the bookies with their own numbers - and how the online sports betting market is rigged`, `Page 11: Strategy Outcome`, `Page 12: 第 12 页`, `Page 17: Discussion`, `Page 18: 第 18 页`, `Page 19: 第 19 页`, `Page 21: Figures and Tables`, `Page 22: Figure 1. Bookmakers prediction power.`, `Page 26: References`, `真实攻防压制力（滚动xG/射正/角球）结合Spike-and-Slab动态先验对泊松强度 lambda 的修正机制`, `Page 27: 第 27 页`, `Page 30: Supplementary Figure 1.`, `通用足球庄家倍率精算 AI 智能体体系 (Pansuan Engine)`, `Page 15: 第 15 页`, `盘路母型：整球设障御敌防小胜型（让一球中低水设障+泊松共振锁1球小胜）`, `第二部分：模式二·单场【推演源数据】采集与门禁质检（阶段一专属搬运工）`, `盘路母型：豪门客战中盘跳档诱多型（Head-Fake假摔）`, `AGENTS.md 足彩分析工作流操作手册`, `无额外进球预感定理：扣除累积xG差与红牌后，庄家赔率与散户注额在进球前均无异常预测力`, `深度分析推送通知模板`, `Beating the bookies with their own numbers - and how the online sports betting market is rigged`, `盘路母型：均势浅盘底线低平赔型（初盘平赔<2.90+即时抬升分流两头）`?**
  _High betweenness centrality (0.159) - this node is a cross-community bridge._
- **Are the 292 inferred relationships involving `庄家净赔付最小化（Minimax第一性原理）` (e.g. with `1. 庄家运作的底层逻辑（庄家第一性原理）` and `2. 站在庄家视角精准预测「胜平负」的核心方法`) actually correct?**
  _`庄家净赔付最小化（Minimax第一性原理）` has 292 INFERRED edges - model-reasoned connections that need verification._
- **Should `Constantinou (2022) 亚洲让球盘(AH)与胜平负(1X2)足球博彩市场效率与盈利对比 (Journal of Sports Analytics)` be split into smaller, more focused modules?**
  _Cohesion score 0.04351851851851852 - nodes in this community are weakly interconnected._