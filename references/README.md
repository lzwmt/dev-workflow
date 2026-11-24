# Optional gates (not in the core)

Enable per project when the risk justifies it:

- **Dual review** — two independent reviewers for large or security
  changes; simple changes get one. Grade the change and state the basis
  when dispatching the review.
- **Lens pass** — after the main review passes, a different reviewer
  narrowly scans the same frozen snapshot for: dead tests, stale text,
  leftovers, contract-shape drift, small errors. New findings only.
- **Coverage gate** — report total coverage and changed-line coverage;
  ratchet only (never decrease) once a baseline exists.
- **Product test bench + golden-path probe** — for products with a
  production environment: an in-repo E2E bench the executor must run
  every change, and the same runner pointed at production after every
  deploy. A failed probe means the deploy is not done.
- **Review-round caps** — spec review max 2 rounds; completion fix
  rounds max 2 (3 for large/security). On the final round, a rejection
  must include a complete, executable fix proposal.
- **Acceptance cap** — max 3 full acceptance re-runs; afterwards only
  unrelated pre-existing items may be batch-disposed with written
  reasons; a real defect in this change stops and goes to the owner.
