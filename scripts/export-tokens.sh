#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root"

mkdir -p tokens
npx -y --package=@google/design.md designmd export DESIGN.md --format css-tailwind > tokens/rizum-glass.tailwind.css
npx -y --package=@google/design.md designmd export DESIGN.md --format dtcg > tokens/rizum-glass.tokens.json
node scripts/export-gpui-theme.mjs
node scripts/export-gpuix-theme.mjs
sh scripts/sync-skill.sh

echo "Exported web, GPUIX, direct GPUI, and skill assets from DESIGN.md."
