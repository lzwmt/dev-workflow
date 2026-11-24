# Adapters

The core runs with zero external services. Each integration point is an
interface with a built-in default; replace it only when you need more.

## reviewer/ — who reviews
Default: `prompt-only` — a fresh context (sub-agent or a second session)
with the review brief, read-only, report file as delivery.
Alternatives: a second model/agent CLI, or an external review API.
Contract: input = review brief + frozen package; output = REPORT file
with verdict + findings (level/location/verbatim quote/evidence).

## tracker/ — where issues live
Default: `local` — one markdown file per issue under `issues/`.
Alternatives: GitHub Issues, Linear.
Contract: create issue, move status, close with a comment linking the
delivery report.

## executor/ — who writes code
Default: `single` — the current agent, in a git worktree.
Alternatives: an external agent CLI, or a multi-agent session manager.
Contract: input = brief + frozen package; output = commits + RESULT.md;
must restate and wait for go before writing code.
