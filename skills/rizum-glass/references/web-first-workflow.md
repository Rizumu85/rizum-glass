# Web-First Workflow

Use this workflow for every new Rizum Glass interface, including interfaces that will later ship in GPUI.

## Baseline

- React
- TypeScript
- Vite
- Tailwind CSS
- shadcn/ui
- Rizum Glass tokens and rules from `DESIGN.md`

This stack is the canonical reference environment because it gives design agents a broad component vocabulary, inspectable computed styles, mature accessibility primitives, and rapid visual iteration. It is not mandatory for the final product runtime.

## Sequence

1. Read the product requirements and existing code before choosing components.
2. Build the actual working interface, not a marketing page or a static mood board.
3. Compose shadcn/ui primitives for semantics and behavior. Apply Rizum Glass through tokens, layout, material, typography, and motion.
4. Exercise every important state: default, hover, pressed, focused, disabled, loading, empty, error, success, expanded, and compact where applicable.
5. Verify desktop and compact viewports. Panels should be only as wide as their content contract requires, but never so narrow that labels and metadata collide.
6. Capture screenshots or recordings of the approved states.
7. If GPUI is a target, write a translation contract using the repository schema before writing Rust.

## Reference Quality Gate

The reference is ready only when:

- text wraps intentionally and no control shifts size between states;
- buttons preserve the neutral Rizum Glass shell unless semantics require otherwise;
- dividers express real grouping and do not become decoration;
- title serif and UI sans roles are consistent;
- color accents are sparse and semantic;
- motion has named states, duration, easing, interruption behavior, and reduced-motion behavior;
- keyboard, focus, and pointer behavior work through the chosen primitives.

Do not use one-off CSS to hide a missing design rule. Decide whether the rule belongs in the product or in the shared system.
