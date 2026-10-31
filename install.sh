#!/usr/bin/env bash
# Install the ctf-ros skill into an agent skills directory.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_ROOT="${DSH_SKILLS_DIR:-$HOME/.dsh/skills}"
DEST="$DEST_ROOT/ctf-ros"

FILES="SKILL.md recon.md tooling.md ctf-and-labs.md cves-and-incidents.md hardening.md resources.md"

for f in $FILES; do
  if [ ! -f "$SRC/$f" ]; then
    echo "missing $f in $SRC - run this from a clone of the repo" >&2
    exit 1
  fi
done

mkdir -p "$DEST"
for f in $FILES; do
  cp "$SRC/$f" "$DEST/$f"
done

echo "installed ctf-ros -> $DEST"
ls -1 "$DEST"
echo
echo "restart or start a new agent session so the skill catalog reloads."
