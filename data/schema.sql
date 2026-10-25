-- Seven final tables only. ETLX reads the Scrapling JSONL directly.

-- Creation order is the drawer order: 球队基本情况 → 欧指 → 欧指变盘 → 亚盘 → 亚盘变盘 → 大小球 → 大小球变盘.

CREATE TABLE "球队基本情况" (
  "比赛ID" TEXT NOT NULL,
  "数据类型" TEXT NOT NULL CHECK ("数据类型" IN ('比赛信息', '阵容', '伤停')),
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
  "位置" TEXT,
  "伤停原因" TEXT,
  PRIMARY KEY ("比赛ID", "数据类型", "队伍", "身份", "姓名")
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
