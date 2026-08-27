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
references/rizum-glass-ui-gallery-v11.html
references/rizum-glass-ui-gallery-dark-v11.html
references/archive/README.md
archive/darkroom/README.md
archive/darkroom/transfer-test-darkroom-dark-v7.html
tokens/rizum-glass.tailwind.css
tokens/rizum-glass.tokens.json
adapters/gpui/README.md
adapters/gpui/themes/rizum-glass.json
adapters/gpui/generated/rizum_glass_tokens.rs
adapters/gpui/reference-contract.schema.json
adapters/gpui/reference-contract.example.json
adapters/gpui/gallery/Cargo.toml
adapters/gpui/gallery/src/main.rs
adapters/winui/README.md
adapters/winui/HANDOFF.md
adapters/winui/generated/RizumGlass.Tokens.xaml
adapters/winui/generated/RizumGlass.Motion.cs
adapters/winui/reference-contract.schema.json
adapters/winui/reference-contract.example.json
skills/rizum-glass/SKILL.md
skills/rizum-glass/agents/openai.yaml
skills/rizum-glass/references/DESIGN.md
skills/rizum-glass/references/winui-translation.md
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

for gallery in references/rizum-glass-ui-gallery-v11.html references/rizum-glass-ui-gallery-dark-v11.html; do
  if grep -Eiq '(<select|data-p="mods"|mods\(\)|modDetail\(\)|modStudio\(\)|扩展中心|data-p="skins"|skins\(\)|skinEditor\(\)|外观包)' "$gallery"; then
    echo "$gallery contains a native select or a retired unfinished component family" >&2
    exit 1
  fi
  if ! grep -q 'role="combobox"' "$gallery"; then
    echo "$gallery is missing the adapted Rizum Glass Select reference" >&2
    exit 1
  fi
  if grep -Eq '(data-w=|--ob-w|dataset\.w([^A-Za-z]|$))' "$gallery"; then
    echo "$gallery still contains per-step onboarding width changes" >&2
    exit 1
  fi
done

dark_gallery=references/rizum-glass-ui-gallery-dark-v11.html
if ! grep -Fq 'Dark text uses solid semantic roles' "$dark_gallery" \
  || ! grep -Fq '[class~="text-[#a1a1aa]/30"]' "$dark_gallery" \
  || ! grep -Fq '[class~="text-white/30"]' "$dark_gallery" \
  || ! grep -Fq '.nc .nt { opacity: .9; }' "$dark_gallery" \
  || ! grep -Fq '.search-bar { background: transparent; }' "$dark_gallery" \
  || ! grep -Fq '.search-footer { background: transparent; }' "$dark_gallery" \
  || ! grep -Fq '.quick-input-shell {' "$dark_gallery"; then
  echo "$dark_gallery is missing an approved dark text, search-surface, or shallow-glass remapping" >&2
  exit 1
fi

if grep -Fq 'style="box-shadow: 0 1px 0 rgba(255,255,255,.5) inset' "$dark_gallery"; then
  echo "$dark_gallery reuses an abrupt light-mode inset highlight in dark appearance" >&2
  exit 1
fi

if ! grep -q 'React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass' adapters/gpui/reference-contract.schema.json; then
  echo "The GPUI reference contract no longer enforces the canonical web-first stack" >&2
  exit 1
fi

if ! grep -q 'GPUI and WinUI 3 as optional' skills/rizum-glass/SKILL.md; then
  echo "The Rizum Glass Skill no longer marks native adapters as optional" >&2
  exit 1
fi

if ! grep -q 'React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass' adapters/winui/reference-contract.schema.json; then
  echo "The WinUI reference contract no longer enforces the canonical web-first stack" >&2
  exit 1
fi

node <<'NODE'
const fs = require("node:fs");
const theme = JSON.parse(fs.readFileSync("adapters/gpui/themes/rizum-glass.json", "utf8"));
for (const mode of ["light", "dark"]) {
  const entry = theme.themes.find((item) => item.mode === mode);
  if (!entry) throw new Error(`Missing GPUI ${mode} theme`);
  const neutral = entry.colors["primary.background"];
  for (const variant of ["danger", "info", "success", "warning"]) {
    if (entry.colors[`${variant}.background`] !== neutral) {
      throw new Error(`${mode} ${variant} button shell must remain neutral; express semantics through pointillist accents`);
    }
  }
}
const dark = theme.themes.find((item) => item.mode === "dark");
if (dark.colors.background !== "#111113") {
  throw new Error("GPUI dark theme must use the approved solid canvas");
}
NODE

node <<'NODE'
const fs = require("node:fs");
const xaml = fs.readFileSync("adapters/winui/generated/RizumGlass.Tokens.xaml", "utf8");
if (!xaml.includes('<ResourceDictionary x:Key="Dark">')) {
  throw new Error("Missing WinUI dark theme resources");
}
for (const style of ["RizumGlassButtonStyle", "RizumGlassConfirmButtonStyle", "RizumGlassDismissButtonStyle"]) {
  if (!xaml.includes(`x:Key="${style}"`)) {
    throw new Error(`Missing WinUI style: ${style}`);
  }
}
for (const style of ["RizumGlassConfirmButtonStyle", "RizumGlassDismissButtonStyle"]) {
  const neutralAlias = new RegExp(
    `<Style\\s+x:Key="${style}"[^>]*BasedOn="\\{StaticResource RizumGlassButtonStyle\\}"\\s*/>`,
  );
  if (!neutralAlias.test(xaml)) {
    throw new Error(`${style} must remain a direct alias of the neutral Rizum Glass button shell`);
  }
}
for (const accent of ["AccentTeal", "AccentCyan", "AccentOrange", "AccentYellow", "AccentViolet", "AccentRose", "AccentMint"]) {
  if (!xaml.includes(`RizumBrush${accent}`)) {
    throw new Error(`Missing WinUI pointillist brush: ${accent}`);
  }
}
NODE

if grep -Eiq '(spotlight|cursor-follow|pointermove)' archive/darkroom/transfer-test-darkroom-dark-v7.html; then
  echo "The approved dark archive still contains cursor-following lighting" >&2
  exit 1
fi

echo "Rizum Glass repository checks passed."
