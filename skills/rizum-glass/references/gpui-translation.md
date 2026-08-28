# Direct GPUI Translation

Enter this lower-level workflow only when the consuming project proves that a surface needs direct Rust ownership or a GPUI capability that the pinned GPUIX release does not expose. GPUI is the Rust UI framework beneath GPUIX; it is not a competing spelling or newer version of GPUIX.

## Required Inputs

- An approved interactive web reference built with the Rizum Glass web baseline.
- State screenshots or recordings at named viewport sizes.
- A completed `reference-contract.json` conforming to `adapters/gpui/reference-contract.schema.json` in the Rizum Glass repository.
- A short boundary note explaining why GPUIX cannot own this surface.
- The consuming project's pinned GPUI and `gpui-component` versions.

If any input is missing, return to GPUIX or the web reference. Do not fill gaps by taste in the Rust implementation.

## Translation Order

1. Load the generated `gpui-component` theme from `adapters/gpui/themes/rizum-glass.json` and select its approved light or dark entry rather than remapping colors locally.
2. Use `gpui-component` primitives for buttons, inputs, menus, dialogs, lists, sliders, tabs, and focus behavior.
3. Apply generated Rust constants from `adapters/gpui/generated/rizum_glass_tokens.rs` to custom surfaces and motion.
4. Port layout from the recorded intrinsic, minimum, preferred, and maximum dimensions. Do not translate web viewport width into a global native panel width.
5. Port each named interaction state and motion phase. Preserve continuity, interruption behavior, and state meaning before chasing identical timing.
6. Compare the native result and web reference at matching states and dimensions.
7. Preserve the same platform-window contract as GPUIX: system outer silhouette, native window controls, measured reserved regions, valid drag areas, and platform-owned maximized/full-screen geometry.
8. Record material differences. Window-level blur may be available while CSS-like per-element backdrop blur is not; preserve neutral translucency, border light, shadow softness, and hierarchy as the fallback.

## API Discipline

GPUI and `gpui-component` are pre-1.0. Search the exact checked-out source or official documentation for every unfamiliar API. Never invent a method from a Tailwind utility or React prop. Compile the gallery and the consuming project after each component family is translated.

## Completion Gate

- The generated theme parses with the pinned `gpui-component` version.
- The component states match the reference contract.
- Text fit is verified with long Chinese and English labels.
- Focus and keyboard behavior remain intact.
- Motion is inspected during transitions, not only at rest.
- Platform material differences and the reason for bypassing GPUIX are documented and intentional.
