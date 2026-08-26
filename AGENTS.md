# Project Guidance

Rizum Glass is a reusable UI design-language repository, not a product repository.

- Read `DESIGN.md` before changing any UI guidance.
- Keep `DESIGN.md` product-neutral. Generalize a lesson before promoting it from a reference snapshot.
- Keep project files, code, comments, and technical documentation in English.
- Use React, TypeScript, Vite, Tailwind CSS, and shadcn/ui for canonical generated implementation examples.
- Treat GPUI and WinUI 3 as optional delivery adapters, never the default design environment.
- Before writing native UI code, require an approved web reference and the target-specific reference contract.
- Verify unfamiliar GPUI and `gpui-component` APIs against the exact dependency source; both are pre-1.0.
- Verify unfamiliar WinUI APIs against the consuming project's Windows App SDK version. Keep product state and business logic out of code-behind.
- Treat `references/` as evidence, not specification. Never infer missing rules from reference HTML.
- Create a new versioned example or reference file instead of overwriting an earlier snapshot.
- Validate a design change with an unrelated product-domain transfer test.
- Keep large product feature specifications, architecture, and business rules out of this repository.
- Update `CHANGELOG.md` when canonical guidance changes.
- Regenerate `tokens/` with `scripts/export-tokens.sh` after token changes.
- Let `scripts/export-tokens.sh` regenerate native adapter assets and synchronize the repository-owned Skill; do not hand-edit generated adapter files or the Skill's `DESIGN.md` snapshot.

Verification:

```bash
npx @google/design.md lint DESIGN.md
sh scripts/export-tokens.sh
bash scripts/check-repo.sh
cd adapters/gpui/gallery && cargo check
# On Windows, also build a consuming WinUI 3 project that links the generated resources.
```
