#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skill_dir="$repo_root/skills/rizum-glass"

mkdir -p "$skill_dir/references"
cp "$repo_root/DESIGN.md" "$skill_dir/references/DESIGN.md"

echo "Synchronized DESIGN.md into the Rizum Glass skill."
