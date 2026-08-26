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

echo "Rizum Glass repository checks passed."

