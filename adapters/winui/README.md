# Archived WinUI 3 Adapter

This adapter is frozen for existing consumers and historical reference. It is no longer part of the active export or validation path and must not be selected for new Rizum Glass applications. Use the GPUIX adapter instead.

WinUI 3 is an optional native Windows delivery target for Rizum Glass. It does not replace the canonical React reference workflow, and this adapter does not make WinUI a requirement for other products.

## Recommended Baseline

- C# and .NET 8 or a newer supported .NET release
- WinUI 3 on the current stable Windows App SDK
- CommunityToolkit.Mvvm for observable state and commands
- Microsoft.Extensions.DependencyInjection for application services
- Microsoft.UI.Composition for motion that cannot be expressed cleanly with XAML transitions

Keep XAML views declarative. View models own UI state and commands; services own product logic and I/O. Code-behind is reserved for window lifecycle, visual-tree access, and narrowly scoped Composition interop.

## Non-Negotiable Order

1. Design and approve the surface in React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass.
2. Capture dimensions, states, tokens, motion, interruption behavior, accessibility behavior, and material fallbacks in a contract conforming to `reference-contract.schema.json`.
3. Import the generated resources and translate behavior with standard WinUI controls before creating custom controls.
4. Use Microsoft.UI.Composition only for motion or material behavior that standard controls cannot provide.
5. Compare the WinUI result with the approved web reference at matching content, state, window size, and scale.

## Generated Assets

| Path | Purpose |
| --- | --- |
| `generated/RizumGlass.Tokens.xaml` | Light, dark, and high-contrast colors and brushes plus type roles, spacing, radii, panel treatment, and neutral button styles. |
| `generated/RizumGlass.Motion.cs` | Timing constants explicitly defined by the canonical design language. |

Regenerate both files from `DESIGN.md`:

```bash
./scripts/export-tokens.sh
```

Do not edit generated files by hand. Override resources in the consuming application when a product needs a deliberate, documented adaptation.

## Project Integration

Add this repository as a pinned submodule:

```bash
git submodule add https://github.com/Rizumu85/rizum-glass.git design/rizum-glass
```

Include or link `generated/RizumGlass.Tokens.xaml` as a XAML `Page` in the WinUI project, then merge it in `App.xaml`:

```xml
<Application.Resources>
  <ResourceDictionary>
    <ResourceDictionary.MergedDictionaries>
      <ResourceDictionary Source="DesignSystem/RizumGlass.Tokens.xaml" />
    </ResourceDictionary.MergedDictionaries>
  </ResourceDictionary>
</Application.Resources>
```

The exact MSBuild include path depends on where the submodule sits. Treat a successful Windows build as the authority; do not copy generated values into a second hand-maintained dictionary.

The generated `Default`, `Dark`, and `HighContrast` resource dictionaries allow WinUI to follow the application theme without a second hand-maintained palette. Dark mode keeps a solid neutral window background and does not add cursor-following lighting.

## Material Boundary

- Use Mica or Mica Alt as a window-level backdrop when it supports the product hierarchy.
- Reserve Desktop Acrylic for transient surfaces such as menus, teaching tips, and flyouts.
- Keep ordinary content panels neutral. The generated panel brush is a stable translucent fallback, not a demand to blur every rectangle.
- Respect transparency, high-contrast, energy-saving, and remote-session fallbacks. Meaning must survive when material effects are disabled.
- Preserve the Rizum Glass hierarchy through neutral surfaces, a light border, restrained shadow, typography, and spacing before attempting exact optical parity with CSS backdrop filters.

## Motion Boundary

Prefer compositor-friendly transforms, opacity, and clip animation. Avoid animating `Width`, `Height`, or layout-heavy properties when a visual transform communicates the same change. Use connected or coordinated motion only when it clarifies continuity. Every custom animation needs an interrupted state and a reduced-motion alternative.

Verify current APIs against Microsoft documentation because Windows App SDK capabilities change over time:

- [WinUI 3](https://learn.microsoft.com/windows/apps/winui/winui3/)
- [Windows App SDK](https://learn.microsoft.com/windows/apps/windows-app-sdk/)
- [Materials](https://learn.microsoft.com/windows/apps/develop/ui/materials)
- [XAML and Composition interop](https://learn.microsoft.com/windows/apps/develop/composition/xaml-comp-interop)
