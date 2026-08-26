# Project Guidance

Rizum Glass is a reusable UI design-language repository, not a product repository.

- Read `DESIGN.md` before changing any UI guidance.
- Keep `DESIGN.md` product-neutral. Generalize a lesson before promoting it from a reference snapshot.
- Keep project files, code, comments, and technical documentation in English.
- Use React, Tailwind CSS, and shadcn/ui for generated implementation examples.
- Treat `references/` as evidence, not specification. Never infer missing rules from reference HTML.
- Create a new versioned example or reference file instead of overwriting an earlier snapshot.
- Validate a design change with an unrelated product-domain transfer test.
- Keep large product feature specifications, architecture, and business rules out of this repository.
- Update `CHANGELOG.md` when canonical guidance changes.
- Regenerate `tokens/` with `scripts/export-tokens.sh` after token changes.

Verification:

```bash
npx @google/design.md lint DESIGN.md
sh scripts/export-tokens.sh
bash scripts/check-repo.sh
```
