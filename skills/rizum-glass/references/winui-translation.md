# WinUI 3 Translation

Enter this workflow only when the consuming project explicitly chooses WinUI 3.

## Required Inputs

- An approved interactive web reference built with the Rizum Glass web baseline.
- State screenshots or recordings at named viewport sizes and scale factors.
- A completed `reference-contract.json` conforming to `adapters/winui/reference-contract.schema.json` in the Rizum Glass repository.
- The consuming project's .NET and Windows App SDK versions.

If any visual input is missing, return to the web reference. Do not fill gaps by taste in XAML.

## Translation Order

1. Include `adapters/winui/generated/RizumGlass.Tokens.xaml` as a linked XAML Page and merge it into `App.xaml`; use its `Default`, `Dark`, and `HighContrast` theme dictionaries instead of maintaining a second palette.
2. Include the generated motion constants rather than copying timing values into product code.
3. Use standard WinUI controls for buttons, inputs, menus, dialogs, lists, sliders, tabs, focus, keyboard behavior, and accessibility.
4. Port layout from intrinsic, minimum, preferred, and maximum dimensions in the contract. Do not turn the web viewport width into a global native panel width.
5. Port every named state and motion phase. Preserve continuity, interruption behavior, and state meaning before tuning exact timing.
6. Use Microsoft.UI.Composition only when standard visual states and transitions cannot express the approved motion.
7. Compare the WinUI result and web reference at matching content, state, dimensions, and display scale.
8. Record material differences. Prefer a neutral translucent fallback over an inaccurate custom blur.

## Architecture Boundary

- XAML Views own layout, bindings, visual states, and accessibility metadata.
- ViewModels own observable presentation state and commands. CommunityToolkit.Mvvm is the recommended default.
- Services own business logic, persistence, system access, and integrations. Compose them with Microsoft.Extensions.DependencyInjection when the application already uses dependency injection.
- Code-behind is for window lifecycle, visual-tree access, and narrowly scoped Composition interop. Do not store product state or business workflows there.
- Preserve reusable services and models during a WPF-to-WinUI migration. Do not introduce a WPF/WinUI hybrid unless an existing dependency makes it necessary and the boundary is explicit.

## Material And Motion

Use a window-level Mica backdrop where appropriate and Desktop Acrylic for transient overlays. Ordinary panels remain neutral; glass is hierarchy and light, not a blur effect on every rectangle. Respect high contrast, transparency disabled, reduced motion, energy-saving behavior, and remote-session fallbacks.

Prefer transforms, opacity, clips, and compositor animation over `Width`, `Height`, or other properties that trigger repeated layout. Custom motion must define interruption behavior and a reduced-motion path.

## Completion Gate

- The solution builds with the consuming project's pinned .NET and Windows App SDK versions.
- Generated resources are linked or imported once rather than copied into a divergent local token file.
- Component states match the reference contract.
- Long Chinese and English labels fit at 100%, 150%, and 200% scale.
- Keyboard navigation, focus, screen-reader names, high contrast, and transparency fallbacks remain intact.
- Motion is inspected during transitions and after interruption, not only at rest.
- Product state and business logic do not accumulate in code-behind.
