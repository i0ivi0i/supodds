# `data/{销售日}/{matchId}.db`：最终七表

> 2026-10-25 起，比赛数据的唯一持久化真相是 **最终七表 SQLite**。Staging 只做构建期解析，不是持久化分析源。

## 1. 单工作库装配

```bash
mkdir -p data/.staging
rm -f data/.staging/build.db
py -3.13 -c "import sqlite3,pathlib; c=sqlite3.connect('data/.staging/build.db'); c.executescript(pathlib.Path('data/schema.sql').read_text(encoding='utf-8')); c.close()"
ETLX="C:/Users/home/AppData/Local/etlx/1.156.1-linking/etlx-windows-linking-amd64.exe"
"$ETLX" -config data/pipeline.md -date {销售日} -file <临时.jsonl> -only ENDPOINT_PAYLOAD
"$ETLX" -config data/pipeline.md -date {销售日} -skip ENDPOINT_PAYLOAD
```

- `data/schema.sql`：同时建 staging 15 张表和最终 7 张业务表；全部 `STRICT`，0 视图。
- 只有一个工作库 `data/.staging/build.db`；没有 `schema_final.sql`、没有第二个 `final.db`。
- `PUBLISH_FINAL`：把 7 张最终表写回同一个工作库。
- `GATE_LIVE` 与 `GATE_FINAL`：`violations=0` 后，删除 staging 视图与 staging 表；`VACUUM` 回收空闲页；只留七张业务表。
- 晋升：备份旧 `data/{销售日}/{matchId}.db`，再把清理后的 `build.db` 复制到活动路径。

清理命令见 `skills/match-scraper/SKILL.md`。清理后再跑一次 `-only GATE_FINAL`，最后复制到 `data/{销售日}/{matchId}.db`。

## 2. 最终七表

| 表 | 一行代表 | 本场样本 |
| :--- | :--- | ---: |
| `球队基本情况` | 比赛、球员、伤停、技术统计、端点状态、机构状态 | 375 |
| `欧指` | 一家机构的欧指初即盘 | 21 |
| `欧指变盘` | 一条源欧指变盘记录 | 1,709 |
| `亚盘` | 一家机构的一个亚盘报价 | 22 |
| `亚盘变盘` | 一条源亚盘变盘记录 | 348 |
| `大小球` | 一家机构的一个大小球报价 | 24 |
| `大小球变盘` | 一条源大小球变盘记录 | 262 |

`球队基本情况` = 1 比赛信息 + 阵容 + 伤停 + 技术统计 + 27 数据状态 + 22 机构状态。本场为 1+40+9+276+27+22=375。阵型源值为空，不生成阵型空行。

`欧指变盘` = `1x2d.js` 1,074 行 + `eu_*` 端点 635 行 = 1,709 行；`来源端点` 区分来源，不按赔率相等去重。本场实际有 6 个 `eu_*` 端点，所以来源端点共 7 个；门禁按 staging 的实际 distinct 端点数核对，不写死 8。

## 3. 关键列与顺序

- `球队基本情况`：`数据类型` 只允许 `比赛信息`、`阵容`、`伤停`、`技术统计`、`数据状态`、`机构状态`；`数据指纹`、`采集时间` 只放在 `数据状态` 行。
- `欧指`/`欧指变盘`：21 家机构；`机构顺序` 固定为 澳彩(80)、皇冠(545)、Bet365(281)、易胜博(90)、平博(177)、香港马会(432)、威廉希尔(115)、立博(82)、伟德(81)、Interwetten(104)、Bwin(255)、SNAI(110)、必发(2)、利记(474)、沙巴(649)、马拉松(800)、必威(482)、优胜客(386)、Paddy Power(826)、10Bet(16)、中国体彩(1129)。
- `亚盘`/`亚盘变盘`/`大小球`/`大小球变盘`：7 家机构；`机构顺序` 固定为 澳彩(1)、皇冠(3)、Bet365(8)、易胜博(12)、188Bet(42)、平博(47)、香港马会(48)。
- 明细读取一律显式 `ORDER BY "机构顺序", "变盘时间", "源序号"`；不依赖 SQLite 物理行序。
- `源序号` 是 ETLX 源表技术行号，不是球探字段；只做同一分钟稳定排序，不代替 `变盘时间`。
- `盘口` 保留源端文本（如 `1/1.5`），不转成自算数字。

## 4. 原值直搬

七表只做源值投影：不写 `MIN/MAX/COUNT/SUM/AVG`、概率换算、缺失值填充、跨行聚合或预测列。`机构` 中文名和 `机构顺序` 只是显示标签，不改变数值。统计和推演由外部 AI 读取原值后现场完成。

## 5. EvoOntology 边界

EvoOntology v6 的 34 条映射全部指向这 7 张表；`sqlite_table` 是唯一定位方式，不再使用 `v_*` 视图。EvoOntology 只做只读看数，不思考、不评分、不推演。

查询示例：

```sql
SELECT "数据类型", "联赛", "主队", "客队", "队伍", "身份", "姓名", "伤停原因"
FROM "球队基本情况" ORDER BY "数据类型", "队伍", "源序号";

SELECT "机构编号", "机构", "最新主胜", "最新平局", "最新客胜"
FROM "欧指" ORDER BY "机构顺序";

SELECT "变盘时间", "主胜赔率", "平局赔率", "客胜赔率"
FROM "欧指变盘" WHERE "机构编号" = 545
ORDER BY "变盘时间", "源序号" DESC;

SELECT "变盘时间", "主水", "盘口", "客水"
FROM "亚盘变盘" WHERE "机构编号" = 3
ORDER BY "变盘时间", "源序号" DESC;

SELECT "数据类型", "项目", "状态", "数据指纹", "采集时间"
FROM "球队基本情况" WHERE "数据类型" = '数据状态'
ORDER BY "项目";
```

## 6. 最终门禁（清理前）

`GATE_FINAL` 在清理前检查七表事实；`violations=0` 后执行清理。清理只删除 staging，不改七表数据；清理后只做只读对象清单与行数复核：

- 最终库只有 7 张表、0 视图，没有 `endpoint_payload`、源表或 `v_*`。
- `球队基本情况` 行数 = 1 + staging `lineup` + `injury` + `team_stats` + 27 + 22。
- `欧指` = 21；`欧指变盘` = staging `euro_history` + `eu_detail_history`。
- `亚盘` / `大小球` 非空；`亚盘变盘` = staging `ah_history`；`大小球变盘` = staging `ou_history`。
- `数据状态` 27 行、27 个 distinct 来源端点；`机构状态` 22 行、22 家机构。
- `PRAGMA integrity_check` 返回 `ok`。
