# EvoOntology 环境绑定与重绑（主会话/编排器专用）

> **Owner: 主会话/编排器。** 分析师只读本文件识别“何时必须停线”，绝不执行重绑、`configure_ontology_project`、`validate_semantics` 或写本体。EvoOntology 是只读视网膜，不是思考大脑。

## 1. 固定只读入口

- 唯一入口是 `data/.evo/current.db`，它必须是指向当前场次 `data/{销售日}/{matchId}.db` 的 NTFS **硬链接**，不是副本、不是第二个库。
- 每次最终 `.db` 落盘后重建入口；`cp` 会替换 inode 并打断硬链接，禁止用复制替代。
- 只读查询打开的是入口指向的当前 `.db`，不得在入口路径上写业务数据。

## 2. 项目绑定检查

- `.evoontology/project.json` 的 `data_source` 必须是 `data/.evo/current.db` 的**绝对路径**。
- 项目换盘、换目录或换机器后，旧绝对路径会静默指向旧库；这是硬阻断条件，不是警告。
- 分析师在 Task 开始前只做一致性检查：`project.json` 的 `data_source` 与当前 `data/.evo/current.db` 的绝对路径相同。不同则立即停线，交主会话；不得在旧路径上推演。

## 3. 重绑步骤（仅主会话）

1. 确认 `data/{销售日}/{matchId}.db` 已过 `GATE_FINAL`，七表与 0 视图无异常。
2. 删除旧入口并重建硬链接（Windows NTFS）：
   ```bash
   mkdir -p data/.evo
   rm -f data/.evo/current.db
   cmd.exe /c "mklink /H data\\.evo\\current.db data\\{销售日}\\{matchId}.db"
   ```
3. 用官方 `configure_ontology_project(replace=true)` 把 `data_source` 写成当前入口的绝对路径。
4. 以现有问题重建 workload；运行 `validate_semantics`，再执行至少一次真实只读查询探针。
5. 只有 `validate_semantics` 通过且探针返回当前场次数据，才允许分析师进入 EvoOntology Task 链。

## 4. 七表或字段变更

- 在七表名与列名不变的前提下，重写当前 `.db` 后重建硬链接即可；EvoOntology 下一次只读查询会新建 SQLite 只读连接，不缓存旧值。
- 若 `ALTER`/`DROP`/`RENAME` 七表或列名，必须同步更新 Mapping 与 Evidence，再跑 `validate_semantics` 和真实探针；`validate_semantics` 只校验本体结构，不校验底层列是否存在。

## 5. 运行态提交边界

- 可提交：`active.json`、`versions/*`；`evidence.source` 用逻辑库名，不写绝对路径。
- 不提交：`project.json`、`state.json`、`workload/questions.json`、`tasks/`、`trajectories/`、`reports/`、`visualizations/`、`evolution/`。
- 不把本机绝对路径、任务轨迹或运行态回执写进可提交的本体版本。
