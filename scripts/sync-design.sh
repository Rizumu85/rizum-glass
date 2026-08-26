#!/bin/sh

set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /absolute/path/to/project/DESIGN.md" >&2
  exit 64
fi

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
target=$1

case "$target" in
  */) target="${target}DESIGN.md" ;;
esac

mkdir -p "$(dirname -- "$target")"
cp "$repo_root/DESIGN.md" "$target"
printf 'Synced Rizum Glass DESIGN.md to %s\n' "$target"

