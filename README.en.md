[中文](README.md) | [English](README.en.md)

# dev-workflow

A gated development workflow for AI coding agents: no skipped steps, no
self-review, verifiable delivery.

Tell your agent "use dev-workflow to do X" and it follows fixed gates:
spec first, spec reviewed by a different context, your approval, freeze,
restate-and-go before any code, an independent completion review,
per-item acceptance, and a merge only with your approval. You decide at
exactly two points: approving the spec, and approving the merge.

## What you get

- **7 hard gates**: spec review, owner spec approval, freeze,
  restate-and-go, completion review, acceptance, owner merge approval
- **Three lanes**: full flow for features, a 5-step lane for delivered
  bugs (triage, assess, fix, test, retro), a micro lane for small safe changes
- **Templates included**: spec, acceptance checklist, brief, decision
  page, review brief, delivery report
- **Zero-dependency core**: two small scripts only keep score — a freeze
  hash so specs cannot be silently edited, and a checklist lint so
  checklists cannot be empty theatre
- **Agent-agnostic**: works with any agent that can read a SKILL.md
- **Optional adapters**: reviewer / tracker / executor are interfaces;
  add dual review, GitHub Issues, Linear, or multi-agent execution later

## Install

```bash
git clone https://github.com/lzwmt/dev-workflow ~/.claude/skills/dev-workflow
```

Copy `config.example.yaml` to `config.yaml` in your project. Defaults
(single agent, local markdown tracker, fresh-context review) work as-is.

## Example

See [examples/mini-project/](examples/mini-project/) for one small
feature carried from spec to merge.

## License

MIT
