#!/usr/bin/env bash
# freeze-pkg.sh — freeze approved spec/checklist files into a package with a
# sha256 manifest, so later silent edits are detectable.
# Usage: freeze-pkg.sh <package-dir> <file1> [file2 ...]
set -euo pipefail
OUT="${1:?usage: freeze-pkg.sh <package-dir> <file...>}"
shift
[ $# -ge 1 ] || { echo "FREEZE_FAIL: at least one file is required" >&2; exit 1; }
for f in "$@"; do
  [ -f "$f" ] || { echo "FREEZE_FAIL: file not found: $f" >&2; exit 1; }
  case "$(basename "$f")" in
    *[Cc][Hh][Ee][Cc][Kk][Ll][Ii][Ss][Tt]*)
      python3 "$(dirname "$0")/checklist-lint.py" "$f" ;;
  esac
done
mkdir -p "$OUT"
for f in "$@"; do cp "$f" "$OUT/$(basename "$f")"; done
{
  echo "# freeze manifest"
  for f in "$OUT"/*; do
    [ "$(basename "$f")" = "FREEZE.md" ] && continue
    [ "$(basename "$f")" = "manifest.txt" ] && continue
    printf "%s  %s bytes  %s\n" "$(sha256sum "$f" | cut -d' ' -f1)" "$(stat -c%s "$f")" "$(basename "$f")"
  done
} > "$OUT/FREEZE.md"
echo "FREEZE_OK dir=$OUT files=$# manifest=$OUT/FREEZE.md"
