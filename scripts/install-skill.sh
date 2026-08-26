#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
skill_source="$repo_root/skills/rizum-glass"
codex_home=${CODEX_HOME:-"$HOME/.codex"}
skill_target="$codex_home/skills/rizum-glass"

mkdir -p "$(dirname -- "$skill_target")"

if [ -L "$skill_target" ] && [ "$(readlink "$skill_target")" = "$skill_source" ]; then
  echo "Rizum Glass skill is already linked to $skill_source."
  exit 0
fi

if [ -e "$skill_target" ] || [ -L "$skill_target" ]; then
  echo "Refusing to replace existing skill path: $skill_target" >&2
  exit 1
fi

ln -s "$skill_source" "$skill_target"
echo "Installed Rizum Glass skill as a live link: $skill_target"
