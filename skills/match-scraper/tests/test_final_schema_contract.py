import re
import sqlite3
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
SCHEMA = ROOT / "data" / "schema.sql"
PIPELINE = ROOT / "data" / "pipeline.md"


class FinalSchemaContractTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.schema = SCHEMA.read_text(encoding="utf-8")
        cls.pipeline = PIPELINE.read_text(encoding="utf-8")

    def setUp(self):
        self.conn = sqlite3.connect(":memory:")
        self.conn.executescript(self.schema)

    def tearDown(self):
        self.conn.close()

    def test_schema_contains_seven_final_tables_and_zero_views(self):
        tables = {
            row[0]
            for row in self.conn.execute(
                "SELECT name FROM sqlite_master WHERE type = 'table'"
            )
        }
        self.assertEqual(
            set(
                {
                    "球队基本情况",
                    "欧指",
                    "欧指变盘",
                    "亚盘",
                    "亚盘变盘",
                    "大小球",
                    "大小球变盘",
                }
            )
            & tables,
            {"球队基本情况", "欧指", "欧指变盘", "亚盘", "亚盘变盘", "大小球", "大小球变盘"},
        )
        views = self.conn.execute(
            "SELECT name FROM sqlite_master WHERE type = 'view'"
        ).fetchall()
        self.assertEqual(views, [])

    def test_final_schema_is_strict_and_has_stable_columns(self):
        self.assertIn("STRICT", self.schema.upper())
        expected = {
            "球队基本情况": {"数据类型", "项目", "指标", "数值", "文本值", "数据指纹", "采集时间", "来源端点"},
            "欧指": {"机构顺序", "最新主胜", "最新平局", "最新客胜", "来源端点"},
            "欧指变盘": {"机构顺序", "源序号", "变盘时间", "主胜赔率", "平局赔率", "客胜赔率", "来源端点"},
            "亚盘": {"机构顺序", "盘口序号", "源序号", "最新盘口"},
            "亚盘变盘": {"机构顺序", "源序号", "变盘时间", "主水", "盘口", "客水"},
            "大小球": {"机构顺序", "盘口序号", "源序号", "最新盘口"},
            "大小球变盘": {"机构顺序", "源序号", "变盘时间", "大球", "盘口", "小球"},
        }
        for table, columns in expected.items():
            actual = {
                row[1]
                for row in self.conn.execute(f'PRAGMA table_info("{table}")')
            }
            self.assertTrue(columns.issubset(actual), table)
        self.assertNotIn("CREATE VIEW", self.schema.upper())

    def test_team_info_rejects_duplicate_source_key(self):
        sql = """
            INSERT INTO "球队基本情况" (
              "比赛ID", "数据类型", "队伍", "身份", "姓名", "项目",
              "源序号", "来源端点"
            ) VALUES ('3018847', '阵容', '主队', '首发', '古拉西', '', 0, 'odds.html')
        """
        self.conn.execute(sql)
        with self.assertRaises(sqlite3.IntegrityError):
            self.conn.execute(sql)

    def test_publish_final_does_not_compute_business_values(self):
        publish = self.pipeline.split("name: PUBLISH_FINAL", 1)[1].split("name: VIEWS", 1)[0]
        for token in ("MIN(", "MAX(", "SUM(", "AVG("):
            self.assertNotIn(token, publish.upper(), token)
        self.assertEqual(publish.count('INSERT INTO DB."'), 7)


if __name__ == "__main__":
    unittest.main()
