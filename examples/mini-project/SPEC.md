# Spec — Add a /health endpoint

## Goal (one paragraph, plain language)
The service has no way for a load balancer to tell whether it is alive.
Add a `GET /health` endpoint that returns HTTP 200 with `{"status":"ok"}`
while the process can serve requests.

## User impact
Operators and the load balancer, on every deploy: failed instances are
taken out of rotation automatically instead of receiving traffic.

## Scope
- In: one route, one test.
- Out (explicitly not doing): dependency checks (DB/queue), auth, metrics.

## Design
Add the route next to the existing routes in `src/server.py`. No new
dependencies. The handler returns a constant body; liveness only.

## Risks & rollback
Risk: route name collision. Rollback: revert the single commit.

## Open questions
None.
