# Checklist — Add a /health endpoint
mode: split

## C1 Health endpoint returns ok
type: code
verify: python -m pytest tests/test_health.py -q
evidence: tests/test_health.py

## C2 No existing behaviour changed
type: code
verify: python -m pytest -q
evidence: tests/test_health.py
