# Graphify MCP 工具契约（推演大脑补充）

> 本文件是 Graphify 工具契约。只通过宿主 MCP 调用，不在思维链里写伪 CLI（如 `graphify query`），不裸搜源码替代图谱。

## 1. 工具与用途

| 工具 | 用途 | 典型调用 |
| :--- | :--- | :--- |
| `query_graph` | 战前初诊与因果穿透 | `query_graph(question="...", mode="bfs", depth=2, token_budget=1500)`；异常盘口用 `mode="dfs", depth=3` |
| `get_node` | 取论文/战法节点全文与证据 | `get_node(node_id="docs_odds_winkelmann_head_fake")` 或 `get_node(label="Winkelmann (2026) 隐状态空间假摔突破形态")` |
| `shortest_path` | 欧亚背离/理论冲突找最短因果链 | `shortest_path(source="欧亚双盘背离", target="庄家净赔付最小化", undirected=true)` |
| `god_nodes` | 脱靶自愈，取图谱骨干枢纽 | `god_nodes(top_n=10)` |
| `get_community` | 看联赛/机构所在社区与宏观操盘特征 | `get_community(community_id=...)` |
| `get_neighbors` | 看特定机构节点的邻居与关联战法 | `get_neighbors(node_id=...)` |

## 2. 三个战区

- **推演前**：读 `graphify-out/reflections/LESSONS.md`，用 `god_nodes` 激活骨干；不要从零猜。
- **推演中**：当场盘口特征（客让半一满水退盘、假摔震仓、欧亚背离）用 `query_graph` / `get_node` 靶向召回；关键伤停或洗盘用 DFS 穿透因果链。
- **冲突时**：欧指与亚盘冲突，用 `shortest_path` 以“庄家净赔付最小化”收敛；让球防守底线优先于欧指表面宣传，但仍须三端落槌。

## 3. 输出纪律

- 每次引用节点必须带真实 `node_id` 或 `source_location`；不得编造论文、页码、节点。
- 图谱是关系地图，不是新门禁，也不替代当场三端计算。
- 只沉淀可复用因果机制；红牌、折射、单次失误等偶发噪音不得进化进本体。
