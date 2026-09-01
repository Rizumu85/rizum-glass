# Rizum Glass

Rizum Glass is a reusable UI design language for compact software surfaces. It combines neutral liquid glass, paper-like editorial rhythm, restrained pointillist color, and tactile Apple/Arc-inspired motion.

The visual language is reusable across products. Browser references use **React + TypeScript + Vite + Tailwind CSS + shadcn/ui**. New desktop applications use **Bun + TypeScript + React 19 + GPUIX** after the reference is approved. Direct GPUI is the lower-level Rust path for explicitly justified surfaces.

The active visual references are the product-neutral [Rizum Glass UI Gallery](references/rizum-glass-ui-gallery-v11.html) and its [dark appearance](references/rizum-glass-ui-gallery-dark-v11.html). Archived product prototypes, older gallery snapshots, and transfer tests preserve history but must not guide new interface work.

## Repository Map

| Path | Role |
| --- | --- |
| [`DESIGN.md`](DESIGN.md) | Canonical machine-readable and human-readable design specification. |
| [`docs/design-rationale.md`](docs/design-rationale.md) | The taste, priorities, and reasoning behind the rules. |
| [`docs/implementation.md`](docs/implementation.md) | Adoption, validation, and synchronization workflow. |
| [`tokens/`](tokens/) | Generated Tailwind v4 and DTCG token exports. |
| [`adapters/gpuix/`](adapters/gpuix/) | Default desktop adapter, generated TypeScript tokens, and platform-aware reference contract. |
| [`adapters/gpui/`](adapters/gpui/) | Lower-level direct GPUI theme, Rust tokens, translation contract, and component gallery. |
| [`skills/rizum-glass/`](skills/rizum-glass/) | Reusable Codex skill for web-first design and GPUIX desktop translation. |
| [`references/rizum-glass-ui-gallery-v11.html`](references/rizum-glass-ui-gallery-v11.html) | Current curated product-neutral light appearance reference. |
| [`references/rizum-glass-ui-gallery-dark-v11.html`](references/rizum-glass-ui-gallery-dark-v11.html) | Current curated product-neutral dark appearance reference. |
| [`references/archive/`](references/archive/) | Historical product snapshots; not active design references. |
| [`archive/darkroom/`](archive/darkroom/) | Retired transfer-test history, including the approved gradient-free dark exploration. |

## Use In A Project

For an active project, add this repository as a submodule so improvements can be pulled without copying documents by hand:

```bash
git submodule add https://github.com/Rizumu85/rizum-glass.git design/rizum-glass
```

Then tell coding agents and contributors:

```text
Read design/rizum-glass/DESIGN.md before making UI or UX changes.
Treat it as the source of truth. Do not infer rules from reference HTML.
```

For a self-contained snapshot instead, clone this repository and run:

```bash
./scripts/sync-design.sh /absolute/path/to/project/DESIGN.md
```

See [`docs/implementation.md`](docs/implementation.md) for the full workflow.

## Install The Skill

Install the repository-owned skill as a live link so improvements made here are immediately available to new projects:

```bash
./scripts/install-skill.sh
```

Then invoke it explicitly when useful:

```text
Use $rizum-glass to design this interface.
```

The skill uses the web reference stack for design and GPUIX for new desktop delivery. It enters direct GPUI mode only for a documented lower-level exception.

## GPUIX Desktop Delivery

Approve a working browser reference, capture its dimensions, states, motion, and platform-window decisions, then translate it to the pinned GPUIX package:

```bash
./scripts/export-tokens.sh
```

See [`adapters/gpuix/README.md`](adapters/gpuix/README.md) for the stack, generated values, platform-shell boundary, and reference contract.
The reusable native quality pass is in [`skills/rizum-glass/references/gpuix-translation.md`](skills/rizum-glass/references/gpuix-translation.md); it includes optical scale calibration, interaction ownership, compact-component recipes, and safe fallbacks for missing GPUIX capabilities.

## Direct GPUI Exception

Do not design the native version from scratch. First approve a working web reference, capture its dimensions, states, tokens, and motion in a reference contract, then translate it with `gpui-component` and the generated adapter assets:

```bash
./scripts/export-tokens.sh
cd adapters/gpui/gallery
cargo run
```

See [`adapters/gpui/README.md`](adapters/gpui/README.md) for the translation boundary.

## Evolving The Style

1. Change `DESIGN.md` first.
2. Run `./scripts/export-tokens.sh` to regenerate web tokens, native adapter assets, and the skill snapshot.
3. Record the intent in `CHANGELOG.md`.
4. Generate a new interface in an unrelated product domain using only `DESIGN.md`.
5. Compare the result against the design principles and the appropriate complete product-neutral light or dark gallery, not archived product or darkroom snapshots.
6. Add a new versioned gallery or validation file instead of overwriting history.
7. Pull the update into consuming projects through the submodule or sync script. A locally linked Skill updates with the repository automatically.

## Status

Version 1.0 was extracted from the long-running Nolnol prototype process. The product-neutral light and dark galleries are the active visual references; reusable visual and interaction decisions live in `DESIGN.md`, and the original product material remains archived.
