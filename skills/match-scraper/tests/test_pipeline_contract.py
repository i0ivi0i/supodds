import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
PIPELINE = ROOT / "data" / "pipeline.md"

TEMP_NAMES = (
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
)

FINAL_NAMES = (
    "球队基本情况",
    "欧指",
    "欧指变盘",
    "亚盘",
    "亚盘变盘",
    "大小球",
    "大小球变盘",
)


class PipelineContractTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.text = PIPELINE.read_text(encoding="utf-8")

    def test_direct_build_uses_one_working_database(self):
        targets = re.findall(r"ATTACH '([^']+)' AS DB", self.text)
        self.assertEqual(set(targets), {"data/.build/build.db"})

    def test_jsonl_is_read_directly_into_temporary_tables(self):
        self.assertIn("name: BUILD_FINAL", self.text)
        self.assertIn("read_json_auto('{file}')", self.text)
        self.assertEqual(self.text.count("CREATE TEMP TABLE "), 14)
        for name in TEMP_NAMES:
            self.assertIn(f"CREATE TEMP TABLE {name}", self.text)
        self.assertEqual(self.text.count('INSERT INTO DB."'), 7)
        for name in FINAL_NAMES:
            self.assertIn(f'INSERT INTO DB."{name}"', self.text)

    def test_no_persistent_staging_or_cleanup_steps(self):
        self.assertNotIn("name: PUBLISH_FINAL", self.text)
        self.assertNotIn("name: VIEWS", self.text)
        self.assertNotIn("name: CLEANUP", self.text)
        self.assertNotIn("VACUUM", self.text.upper())
        self.assertNotIn('INSERT INTO DB."endpoint_payload"', self.text)
        self.assertNotIn('INSERT INTO DB."euro_history"', self.text)

    def test_lineup_and_team_stats_read_source_payloads(self):
        for field in (
            "homePlayerList",
            "guestPlayerList",
            "homeBakPlayerList",
            "guestBakPlayerList",
            "homeFormation",
            "guestFormation",
        ):
            self.assertIn(field, self.text)
        self.assertIn("lastXgTechStat", self.text)
        self.assertIn("json_extract(item, '$.home')", self.text)
        self.assertIn("json_extract(item, '$.away')", self.text)

    def test_team_info_excludes_technical_and_bookmaker_metadata(self):
        insert = self.text.split('INSERT INTO DB."球队基本情况"', 1)[1].split(";", 1)[0]
        self.assertNotIn("'技术统计'", insert)
        self.assertNotIn("'机构状态'", insert)
        self.assertNotIn("FROM team_stats", insert)
        self.assertNotIn("FROM bookmaker_slots", insert)
        self.assertNotIn("数据指纹", insert)
        self.assertNotIn("采集时间", insert)

    def test_euro_detail_has_clear_columns_and_chronological_order(self):
        block = self.text.split('INSERT INTO DB."欧指变盘"', 1)[1].split(";", 1)[0]
        for column in ("主胜赔率", "平局赔率", "客胜赔率"):
            self.assertIn(column, block)
        self.assertIn("WHEN 80 THEN 1", block)
        self.assertIn("WHEN 1129 THEN 21", block)
        self.assertIn("ORDER BY 4, 6 ASC, 5 DESC", block)

    def test_handicap_and_over_under_detail_use_fixed_institution_order(self):
        for table in ("亚盘变盘", "大小球变盘"):
            block = self.text.split(f'INSERT INTO DB."{table}"', 1)[1].split(";", 1)[0]
            self.assertIn("WHEN 1 THEN 1", block, table)
            self.assertIn("WHEN 48 THEN 7", block, table)
            self.assertIn("ORDER BY 4, 7 ASC, 5 DESC", block, table)

    def test_gate_checks_seven_tables_and_no_views(self):
        gate = self.text.split("name: GATE_FINAL", 1)[1]
        for key in (
            "final_table_total",
            "final_table_count",
            "final_view_count",
            "final_identity_match",
            "euro_rows",
            "euro_history_rows",
            "asian_rows",
            "asian_history_rows",
            "ou_rows",
            "ou_history_rows",
            "team_info_rows",
            "team_info_types",
        ):
            self.assertIn(key, gate)
        self.assertIn("duckdb_tables()", gate)
        self.assertIn("duckdb_views()", gate)


if __name__ == "__main__":
    unittest.main()
