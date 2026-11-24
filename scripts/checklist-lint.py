#!/usr/bin/env python3
"""checklist-lint.py — validate an acceptance checklist.

Format: a header, then one section per item:
    ## C1 Short title
    type: code | ui
    verify: <command or concrete manual procedure>
    evidence: <repo-relative path>

Every item needs a `type:` and a `verify:` line. Exits 1 on any failure.
Usage: checklist-lint.py CHECKLIST.md
"""
import re
import sys

def main() -> int:
    if len(sys.argv) != 2:
        print("usage: checklist-lint.py CHECKLIST.md", file=sys.stderr)
        return 2
    path = sys.argv[1]
    text = open(path, encoding="utf-8").read()
    parts = re.split(r"(?m)^##\s+", text)[1:]
    items = []
    for part in parts:
        lines = part.splitlines()
        if lines and lines[0].strip():
            items.append((lines[0].strip().split()[0], part))
    if not items:
        print(f"CHECKLIST_FAIL: {path}: no '## <id>' item sections found")
        return 1
    bad = []
    for item_id, body in items:
        if not re.search(r"(?mi)^\s*type:\s*(code|ui)\s*$", body):
            bad.append(f"{item_id}: missing 'type: code|ui'")
        if not re.search(r"(?mi)^\s*verify:\s*\S+", body):
            bad.append(f"{item_id}: missing 'verify:' line")
    if bad:
        print(f"CHECKLIST_FAIL: {path}: " + "; ".join(bad))
        return 1
    print(f"CHECKLIST_OK: {path}: items={len(items)}")
    return 0

if __name__ == "__main__":
    sys.exit(main())
