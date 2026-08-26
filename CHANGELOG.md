# Changelog

All notable changes to Rizum Glass are documented here.

## 1.2.0 - 2026-08-26

- Added an optional WinUI 3 adapter with generated XAML resources and C# motion constants.
- Added a WinUI reference contract so native Windows surfaces remain translations of approved web references.
- Added WinUI-specific MVVM, code-behind, material, motion, accessibility, and scale-factor guidance to the reusable Skill.
- Added a reusable WPF-to-WinUI adoption handoff for coding agents.

## 1.1.0 - 2026-08-26

- Added an optional GPUI adapter with a generated `gpui-component` theme and Rust token constants.
- Added a compile-checked GPUI component gallery.
- Added a web-reference translation contract so GPUI implementations begin from approved React, TypeScript, Vite, Tailwind CSS, and shadcn/ui parameters rather than from scratch.
- Added the reusable Rizum Glass Skill and a live-link installer for use across projects.
- Documented the contribution loop for promoting product-neutral improvements back into the shared design system and Skill.

## 1.0.0 - 2026-08-26

- Extracted the reusable Rizum Glass specification from the Nolnol prototype workspace.
- Established `DESIGN.md` as the sole canonical design-language document.
- Separated design rationale, implementation workflow, transfer tests, and product references.
- Added a submodule-first reuse workflow and a snapshot sync script.
