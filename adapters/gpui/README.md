# Optional GPUI Adapter

GPUI is an optional delivery target for Rizum Glass. It is not the default design environment and does not replace the canonical web reference workflow.

## Non-Negotiable Order

1. Design and approve the interface in React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass.
2. Capture the approved component dimensions, state table, color and type tokens, spacing, motion timing, easing, and material behavior.
3. Translate those parameters into GPUI and `gpui-component`.
4. Compare the GPUI result with the approved web reference at the same viewport and state.
5. Record unavoidable platform differences explicitly instead of quietly redesigning the interface in Rust.

This order gives design agents a mature component vocabulary and inspectable CSS parameters before they enter GPUI's younger ecosystem.

## Contents

| Path | Purpose |
| --- | --- |
| `themes/rizum-glass.json` | Generated `gpui-component` theme. |
| `generated/rizum_glass_tokens.rs` | Generated Rust constants for custom GPUI surfaces and motion. |
| `gallery/` | Compile-checked native component gallery and adapter smoke test. |

Regenerate both derived files from `DESIGN.md`:

```bash
./scripts/export-tokens.sh
```

Run the gallery:

```bash
cd adapters/gpui/gallery
cargo run
```

GPUI and `gpui-component` are pre-1.0 dependencies. Verify APIs against the versions pinned by the consuming project before porting a component. Never invent a GPUI method by analogy with React.

## Material Boundary

`gpui-component` covers the shadcn-like behavior and component layer. Use its primitives before writing custom controls. GPUI supports window-level background appearances, but browser-style per-element `backdrop-filter` does not map one-to-one across platforms. Preserve hierarchy, translucency, border light, shadow softness, and motion first; treat blur strength as a documented platform adaptation.
