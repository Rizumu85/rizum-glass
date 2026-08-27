# Generated Tokens

These files are generated from the YAML front matter in `../DESIGN.md`:

- `rizum-glass.tailwind.css` provides Tailwind v4 `@theme` values.
- `rizum-glass.tokens.json` provides W3C Design Tokens Community Group-compatible JSON.

Both exports include the approved light roles and the `dark-*` semantic roles. Dark appearance uses a solid `dark-canvas` and neutral dark surfaces; it does not introduce canvas gradients or cursor-following light.

Regenerate both files with:

```bash
./scripts/export-tokens.sh
```

Do not edit generated token files by hand.
