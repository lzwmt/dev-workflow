# Brief — <issue-id> <title>

Repo: <path>, worktree: <path>, branch: <name>, base: <commit>
Frozen spec/checklist: <pkg dir> (hashes in FREEZE.md). On conflict with
this brief, the frozen version wins and you stop and report.

## Restate first (before any code)
Write RESTATED.md: goal, files you will touch, files you will not touch,
how each checklist item will be verified, baseline numbers, open questions.
Then stop and wait for go.

## Goal
<one paragraph, close to the spec wording>

## Verified commands (coordinator fills this in)
Commands listed here were run once in this repo by the coordinator, or are
quoted from this repo's own docs (note the source). Anything not listed
here is a goal statement, not a ready-to-run command.
- `<command>` — source: <ran OK on YYYY-MM-DD / docs section>

## File map
- Relevant: <path — one-line role>
- Reference pattern: <file/function, or "none">
- Do not copy: <file/shape, or "none">

## Acceptance slice
<checklist items for this issue, copied verbatim>

## Boundaries
No push, no merge to main, no production/data changes, no secrets in
logs/commits/reports. If a command fails because of the environment and
you cannot fix it in 10 minutes, stop and report the exact command and
error instead of inventing a workaround.

## Done means
Local commits; RESULT.md with per-item verdicts, evidence, commit list,
and baseline comparison (baseline N + added M = expected N+M).
