#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_root"

required_files="
DESIGN.md
README.md
CHANGELOG.md
docs/design-rationale.md
docs/implementation.md
examples/README.md
references/README.md
tokens/rizum-glass.tailwind.css
tokens/rizum-glass.tokens.json
adapters/gpui/README.md
adapters/gpui/themes/rizum-glass.json
adapters/gpui/generated/rizum_glass_tokens.rs
adapters/gpui/reference-contract.schema.json
adapters/gpui/reference-contract.example.json
adapters/gpui/gallery/Cargo.toml
adapters/gpui/gallery/src/main.rs
skills/rizum-glass/SKILL.md
skills/rizum-glass/agents/openai.yaml
skills/rizum-glass/references/DESIGN.md
"

for path in $required_files; do
  if [ ! -f "$path" ]; then
    echo "Missing required file: $path" >&2
    exit 1
  fi
done

if grep -Eiq '(^|[^[:alnum:]])(system pet|system-pet|nolnol|mod marketplace)([^[:alnum:]]|$)' DESIGN.md; then
  echo "DESIGN.md contains product-specific naming" >&2
  exit 1
fi

if grep -Eiq '(PROJECT\.md|product architecture|rust core|gateway runtime)' DESIGN.md; then
  echo "DESIGN.md contains product architecture guidance" >&2
  exit 1
fi

if ! cmp -s DESIGN.md skills/rizum-glass/references/DESIGN.md; then
  echo "The Skill DESIGN.md snapshot is stale; run scripts/sync-skill.sh" >&2
  exit 1
fi

if ! grep -q 'React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass' adapters/gpui/reference-contract.schema.json; then
  echo "The GPUI reference contract no longer enforces the canonical web-first stack" >&2
  exit 1
fi

if ! grep -q 'GPUI as optional' skills/rizum-glass/SKILL.md; then
  echo "The Rizum Glass Skill no longer marks GPUI as optional" >&2
  exit 1
fi

node <<'NODE'
const fs = require("node:fs");
const theme = JSON.parse(fs.readFileSync("adapters/gpui/themes/rizum-glass.json", "utf8"));
const colors = theme.themes[0].colors;
const neutral = colors["primary.background"];
for (const variant of ["danger", "info", "success", "warning"]) {
  if (colors[`${variant}.background`] !== neutral) {
    throw new Error(`${variant} button shell must remain neutral; express semantics through pointillist accents`);
  }
}
NODE

echo "Rizum Glass repository checks passed."
