#!/usr/bin/env bash
# Install dev-workflow as an agent skill.
# Usage: ./install.sh [target-dir]   (default: ~/.claude/skills/dev-workflow)
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
DST="${1:-$HOME/.claude/skills/dev-workflow}"
mkdir -p "$(dirname "$DST")"
if [ -e "$DST" ]; then echo "install: $DST already exists, refusing to overwrite" >&2; exit 1; fi
cp -R "$SRC" "$DST"
rm -rf "$DST/.git"
echo "Installed to $DST"
echo "Next: copy config.example.yaml to config.yaml in your project, then tell your agent: use dev-workflow to <your task>"
