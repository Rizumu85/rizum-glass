# GPUIX Desktop Adapter

GPUIX is the default desktop delivery stack for new Rizum Glass applications. The approved browser reference remains the design instrument; this adapter carries its semantic values and state contract into native React rendering.

## Baseline

- Bun
- TypeScript with strict mode and `jsxImportSource: "@gpuix/react"`
- React 19
- An exact pinned `@gpuix/react` release
- GPUI through the GPUIX native package

GPUIX and GPUI are related but different layers. GPUI is Zed's Rust UI framework. GPUIX supplies a React reconciler and native binding that render React components through GPUI without Electron or a web view. Direct GPUI remains available under `adapters/gpui/` for justified Rust-native surfaces, not as a second default stack.

## Contents

| Path | Purpose |
| --- | --- |
| `generated/rizum-glass-tokens.ts` | Generated semantic colors, typography sizes, spacing, radii, and platform-window guidance for GPUIX. |
| `reference-contract.schema.json` | Required evidence and platform-chrome contract for an approved translation. |
| `reference-contract.example.json` | Product-neutral example of the contract. |

The detailed delivery field guide lives in [`skills/rizum-glass/references/gpuix-translation.md`](../../skills/rizum-glass/references/gpuix-translation.md). It covers capability audits, native optical calibration, interaction ownership, reusable compact-component recipes, and motion degradation.

Regenerate the derived TypeScript values from `DESIGN.md`:

```bash
./scripts/export-tokens.sh
```

## Window Boundary

The native window boundary maps to the approved product surface. Do not reproduce the browser stage or wrap the app in a second rounded card. Let the Rizum Glass material reach the system window edge and retain the platform frame, shadow, resize behavior, and system controls.

Use measured platform geometry. On Windows, keep content clear of the native caption-button region and follow maximized/snapped corner behavior. On macOS, keep content clear of the standard traffic-light region and center titles inside the unobscured content area. When the pinned GPUIX package cannot expose the required geometry, retain the platform's native title bar rather than guessing.

GPUIX is pre-1.0. Verify window, style, component, automation, and motion APIs against the consuming project's exact installed package before using them.

The reference contract must record more than final screenshots. Include the real-device native calibration, static/editable selection ownership, pointer capture and wheel routing, sensitive-value handling, and every material or capability fallback used by the pinned runtime.

## Primary References

- [GPUIX repository and architecture](https://github.com/remorses/gpuix)
- [GPUI framework README](https://github.com/zed-industries/zed/tree/main/crates/gpui)
- [Windows 11 rounded-corner behavior](https://learn.microsoft.com/en-us/windows/apps/desktop/modernize/ui/apply-rounded-corners)
- [Windows title-bar reserved regions and caption controls](https://learn.microsoft.com/en-us/windows/apps/develop/title-bar)
- [Apple Human Interface Guidelines: Windows](https://developer.apple.com/design/human-interface-guidelines/windows)
- [AppKit full-size content and content-layout guidance](https://developer.apple.com/documentation/appkit/nswindow/stylemask-swift.struct/fullsizecontentview)
