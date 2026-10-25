import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
SKILLS = [
    ROOT / "skills" / "deep-analysis" / "SKILL.md",
    ROOT / "skills" / "recommendation" / "SKILL.md",
    ROOT / "skills" / "post-review" / "SKILL.md",
]
FINAL_TABLES = {"球队基本情况", "欧指", "欧指变盘", "亚盘", "亚盘变盘", "大小球", "大小球变盘"}
FORBIDDEN_READ_TOKENS = ("endpoint_payload", "v_bookmaker_slots", "v_euro_snapshot", "v_ah_history", "v_ou_history", "v_team_stats")


class DownstreamContractTest(unittest.TestCase):
    def test_skills_gate_on_final_status_rows(self):
        for path in SKILLS:
            text = path.read_text(encoding="utf-8")
            self.assertIn("数据状态", text, path.name)
            for token in FORBIDDEN_READ_TOKENS:
                self.assertNotIn(token, text, f"{path.name}: {token}")
        for path in SKILLS[:1] + SKILLS[2:]:
            self.assertIn("机构状态", path.read_text(encoding="utf-8"), path.name)

    def test_evo_mappings_point_to_final_tables_only(self):
        base = ROOT / ".evoontology"
        active = json.loads((base / "active.json").read_text(encoding="utf-8"))
        self.assertEqual(active["active_version"], "ontology_v6")
        data = json.loads((base / "versions" / "ontology_v6" / "mappings.json").read_text(encoding="utf-8"))
        mappings = data if isinstance(data, list) else data["mappings"]
        self.assertEqual(len(mappings), 34)
        for mapping in mappings:
            self.assertEqual(mapping["database_source"], "sqlite_table")
            self.assertIn(mapping["table"], FINAL_TABLES)
            serialized = json.dumps(mapping, ensure_ascii=False)
            self.assertNotIn("v_", serialized)


if __name__ == "__main__":
    unittest.main()
