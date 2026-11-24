[中文](README.md) | [English](README.en.md)

# dev-workflow

一套让 AI 编程 agent 不跳步、不自审自批、交付可核查的开发工作流。

装上之后，你对 agent 说一句「用 dev-workflow 做 X」，它就会按固定门禁走完：写规格、先审规格、等你批准、冻结、复述确认后才写代码、换一个上下文审完工、按清单逐条验收、等你批准才合并。你只在两个地方拍板：批规格、批合并。

## 它有什么

- **7 道硬门禁**：规格审、owner 批规格、冻结、复述放行、完工审、accept 验收、owner 批合并，缺一不许往下
- **三种通道自动分流**：新功能走全流程，线上 bug 走分诊→评估→修→验→复盘，小改动走微改通道
- **模板齐全**：规格、验收清单、简报、决策页、审查简报、交付报告，开箱即填
- **零依赖可跑**：不需要任何外部服务；两个小脚本只做对账——冻结哈希防偷改规格，清单校验防空清单
- **不挑 agent**：Claude Code、Codex、Cursor、pi 等能读 SKILL.md 的 agent 都能用
- **可选扩展**：审查、账本、执行三处都是接口，想要双审、GitHub Issues、Linear、多 agent 并行再接 adapter

## 安装

```bash
git clone https://github.com/lzwmt/dev-workflow ~/.claude/skills/dev-workflow
# 或在仓库内：./install.sh
```

把 `config.example.yaml` 复制为项目里的 `config.yaml`，不填也能跑（默认单 agent + 本地账本 + 另开上下文审查）。

## 使用

在你的项目里对 agent 说：

> 用 dev-workflow 给这个项目加登录功能

详见 [examples/mini-project/](examples/mini-project/)：一个小功能从规格到合并的完整样例。

## 目录

- `SKILL.md` — 核心流程（给 agent 读）
- `templates/` — 核心 6 个模板；`templates-optional/` — 其余场景模板清单
- `scripts/` — freeze-pkg、checklist-lint
- `adapters/` — reviewer / tracker / executor 三个扩展接口
- `references/` — 可选门禁细则

## 许可证

MIT
