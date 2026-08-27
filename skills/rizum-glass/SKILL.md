---
name: rizum-glass
description: Design and implement polished Rizum Glass interfaces. Use when creating or revising UI in the Rizum Glass style, producing the canonical React + TypeScript + Vite + Tailwind CSS + shadcn/ui reference, translating an approved web reference to optional GPUI or WinUI 3 code, or promoting reusable UI lessons from a product back into the shared design system. Do not use for unrelated visual styles.
---

# Rizum Glass

Use the web implementation as the design instrument. Treat GPUI and WinUI 3 only as optional delivery targets.

## Start Here

1. Read [`references/DESIGN.md`](references/DESIGN.md). It is the canonical visual and interaction specification.
2. Identify the requested mode:
   - For ordinary UI work, use the web-first workflow in [`references/web-first-workflow.md`](references/web-first-workflow.md).
   - When the project explicitly selects GPUI, complete the web-first reference before reading [`references/gpui-translation.md`](references/gpui-translation.md).
   - When the project explicitly selects WinUI 3, complete the web-first reference before reading [`references/winui-translation.md`](references/winui-translation.md).
   - When a project reveals a reusable design lesson, follow [`references/contribution-loop.md`](references/contribution-loop.md).
3. Inspect the consuming project's existing conventions before making changes. Rizum Glass is a visual system, not permission to replace product architecture.

## Invariants

- Default to React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass.
- Treat GPUI and WinUI 3 as optional. Never move a project to a native toolkit merely because this skill is active.
- Never design a native adapter interface directly from prose, a screenshot, or `DESIGN.md` alone. First produce or locate an approved interactive web reference and its target-specific translation contract.
- Use shadcn/ui, `gpui-component`, or standard WinUI controls before writing custom controls. Custom styling may compose primitives; it should not discard accessibility, focus, keyboard, or state behavior.
- Keep product features, domain models, and architecture out of `DESIGN.md`.
- Treat product reference files as evidence, not specifications.
- Use `references/rizum-glass-ui-gallery-v11.html` and `references/rizum-glass-ui-gallery-dark-v11.html` as the only active visual references. Do not use older galleries, archived Nolnol, or darkroom files to guide new UI.
- Prefer content-aware panel dimensions over a universal maximum width. Verify text fit and right-side metadata at compact and desktop sizes.
- Keep color semantic and restrained. Neutral shells come first; pointillist accents identify meaning, not decoration.
- Verify motion as a sequence of states, not just a final screenshot. Respect reduced-motion settings.

## Native Adapter Safety

For GPUI, inspect the exact dependency source because GPUI and `gpui-component` are pre-1.0; do not infer Rust methods from React names. For WinUI 3, verify unfamiliar APIs against the consuming project's Windows App SDK version and keep product logic out of code-behind. In either target, document material fallbacks that cannot reproduce CSS backdrop filtering exactly.

## Shared Improvement Rule

Do not change the shared skill to patch one product's local preference. Promote a lesson only when it is product-neutral, reproducible, and validated in an unrelated interface. Update the canonical repository first, regenerate derived assets, then synchronize this skill snapshot.
