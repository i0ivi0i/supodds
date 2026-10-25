import sqlite3
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
SCHEMA = ROOT / "data" / "schema.sql"

FINAL_NAMES = {
    "球队基本情况",
    "欧指",
    "欧指变盘",
    "亚盘",
    "亚盘变盘",
    "大小球",
    "大小球变盘",
}

STAGING_NAMES = {
    "endpoint_payload",
    "match_meta",
    "euro_snapshot",
    "euro_history",
    "asian_odds",
    "over_under",
    "bookmaker_slots",
    "ah_history",
    "ou_history",
    "eu_detail_history",
    "injury",
    "lineup",
    "team_stats",
    "endpoint_parse_status",
    "build_manifest",
}


class SchemaContractTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.schema = SCHEMA.read_text(encoding="utf-8")

    def setUp(self):
        self.conn = sqlite3.connect(":memory:")
        self.conn.executescript(self.schema)

    def tearDown(self):
        self.conn.close()

    def _tables(self):
        return {
            row[0]
            for row in self.conn.execute(
                "SELECT name FROM sqlite_master WHERE type = 'table'"
            )
        }

    def test_schema_creates_tables_in_drawer_order(self):
        actual = [
            row[0]
            for row in self.conn.execute(
                "SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY rowid"
            )
        ]
        self.assertEqual(
            actual,
            [
                "球队基本情况",
                "欧指",
                "欧指变盘",
                "亚盘",
                "亚盘变盘",
                "大小球",
                "大小球变盘",
            ],
        )

    def test_schema_has_exactly_seven_final_tables(self):
        self.assertEqual(self._tables(), FINAL_NAMES)
        self.assertNotIn("CREATE VIEW", self.schema.upper())

    def test_schema_has_no_persistent_staging_tables(self):
        self.assertEqual(self._tables() & STAGING_NAMES, set())

    def test_final_tables_have_stable_fact_columns(self):
        expected = {
            "球队基本情况": {
                "比赛ID", "数据类型", "联赛", "主队", "客队",
                "开球时间", "竞彩编号", "销售日", "队伍", "身份",
                "姓名", "伤停原因",
            },
            "欧指": {
                "比赛ID", "机构编号", "机构", "机构顺序",
                "初盘主胜", "初盘平局", "初盘客胜", "初盘返还率(%)",
                "最新主胜", "最新平局", "最新客胜", "最新返还率(%)",
                "来源端点",
            },
            "欧指变盘": {
                "比赛ID", "机构编号", "机构", "机构顺序", "源序号",
                "变盘时间", "主胜赔率", "平局赔率", "客胜赔率",
                "凯利主胜", "凯利平局", "凯利客胜", "来源端点",
            },
            "亚盘": {
                "比赛ID", "机构编号", "机构", "机构顺序",
                "盘口序号", "源序号", "初盘主水", "初盘盘口", "初盘客水",
                "最新主水", "最新盘口", "最新客水", "更新时间",
            },
            "亚盘变盘": {
                "比赛ID", "机构编号", "机构", "机构顺序", "源序号",
                "状态", "变盘时间", "主水", "盘口", "客水",
            },
            "大小球": {
                "比赛ID", "机构编号", "机构", "机构顺序",
                "盘口序号", "源序号", "初盘大球", "初盘盘口", "初盘小球",
                "最新大球", "最新盘口", "最新小球", "更新时间",
            },
            "大小球变盘": {
                "比赛ID", "机构编号", "机构", "机构顺序", "源序号",
                "状态", "变盘时间", "大球", "盘口", "小球",
            },
        }
        forbidden = {
            "prediction", "recommendation", "confidence", "verdict", "score",
            "预测", "推荐", "信心", "结论", "评分",
        }
        for table, columns in expected.items():
            actual = {
                row[1]
                for row in self.conn.execute(f'PRAGMA table_info("{table}")')
            }
            self.assertTrue(columns.issubset(actual), table)
            self.assertFalse(actual & forbidden, table)

    def test_team_info_rejects_duplicate_source_key(self):
        sql = """
            INSERT INTO "球队基本情况" (
              "比赛ID", "数据类型", "队伍", "身份", "姓名"
            ) VALUES ('3018847', '阵容', '主队', '首发', '古拉西')
        """
        self.conn.execute(sql)
        with self.assertRaises(sqlite3.IntegrityError):
            self.conn.execute(sql)


if __name__ == "__main__":
    unittest.main()
