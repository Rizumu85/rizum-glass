#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root"

mkdir -p tokens
npx -y @google/design.md export DESIGN.md --format css-tailwind > tokens/rizum-glass.tailwind.css
npx -y @google/design.md export DESIGN.md --format dtcg > tokens/rizum-glass.tokens.json
node scripts/export-gpui-theme.mjs
sh scripts/sync-skill.sh

echo "Exported web tokens, GPUI adapter assets, and the skill snapshot from DESIGN.md."
