---
name: rizum-glass
description: Design and implement polished Rizum Glass interfaces. Use when creating or revising UI in the Rizum Glass style, producing an approved React web reference, delivering a desktop interface with Bun + TypeScript + React 19 + GPUIX, using direct GPUI for a justified lower-level Rust surface, or promoting reusable UI lessons back into the shared design system. Do not use for unrelated visual styles.
---

# Rizum Glass

Use the browser implementation as the design instrument and GPUIX as the default desktop delivery stack. GPUI is GPUIX's lower-level Rust renderer, not another name for GPUIX. WinUI 3 is legacy and must not be selected for new work.

## Start Here

1. Read [`references/DESIGN.md`](references/DESIGN.md). It is the canonical visual and interaction specification.
2. Identify the requested mode:
   - For ordinary UI work, use the web-first workflow in [`references/web-first-workflow.md`](references/web-first-workflow.md).
   - For a new desktop application or an existing GPUIX application, complete the web-first reference before reading [`references/gpuix-translation.md`](references/gpuix-translation.md).
   - Only when a project proves that a surface needs direct Rust ownership or an unavailable GPUIX capability, read [`references/gpui-translation.md`](references/gpui-translation.md).
   - When a project reveals a reusable design lesson, follow [`references/contribution-loop.md`](references/contribution-loop.md).
3. Inspect the consuming project's existing conventions before making changes. Rizum Glass is a visual system, not permission to replace product architecture.

## Invariants

- Default browser references to React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass.
- Default new desktop delivery to Bun + TypeScript + React 19 + the project's pinned `@gpuix/react` release.
- Do not migrate an existing product merely because this skill is active. For new Rizum Glass desktop work, do not introduce C# or WinUI 3.
- Never design a native adapter interface directly from prose, a screenshot, or `DESIGN.md` alone. First produce or locate an approved interactive web reference and its target-specific translation contract.
- Use shadcn/ui in browser references and GPUIX's supported host/headless components in desktop code before writing custom controls. Custom styling may compose primitives; it should not discard focus, keyboard, selection, or state behavior.
- Keep product features, domain models, and architecture out of `DESIGN.md`.
- Treat product reference files as evidence, not specifications.
- In the canonical repository, use only the current product-neutral light and dark v11 galleries as visual references. Do not use older galleries, archived product snapshots, or darkroom files to guide new UI.
- Prefer content-aware panel dimensions over a universal maximum width. Verify text fit and right-side metadata at compact and desktop sizes.
- Keep color semantic and restrained. Neutral shells come first; pointillist accents identify meaning, not decoration.
- Verify motion as a sequence of states, not just a final screenshot. Respect reduced-motion settings.
- Treat native translation as an optical calibration. Verify the running product at the target operating-system scale and record any coherent geometry correction and title exception in the reference contract.
- For Windows delivery, use the canonical MiSans VF / Noto Serif SC VF / Cascadia Mono role set and bundle the exact font files plus license notices. Register them process-private before the renderer starts; never rely on the development machine's installed fonts.
- Assign interaction ownership explicitly: static copy, native editor selection, pointer capture, wheel routing, overlays, and sensitive values must not inherit browser assumptions.
- Keep compact utilities content-sized by named state. When a detail or action appears, update the section rhythm and window bounds together rather than reserving blank space or clipping the footer.
- Reuse the approved compact field, select, segmented, slider, status-row, and anchored-popover recipes from the GPUIX translation guide before creating local variants.

## Desktop Adapter Safety

For GPUIX, inspect the exact package types and source because it is pre-1.0; do not assume DOM inheritance, CSS support, React-DOM behavior, rounded overflow clipping, pointer capture, or presentation-synchronized repeat motion. For direct GPUI, inspect the pinned Rust source and do not infer methods from GPUIX props. Document material and capability fallbacks that cannot reproduce the browser reference exactly.

Keep platform window controls native. Use measured safe areas and title-bar insets for the top frame; never place interactive content under Windows caption buttons or macOS traffic lights. If the pinned GPUIX release cannot report enough geometry, retain the native title bar instead of hard-coding control sizes.

## Shared Improvement Rule

Do not change the shared skill to patch one product's local preference. Promote a lesson only when it is product-neutral, reproducible, and validated in an unrelated interface. Update the canonical repository first, regenerate derived assets, then synchronize this skill snapshot.
