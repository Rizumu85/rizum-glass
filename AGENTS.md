# Project Guidance

Rizum Glass is a reusable UI design-language repository, not a product repository.

- Read `DESIGN.md` before changing any UI guidance.
- Keep `DESIGN.md` product-neutral. Generalize a lesson before promoting it from a reference snapshot.
- Keep project files, code, comments, and technical documentation in English.
- Use React, TypeScript, Vite, Tailwind CSS, and shadcn/ui for canonical browser references.
- Use Bun, TypeScript, React 19, and the pinned `@gpuix/react` release as the default desktop delivery stack for new Rizum Glass applications.
- Treat direct GPUI as a lower-level Rust exception and document that ownership boundary in the reference contract.
- Before writing native UI code, require an approved web reference and the target-specific reference contract.
- Verify unfamiliar GPUIX and GPUI APIs against the exact pinned dependency source; both are pre-1.0 and may change without a stable compatibility promise.
- Keep system window controls native. Derive title-bar layout from platform insets and window state rather than fixed screenshot measurements.
- Use `references/rizum-glass-ui-gallery-v11.html` and `references/rizum-glass-ui-gallery-dark-v11.html` as the only active visual references. Never infer missing rules from them, and do not use older galleries, archived Nolnol, or darkroom files to guide new UI.
- Create a new versioned example or reference file instead of overwriting an earlier snapshot.
- Validate a design change with an unrelated product-domain transfer test.
- Keep large product feature specifications, architecture, and business rules out of this repository.
- Update `CHANGELOG.md` when canonical guidance changes.
- Regenerate `tokens/` with `scripts/export-tokens.sh` after token changes.
- Let `scripts/export-tokens.sh` regenerate native adapter assets and synchronize the repository-owned Skill; do not hand-edit generated adapter files or the Skill's `DESIGN.md` snapshot.

Version-control closeout:

- At the end of every completed conversation turn that changes this repository, partition the work into cohesive commits by concern. Do not mix unrelated design guidance, examples, generated assets, or repository-governance changes in one commit.
- Push each commit to the tracked remote immediately after creating it so every turn's changes are backed up remotely; do not defer the push to a later conversation.
- If authentication, connectivity, divergence, or a remote policy blocks a push, preserve the local commits and report the exact blocker. Do not describe locally committed work as backed up until the remote contains it.

Verification:

```bash
npx --yes --package=@google/design.md designmd lint DESIGN.md
sh scripts/export-tokens.sh
bash scripts/check-repo.sh
cd adapters/gpui/gallery && cargo check
# In a GPUIX consumer, run its repository-authorized type or benchmark checks only.
```
