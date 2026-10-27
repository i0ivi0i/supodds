import re
import sqlite3
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
PIPELINE = ROOT / "data" / "pipeline.md"


def final_schema_sql():
    text = PIPELINE.read_text(encoding="utf-8")
    statements = re.findall(r"CREATE TABLE .*?\) STRICT;", text, re.S)
    if len(statements) != 7:
        raise AssertionError(f"expected 7 final table DDL blocks, got {len(statements)}")
    return "\n".join(statements)


class FinalSchemaContractTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.schema = final_schema_sql()
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
            tables,
            {"球队基本情况", "欧指", "欧指变盘", "亚盘", "亚盘变盘", "大小球", "大小球变盘"},
        )
        views = self.conn.execute(
            "SELECT name FROM sqlite_master WHERE type = 'view'"
        ).fetchall()
        self.assertEqual(views, [])

    def test_final_schema_is_strict_and_has_stable_columns(self):
        self.assertIn("STRICT", self.schema.upper())
        expected = {
            "球队基本情况": {"数据类型", "队伍", "身份", "姓名", "伤停原因"},
            "欧指": {"最新主胜", "最新平局", "最新客胜", "来源端点"},
            "欧指变盘": {"变盘时间", "主胜赔率", "平局赔率", "客胜赔率", "来源端点"},
            "亚盘": {"最新盘口"},
            "亚盘变盘": {"变盘时间", "主水", "盘口", "客水"},
            "大小球": {"最新盘口"},
            "大小球变盘": {"变盘时间", "大球", "盘口", "小球"},
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
              "比赛ID", "数据类型", "队伍", "身份", "姓名", "号码"
            ) VALUES ('3018847', '阵容', '主队', '首发', '古拉西', '1')
        """
        self.conn.execute(sql)
        with self.assertRaises(sqlite3.IntegrityError):
            self.conn.execute(sql)

    def test_team_info_allows_same_name_with_different_numbers(self):
        sql = """
            INSERT INTO "球队基本情况" (
              "比赛ID", "数据类型", "队伍", "身份", "姓名", "号码"
            ) VALUES ('3086941', '伤停', '云达不莱梅', '伤停', '穆萨', ?)
        """
        self.conn.execute(sql, ("16",))
        self.conn.execute(sql, ("29",))
        count = self.conn.execute(
            'SELECT COUNT(*) FROM "球队基本情况" WHERE "姓名" = ?', ("穆萨",)
        ).fetchone()[0]
        self.assertEqual(count, 2)

    def test_build_final_does_not_compute_business_values(self):
        build = self.pipeline.split("name: BUILD_FINAL", 1)[1].split("name: GATE_FINAL", 1)[0]
        for token in ("MIN(", "MAX(", "SUM(", "AVG("):
            self.assertNotIn(token, build.upper(), token)
        self.assertEqual(build.count('INSERT INTO DB."'), 7)


if __name__ == "__main__":
    unittest.main()
