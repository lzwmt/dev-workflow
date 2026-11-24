---
name: dev-workflow
description: "A gated development workflow for AI coding agents: clarify -> spec + acceptance checklist -> spec review -> owner approval -> freeze -> restate-and-go -> independent review -> completion review -> acceptance -> owner-approved merge -> delivery report. Use when building a feature, fixing a delivered bug, or making a small change in any repository. Mandatory gates must not be skipped; scripts are checks, not the engine."
---

# dev-workflow

The workflow is prompt-driven. The agent does the work with its native tools
(git, test runner, sub-agents). Two small scripts only keep it honest:
`scripts/freeze-pkg.sh` and `scripts/checklist-lint.py`.

## Hard gates (never skip, in order)

1. **Spec review** — After writing the spec + checklist (templates/spec.md,
   templates/checklist.md), have a *different* context review them
   adversarially (see adapters/reviewer/). Owner approval does not replace
   this review.
2. **Owner approval** — Present a one-page decision page
   (templates/decision.md): what changes for the user, scope, risks, cost.
   No issue, no code before approval. Record the approval verbatim.
3. **Freeze** — Freeze the approved spec + checklist:
   `scripts/freeze-pkg.sh <pkg-dir> SPEC.md CHECKLIST.md`
   If a frozen file changes later, re-freeze and re-review the diff.
4. **Restate-and-go** — The executor first writes a restatement: goal,
   files it will touch, files it will not touch, how each checklist item
   will be verified, and any conflict with the brief. No code until the
   coordinator confirms there is no material divergence.
5. **Completion review** — When implementation is done, a different context
   reviews the diff against the frozen checklist. Findings must quote the
   code they cite. Fix + re-review: max 2 rounds for simple changes,
   max 3 for large/security changes, then stop and escalate to the owner.
6. **Acceptance** — Run every checklist item exactly as written and record
   command + exit code + evidence path in ACCEPT.md. Any FAIL stops the
   pipeline. Existence checks only count for file items; behaviour items
   need behavioural evidence.
7. **Owner-approved merge** — Merge only after the owner confirms (or a
   batch the owner explicitly named as unattended, with review passed,
   acceptance passed, and an independent re-run passed). Push, deploy,
   data deletion, publishing, and spending always need a separate,
   explicit owner instruction.

## Flow

clarify (ask only what is not already known, one decision page, not a
questionnaire) -> spec + checklist -> Gate 1 -> Gate 2 -> Gate 3 ->
create issue (adapters/tracker/, local markdown by default) ->
preflight (project's own checks must exit 0) -> brief
(templates/brief.md) -> Gate 4 -> implement in a git worktree ->
coordinator verifies from disk, not from the executor's report ->
Gate 5 -> Gate 6 -> Gate 7 -> delivery report (templates/delivery-report.md)

## Bug-fix entry (delivered behaviour is broken)

triage (real bug / not a bug / need info / escalate to full flow) ->
assess (read-only, must produce a failing reproduction before any fix) ->
fix (file scope is closed; widening needs re-approval) ->
test (same-surface re-run, verdict: verified / partial / failed; only
verified may merge) -> retro (why it happened, which stage missed it,
same-pattern sweep). Templates in templates-optional/.

## Micro-change channel (small, safe changes only)

All must hold: purely additive; single chain (one main file, or one
backend field + one frontend display); does not touch auth, billing,
payments, or deletion of existing data; existing tests/probes cover it;
roughly <= 30 lines. Then: checklist shrinks to 3 items, no restatement
wait, coordinator reviews the diff directly instead of queuing a review.
If the real diff exceeds the criteria, run the skipped gates afterwards.
Never shrink: coordinator's own verification, scripted merge record,
post-deploy probe.

## Rules that keep this honest

- Verify from disk and from running the code, never from a report alone.
- A command quoted in a brief must have been run once by the coordinator
  in the target repo, or cited from that repo's own docs.
- Partial pass is a fail. Totals are computed, not rewritten.
- Secrets never enter logs, commits, or reports.
- Use the project's virtual environment / toolchain; never mutate the
  system environment.
