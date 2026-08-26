# WinUI 3 Adoption Handoff

Use this prompt when handing a new or early-stage Windows project to another coding agent. Replace bracketed paths and product-specific details before sending it.

```text
Change the desktop UI direction from WPF to WinUI 3. The product is still early, so prefer a clean native shell over preserving a WPF presentation layer. Preserve working domain services, models, persistence code, and tests unless the migration genuinely requires a boundary change.

Target stack:
- C# + .NET 8
- WinUI 3 on the current stable Windows App SDK
- CommunityToolkit.Mvvm
- Microsoft.Extensions.DependencyInjection
- Microsoft.UI.Composition only where standard XAML transitions are insufficient

Architecture boundaries:
- XAML Views declare layout, bindings, visual states, and accessibility.
- ViewModels own observable UI state and commands.
- Services own business logic, I/O, persistence, and integrations.
- Code-behind is limited to window lifecycle, visual-tree access, and narrowly scoped Composition interop. Do not place product state or business workflows in code-behind.
- Do not introduce a WPF/WinUI hybrid unless an existing dependency makes it unavoidable and the boundary is documented.

Rizum Glass integration:
1. Add or update [path-to-rizum-glass] as `design/rizum-glass`.
2. Read `design/rizum-glass/DESIGN.md` first.
3. Read `design/rizum-glass/adapters/winui/README.md` and `design/rizum-glass/skills/rizum-glass/references/winui-translation.md`.
4. Include `adapters/winui/generated/RizumGlass.Tokens.xaml` as a linked XAML Page and merge it into `App.xaml`. Include `RizumGlass.Motion.cs` without copying its values into a second constants file.
5. For each non-trivial surface, first build or locate the approved React + TypeScript + Vite + Tailwind CSS + shadcn/ui reference. Complete a WinUI reference contract before translating the surface.
6. Start with standard WinUI controls. Apply Rizum Glass through generated resources, composition, layout, typography, material, and motion rather than replacing control behavior.
7. Keep confirm, cancel, dismiss, and ordinary action buttons on the same neutral shell. Express semantics through wording and a sparse icon accent, not large colored button fills.

Migration workflow:
1. Audit the current solution and identify presentation-only WPF code versus reusable services/models.
2. Create the WinUI 3 application shell and dependency-injection composition root.
3. Port one representative screen and its full state table first. Use it to validate the design-system integration before migrating the remaining views.
4. Move state and commands out of code-behind as each surface is ported.
5. Remove the WPF shell only after the WinUI path builds and the preserved services/tests pass.

Verification:
- Build the full solution and run existing tests.
- Verify keyboard navigation, visible focus, screen-reader labels, high contrast, transparency disabled, and reduced motion.
- Test long Chinese and English labels at 100%, 150%, and 200% scale.
- Inspect transitions while they run and when interrupted; do not approve motion from final screenshots alone.
- Prefer transform and opacity animation over Width/Height or other layout-heavy animation.
- Check current WinUI and Windows App SDK APIs against official Microsoft documentation rather than guessing from WPF or web APIs.

Proceed with the audit and migration. Ask only when a destructive choice would remove working product behavior or when a required dependency cannot run on WinUI 3.
```
