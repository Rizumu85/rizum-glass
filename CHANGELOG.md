# Changelog

All notable changes to Rizum Glass are documented here.

## Unreleased

- Softened the dark quick-input top reflection by replacing its light-mode 50% white inset seam with a low-opacity blurred glass highlight.
- Flattened the dark search utility onto one continuous glass plane by removing distinct query-bar and footer fills while retaining row hover feedback and compact key hints.
- Raised required dark-mode captions, metadata, shortcut labels, and inactive option labels onto solid semantic text roles instead of compounding muted greys with light-mode alpha utilities.
- Stabilized first-use onboarding at one compact responsive width and removed per-step shell resizing.
- Reworked content-profile excerpts as borderless nested glass reading groups and removed the unfinished appearance-pack family from the active galleries and onboarding flow.
- Reworked compact calendar and search utilities to remove wireframe-like internal outlines, full-width rules, and colored result rails while preserving one quiet outer glass edge.
- Made dark nested health surfaces more transparent by reducing the fill, increasing backdrop blur, and shifting separation into restrained edge highlights and depth.
- Replaced outlined dark health tiles with softly layered glass surfaces using translucent fill, restrained inset highlights, and low-contrast depth.
- Removed internal row separators from the compact model-tier group in the active light and dark galleries.
- Curated the active light and dark galleries by removing the unfinished extension-center family while preserving the earlier snapshots.
- Rebalanced model and credential settings into a wider, shorter form with compact grouped model rows.
- Added reusable Rizum Glass Select guidance and adapted light/dark dropdown popovers with compact density, keyboard interaction, collision-aware placement, and neutral glass menus.
- Added the approved solid-canvas dark appearance, including generated Tailwind, GPUI, and WinUI 3 dark tokens.
- Explicitly excluded cursor-following glow and panel spotlight effects from Rizum Glass.
- Retired the darkroom transfer-test series and made the complete product-neutral UI galleries the only active visual references.
- Added a complete product-neutral dark UI gallery with the same component and interaction coverage as the light reference.
- Added a product-neutral UI reference gallery covering the full set of interface families from the broad Nolnol reference snapshot.

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
