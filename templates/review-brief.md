# Review brief — <issue-id> round <n> (<spec | completion | re-review>)

## What to review
One line: what, which range (<base>..<tip> for completion reviews).
The frozen snapshot is authoritative; cite its FREEZE.md hash.

## Materials (one judgement per line)
Format: `- <judgement> | basis: `file1`, `file2`` — every line must name
at least one file included in the review package.

- <judgement> | basis: `SPEC.md`, `CHECKLIST.md`

## Exclusions
Files intentionally not in the package, each with a reason. None = delete this section.
- `path` — <reason>

## Step zero (do not skip)
Check material completeness first. If anything needed is missing, write
MATERIALS-MISSING.md (missing what / which judgement needs it / where to
get it) and stop. Do not guess.

## Focus
<one or two lines: this change's real risk points>

## Mandatory checks (a pass must address every one)
1. Scope: does the change stay inside the frozen spec/checklist, item by item?
2. Negative cases: for each behaviour item, is there a failing/edge case,
   and is it handled or explicitly out of scope?
3. Runnable verification: does every checklist `verify:` command actually
   run as written in this environment? Name any that cannot.
4. Evidence honesty: does the evidence match the claims (real outputs,
   this run, this code) — or is anything recycled, partial, or substituted?
A verdict of "pass" with zero findings is only valid if the report states,
per point above, what was checked and what was seen. A bare "looks good"
is not a review.

## Report format
Verdict first (pass | conditional pass | reject). Then findings, one per
line: level / location / quote (verbatim) / evidence / counter-evidence /
suggestion. Read-only: do not modify code. The report file is the delivery;
a chat reply alone does not count.
