# `data/{销售日}/{matchId}.db`：最终七表

> 2026-10-25 起，比赛数据的唯一持久化真相是 **最终七表 SQLite**。Scrapling 只导出仓库外临时 JSONL；ETLX 在 DuckDB 临时表中解析，只把七张最终表写进 SQLite。**没有 staging 物理表，没有视图，没有 ETLX 之后的 Python 清理。**

## 1. 单工作库直接装配

```bash
mkdir -p data/.build
rm -f data/.build/build.db
py -3.13 -c "import sqlite3,pathlib; c=sqlite3.connect('data/.build/build.db'); c.executescript(pathlib.Path('data/schema.sql').read_text(encoding='utf-8')); c.close()"
ETLX="C:/Users/home/AppData/Local/etlx/1.156.1-linking/etlx-windows-linking-amd64.exe"
"$ETLX" -config data/pipeline.md -date {销售日} -file <临时.jsonl>
```

- `data/schema.sql`：只建最终 7 张业务表；全部 `STRICT`，0 视图。
- `data/pipeline.md`：`BUILD_FINAL` 用 `read_json_auto('{file}')` 读 JSONL，14 个 `CREATE TEMP TABLE` 只在内存存在；7 条 `INSERT INTO DB."<表>"` 写最终表。
- 临时表随 ETLX 连接销毁；`data/.build/build.db` 落盘时天然只有七表，不需要 `DROP`、`VACUUM` 或第二个库。
- `GATE_FINAL` 在同一工作库上核销七表、0 视图、27 条数据状态、22 条机构状态与各表非空。
- 晋升：备份旧 `data/{销售日}/{matchId}.db`，把 `data/.build/build.db` 复制到活动路径，再删除 `data/.build`。

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

`欧指变盘` = `1x2d.js` 1,074 行 + `eu_*` 端点 635 行 = 1,709 行；`来源端点` 区分来源，不按赔率相等去重。本场实际有 6 个 `eu_*` 端点，所以来源端点共 7 个；门禁按最终表实际 distinct 端点数核对，不写死 8。

## 3. 关键列与顺序

- `球队基本情况`：`数据类型` 只允许 `比赛信息`、`阵容`、`伤停`、`技术统计`、`数据状态`、`机构状态`；`数据指纹`、`采集时间` 只放在 `数据状态` 行。
- `欧指`/`欧指变盘`：21 家机构；`机构顺序` 固定为 澳彩(80)、皇冠(545)、Bet365(281)、易胜博(90)、平博(177)、香港马会(432)、威廉希尔(115)、立博(82)、伟德(81)、Interwetten(104)、Bwin(255)、SNAI(110)、必发(2)、利记(474)、沙巴(649)、马拉松(800)、必威(482)、优胜客(386)、Paddy Power(826)、10Bet(16)、中国体彩(1129)。
- `亚盘`/`亚盘变盘`/`大小球`/`大小球变盘`：7 家机构；`机构顺序` 固定为 澳彩(1)、皇冠(3)、Bet365(8)、易胜博(12)、188Bet(42)、平博(47)、香港马会(48)。
- 明细读取一律显式 `ORDER BY "变盘时间" ASC, "源序号" ASC`；不依赖物理行序，不把最新盘当第一行。
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
ORDER BY "变盘时间" ASC, "源序号" ASC;

SELECT "变盘时间", "主水", "盘口", "客水"
FROM "亚盘变盘" WHERE "机构编号" = 3
ORDER BY "变盘时间" ASC, "源序号" ASC;

SELECT "数据类型", "项目", "状态", "数据指纹", "采集时间"
FROM "球队基本情况" WHERE "数据类型" = '数据状态'
ORDER BY "项目";
```

## 6. 最终门禁

`GATE_FINAL` 是官方 `runs_as: DATA_QUALITY` 块，在 `BUILD_FINAL` 之后自动检查落盘工作库；`violations=0` 后即可晋升。门禁要求：

- 最终库只有 7 张表、0 视图，没有 `endpoint_payload`、任何 staging 表或 `v_*`。
- `球队基本情况` 行数 = 1 + `数据类型` 为阵容/伤停/技术统计的行数 + 27 + 22。
- `欧指` = 21；`欧指变盘`、`亚盘变盘`、`大小球变盘` 均非空。
- `数据状态` 27 行、27 个 distinct 来源端点；`机构状态` 22 行、22 家机构。
- `PRAGMA integrity_check` 返回 `ok`。
