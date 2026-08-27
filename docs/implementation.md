# Implementation And Reuse

## Source Of Truth

`DESIGN.md` is the canonical design-language file. It follows the [google-labs-code/design.md](https://github.com/google-labs-code/design.md) structure: YAML front matter for tokens, followed by ordered design sections.

The repository separates canonical rules, derived assets, guidance, evidence, and adapters:

| Layer | Purpose | Authority |
| --- | --- | --- |
| `DESIGN.md` | Tokens and enforceable UI/UX rules | Canonical |
| `docs/` | Rationale and workflow | Explanatory |
| `tokens/` | Generated Tailwind v4 and DTCG exports | Derived from `DESIGN.md` |
| `adapters/gpui/` | Optional GPUI theme, Rust constants, translation contract, and gallery | Derived adapter and verification surface |
| `adapters/winui/` | Optional WinUI 3 resources, motion constants, translation contract, and handoff | Derived adapter and integration surface |
| `skills/rizum-glass/` | Reusable agent workflow with a synchronized canonical snapshot | Derived guidance plus workflow |
| `examples/` | Temporary cross-domain transfer tests | Validation evidence, not references |
| `references/` | Complete product-neutral gallery plus historical archive | Active visual reference and archived evidence |
| `archive/` | Retired transfer-test series | Historical evidence only |

Do not copy a product behavior into `DESIGN.md` merely because it appears in a reference. First express the reusable visual or interaction principle.

## Canonical Design Environment

Use React, TypeScript, Vite, Tailwind CSS utilities, and shadcn/ui primitives. Prefer existing shadcn primitives for behavior, accessibility, keyboard handling, focus management, and state semantics. Apply Rizum Glass through composition and tokens rather than replacing those behaviors with a hand-rolled visual framework.

Static HTML transfer tests are acceptable when they still use React component structure and Tailwind styling. Inline CSS should be limited to tokens, glass recipes, browser setup, and keyframes that utilities cannot express cleanly.

This is the canonical design and reference environment, not a mandatory production runtime. A final product may use GPUI or WinUI 3 when native rendering, latency, platform integration, or distribution requirements justify it.

## Optional GPUI Path

GPUI must begin from an approved web reference rather than from prose or a screenshot. The web implementation exposes more reliable layout, state, computed-style, and motion parameters to both humans and coding agents.

1. Build and approve the interface in the canonical web stack.
2. Record component dimensions, tokens, states, evidence, motion timing, easing, interruption behavior, and material fallbacks in a JSON file conforming to `adapters/gpui/reference-contract.schema.json`.
3. Regenerate the `gpui-component` theme and Rust constants with `./scripts/export-tokens.sh`.
4. Translate behavior with `gpui-component` primitives before writing custom controls.
5. Compare the native result against the approved reference at matching states and dimensions.
6. Document material differences where browser backdrop filtering cannot map exactly to the target platform.

The adapter pins versions only in its gallery smoke test. Consuming applications own their GPUI dependency versions and must verify APIs against their exact source.

## Optional WinUI 3 Path

WinUI 3 follows the same web-first translation boundary. It is a native Windows delivery target, not a second place to invent the visual language.

1. Build and approve the interface in the canonical web stack.
2. Record dimensions, state evidence, tokens, scale factors, motion, interruption behavior, accessibility, and material fallbacks in a JSON file conforming to `adapters/winui/reference-contract.schema.json`.
3. Regenerate `RizumGlass.Tokens.xaml` and `RizumGlass.Motion.cs` with `./scripts/export-tokens.sh`.
4. Translate behavior with standard WinUI controls before creating custom controls or Composition effects.
5. Keep XAML views declarative, view state and commands in view models, and business logic in services. Limit code-behind to window lifecycle, visual-tree access, and narrow Composition interop.
6. Compare the native result against the approved reference at matching content, state, dimensions, and display scale.
7. Verify high contrast, transparency disabled, reduced motion, keyboard navigation, and long Chinese and English text.

For new Windows applications, the recommended baseline is C# with .NET 8 or a newer supported release, WinUI 3 on the current stable Windows App SDK, CommunityToolkit.Mvvm, and Microsoft.Extensions.DependencyInjection. Consuming applications own those dependency versions and must verify unfamiliar APIs against current Microsoft documentation.

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

Regenerate implementation tokens and adapter assets after any front-matter change:

```bash
./scripts/export-tokens.sh
```

Do not edit files in `tokens/`, `adapters/gpui/themes/`, `adapters/gpui/generated/`, or `adapters/winui/generated/` by hand. They are derived artifacts. The command also synchronizes `DESIGN.md` into the repository-owned Skill.

Then generate a new transfer test under a domain unrelated to the active gallery. The test should include the component categories affected by the change, such as:

- content-aware panels with different intrinsic widths;
- a menu with left labels and right metadata;
- neutral, confirm, and dismiss action states;
- at least one numeric slider or other dense control;
- an interactive alternative to a standard toggle;
- a message or asynchronous state when motion rules change.

Evaluate the result at desktop and compact viewports. Check text wrapping, collision, button consistency, divider restraint, readable contrast, animation continuity, and keyboard interaction. Compare only with `references/rizum-glass-ui-gallery-v11.html` or `references/rizum-glass-ui-gallery-dark-v11.html`; older galleries, archived product snapshots, and retired transfer tests must not guide the result. Do not repair the test with one-off CSS before deciding whether the missing rule belongs in `DESIGN.md`.

Active galleries are curated implementation references rather than feature inventories. Remove an unfinished component family from the current gallery, including its unreachable template and styles, while preserving the earlier versioned snapshot for history.

## Change Workflow

1. Write the reusable rule in `DESIGN.md`.
2. Regenerate `tokens/` when front-matter values change.
3. Update `docs/design-rationale.md` only when the underlying taste or reasoning changes.
4. Add a concise entry to `CHANGELOG.md`.
5. Create a new versioned transfer test; never overwrite an old one.
6. Visually inspect the test and a product reference side by side.
7. Commit the canonical change and its evidence together.
8. Update consuming projects intentionally rather than silently floating to the newest revision.

## Reusable Skill

Run `./scripts/install-skill.sh` to link `skills/rizum-glass` into `${CODEX_HOME:-$HOME/.codex}/skills`. A live link is preferred for local development because improvements remain versioned in this repository and become available across projects without copying files.

The Skill may help identify reusable lessons in a consuming project, but it must not promote every local preference. A shared change must be product-neutral, update `DESIGN.md` first, pass an unrelated transfer test, regenerate all derived assets, and include a changelog entry.

Product architecture, business flows, domain models, and feature inventories belong in their product repositories, not here.
