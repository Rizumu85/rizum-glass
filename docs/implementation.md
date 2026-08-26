# Implementation And Reuse

## Source Of Truth

`DESIGN.md` is the canonical design-language file. It follows the [google-labs-code/design.md](https://github.com/google-labs-code/design.md) structure: YAML front matter for tokens, followed by ordered design sections.

The repository has four information layers:

| Layer | Purpose | Authority |
| --- | --- | --- |
| `DESIGN.md` | Tokens and enforceable UI/UX rules | Canonical |
| `docs/` | Rationale and workflow | Explanatory |
| `tokens/` | Generated Tailwind v4 and DTCG exports | Derived from `DESIGN.md` |
| `examples/` | Cross-domain transfer tests | Validation evidence |
| `references/` | Product-specific snapshots | Historical visual evidence |

Do not copy a product behavior into `DESIGN.md` merely because it appears in a reference. First express the reusable visual or interaction principle.

## Implementation Baseline

Use React components, Tailwind CSS utilities, and shadcn/ui primitives. Prefer existing shadcn primitives for behavior, accessibility, keyboard handling, focus management, and state semantics. Apply Rizum Glass through composition and tokens rather than replacing those behaviors with a hand-rolled visual framework.

Static HTML transfer tests are acceptable when they still use React component structure and Tailwind styling. Inline CSS should be limited to tokens, glass recipes, browser setup, and keyframes that utilities cannot express cleanly.

## Recommended Adoption: Git Submodule

Add the design language to an active project:

```bash
git submodule add https://github.com/Rizumu85/rizum-glass.git design/rizum-glass
git commit -m "Add Rizum Glass design language"
```

Add a short rule to the consuming project's agent instructions:

```text
Read design/rizum-glass/DESIGN.md before UI/UX work.
Use references only after the canonical guide, and never copy their product domain.
```

Update later with:

```bash
git submodule update --remote design/rizum-glass
```

This keeps one upstream style history while letting each project pin a known-good revision.

## Snapshot Adoption

For a project that should not use submodules:

```bash
./scripts/sync-design.sh /absolute/path/to/project/DESIGN.md
```

The script copies only the canonical file. The consuming project owns that snapshot until it is synced again. Do not manually maintain two divergent canonical copies.

## Validate A Change

Lint the canonical file:

```bash
npx @google/design.md lint DESIGN.md
```

Regenerate implementation tokens after any front-matter change:

```bash
./scripts/export-tokens.sh
```

Do not edit files in `tokens/` by hand. They are derived artifacts.

Then generate a new transfer test under a domain unrelated to any existing reference. The test should include the component categories affected by the change, such as:

- content-aware panels with different intrinsic widths;
- a menu with left labels and right metadata;
- neutral, confirm, and dismiss action states;
- at least one numeric slider or other dense control;
- an interactive alternative to a standard toggle;
- a message or asynchronous state when motion rules change.

Evaluate the result at desktop and compact viewports. Check text wrapping, collision, button consistency, divider restraint, readable contrast, animation continuity, and keyboard interaction. Do not repair the test with one-off CSS before deciding whether the missing rule belongs in `DESIGN.md`.

## Change Workflow

1. Write the reusable rule in `DESIGN.md`.
2. Regenerate `tokens/` when front-matter values change.
3. Update `docs/design-rationale.md` only when the underlying taste or reasoning changes.
4. Add a concise entry to `CHANGELOG.md`.
5. Create a new versioned transfer test; never overwrite an old one.
6. Visually inspect the test and a product reference side by side.
7. Commit the canonical change and its evidence together.
8. Update consuming projects intentionally rather than silently floating to the newest revision.

Product architecture, business flows, domain models, and feature inventories belong in their product repositories, not here.
