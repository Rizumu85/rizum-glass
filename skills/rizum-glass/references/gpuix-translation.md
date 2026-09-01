# GPUIX Translation

Use this workflow after a Rizum Glass browser reference is approved. GPUIX is the default desktop delivery adapter for new Rizum Glass applications.

## Stack Contract

- Bun for package management, development, and standalone compilation.
- TypeScript in strict mode with `jsxImportSource: "@gpuix/react"`.
- React 19.
- An exact pinned `@gpuix/react` version. Record the version in the reference contract because GPUIX is pre-1.0.
- GPUI through `@gpuix/native`, supplied by GPUIX. Do not add a second GPUI host unless the application has a documented lower-level boundary.

## Windows Typeface Contract

Use the canonical Windows role set without depending on machine-installed fonts:

- `MiSans VF` for ordinary interface text;
- `Noto Serif SC` from `NotoSerifSC-VF.ttf` for contextual and section titles;
- `Cascadia Mono` for URLs, time, aligned data, and code-like text.

Ship the exact font files and their license notices in every installer and portable archive. Register them process-private before the first GPUIX `render()` call so the renderer measures and rasterizes the intended faces from its first frame. Verify the packaged executable on a Windows account or environment that has not installed those families separately. Do not copy the files into the system Fonts directory, require administrator access, or let a developer-machine fallback become part of the approved geometry.

GPUIX provides React bindings for GPUI. React owns component composition and presentation state; the GPUIX reconciler sends mutations through the native binding; GPUI lays out and paints the retained native tree.

## Required Inputs

- An approved interactive browser reference built with the Rizum Glass reference baseline.
- State screenshots or recordings at named logical sizes and scale factors.
- A completed `reference-contract.json` conforming to `adapters/gpuix/reference-contract.schema.json`.
- The consuming project's pinned Bun, React, `@gpuix/react`, and `@gpuix/native` versions.
- A platform-chrome decision for Windows and macOS, including the fallback used when exact title-bar geometry is unavailable.

If a visual input is missing, return to the browser reference. Do not fill gaps by taste in TSX.

## Translation Order

1. Import generated semantic values from `adapters/gpuix/generated/rizum-glass-tokens.ts`. Do not maintain a second local palette.
2. Use GPUIX host elements and supported headless components for focus, input, scrolling, selection, menus, tooltips, and virtualized content before writing a custom native element.
3. Translate intrinsic, minimum, preferred, and maximum dimensions from the contract. The browser stage and ambient canvas are evidence context, not an extra desktop shell.
4. Set explicit text colors. GPUIX text does not reliably inherit browser CSS color semantics.
5. Port each named interaction state and motion phase. Prefer GPUIX native hover/active styles and native motion where they avoid a JavaScript round trip.
6. Compare matching states at matching logical dimensions. Use GPUIX automation and screenshot capture when the consuming repository permits them.
7. Record material differences. Preserve neutral translucency, edge reflection, shadow hierarchy, and platform silhouette before chasing identical blur.

## Capability Audit Before Translation

Inspect the exact installed GPUIX declaration files and native package before choosing an implementation. Record each unsupported or partial behavior in the reference contract instead of discovering it one component at a time.

Verify at least:

- which style values text, images, inputs, and motion components actually accept;
- whether text color inherits or must be explicit on every visible run;
- which motion properties exist, whether repeat and transforms exist, and whether animation is presentation-synchronized on the target platform;
- whether rounded overflow clips child paint or the child must carry the same radius;
- how native inputs capture the pointer, continue selection outside the field or window, and expose caret geometry;
- where wheel events go when a fixed root, bounded menu, or deliberate scroll body is under the pointer;
- which title-bar insets, caption rectangles, native commands, window states, and blur materials are publicly available.

Treat missing behavior as a capability boundary, not an invitation to imitate the browser with polling or layout-heavy timers. Prefer a stable native fallback, document it, and revisit it when the pinned runtime changes.

## Runtime Query Lifecycle Safety

Treat GPUIX geometry, scroll, automation, and window queries as frame-bound capabilities, not permanently available services. A minimized, hidden, closing, or transitioning native window may stop presenting frames while a synchronous binding waits for renderer state. A timeout in an interaction aid must never terminate the Bun process or long-running work that it owns.

- Route `getElementBounds`, `getWindowSize`, `getScrollOffset`, `scrollTo`, and equivalent renderer queries through one project-level adapter. Validate returned geometry and convert runtime exceptions or timeouts into “unavailable this frame.”
- Keep domain work independent from presentation-query availability. If a query is unavailable, skip that interaction frame, preserve durable work and child processes, and retry only after the relevant window or overlay is renderable again.
- Before minimizing, hiding, closing, or replacing a native window, release pointer capture, drag state, text-selection extension, and overlay-specific polling. Resume them only after the window is restored and the renderer can answer.
- Gate timers and pointer polls on native window state. Never call frame-bound renderer queries from an unconditional high-frequency interval.
- Prefer native or headless component behavior. If a narrow platform adapter is required, keep its polling interruptible, bounded, and disposable; a missing browser-like behavior does not justify an unbounded geometry loop.
- Apply the same boundary to popovers, selects, custom scrollbars, tooltips, and automation helpers so lifecycle safety does not depend on which component initiated the query.

Verify minimize/restore, hide/show, close during interaction, and overlay dismissal while editable fields and long-running work are active. Use at least one physical pointer and keyboard pass for logic that reads operating-system input state: posted window messages and renderer simulation may not update platform APIs such as Windows `GetAsyncKeyState`, so they cannot be the sole evidence. Confirm that the application and its long-running child work remain alive when presentation is suspended, and that no uncaught query timeout reaches stderr.

## Optical Native Calibration

Do not apply browser dimensions mechanically. Launch the real window at the target operating-system scale and compare physical legibility with the approved reference.

When correction is needed:

1. Choose one evidence-backed native scale correction rather than patching isolated components.
2. Scale body type, controls, hit targets, content insets, dense control columns, seek geometry, and content-sized window bounds together.
3. Apply only small renderer-specific optical corrections to text when necessary.
4. Keep radii, one-pixel borders, divider alpha, and shadow roles on their semantic hierarchy; do not inflate them mathematically.
5. Allow a contextual title to remain at its approved optical size when scaling it would overpower the platform controls.
6. Capture idle, dense, settings, and secondary surfaces at the corrected native size and record the correction and exceptions in the contract.

The reference and native window may therefore have different logical dimensions while preserving the same composition. That difference is acceptable only when it is deliberate and evidenced.

## Interaction Ownership

Assign ownership explicitly before styling:

- The application shell disables selection for static interface copy.
- Native editors opt back into text selection and IME behavior.
- Copy actions are the primary affordance for generated values that are not meant to be edited.
- Pointer capture or a narrow platform adapter keeps text selection and dragging alive when the pointer leaves the field or product window.
- A fixed utility root does not scroll when all content fits. Only a named bounded body or overlay owns wheel input.
- Sensitive values stay in the trusted service or native core. The presentation requests plaintext only after explicit reveal and clears it again on hide or reset.

Do not replace native editor, focus, or selection behavior with painted text merely to match a screenshot.

## Component Translation Recipes

Use these recipes as starting contracts, then insert the approved product dimensions.

### Compact text fields

- Let an outer `div` own the full field height, background, outline, radius, padding, and trailing action.
- Give the native `input` its measured line-box height and optical vertical offset instead of stretching its caret to the whole shell.
- Reserve the trailing action width in both empty and populated states.
- Use one compact icon action for paste, reveal, or copy. Do not place a second text button beside the field.

### Selects and comboboxes

- Reuse one trigger and floating-menu implementation for every compact select.
- Keep trigger height, open outline, chevron change, anchored offset, menu inset, row height, selected check, and entrance timing identical.
- Put trigger and option labels in bounded clipping regions with ellipsis before the trailing chevron or metadata.
- Give the floating surface its own nearly opaque neutral fill. Do not rely on an ancestor's translucent material when underlying labels remain legible through it.
- Render the control only when the resolved data contains at least two meaningful options. For one option, omit the selection row unless its value remains necessary as static object identity, then reclaim the spacing and content-sized window height.

### Segmented controls

- Use one moving neutral capsule and static labels.
- Permit weighted segment widths for longer localized labels; keep the type role and line box identical across options.
- Animate pointer changes with the approved short motion. Make keyboard changes and reduced-motion changes immediate.

### Range and seek controls

- Separate the two-pixel visual track from a much taller pointer target.
- Update direct manipulation without easing while dragging.
- Keep the current value in quiet tabular text outside the track.
- For media seeking, place a compact play/pause action in the time row when doing so preserves a full-width precision track.

### Anchored popovers

- Constrain the surface to the owning column and the window at every supported content height.
- Reserve the final footprint for QR codes, thumbnails, and similar asynchronous content before it loads.
- Enter from the trigger, exit along the same path more quickly, and keep the shell stable while placeholder and final content crossfade.

### Dynamic status rows

- Keep one alignment grid for compact, action, progress, and error variants.
- Let the row and content-sized window grow together only when detail or an action is present.
- Animate coarse state feedback if useful; update continuous byte counts, percentages, and seek values directly.
- Preserve the footer's bottom safe area after the row expands.

### Complex preview surfaces

- If GPUIX lacks the approved gradient, grain, or clipping primitives, generate one deterministic build asset for the backdrop.
- Apply the approved radius directly to the painted child when parent overflow does not clip it.
- Keep live text and controls native above the asset.
- Do not add a dark outline to conceal clipping artifacts, and do not rasterize the whole component.

## Motion Degradation

Build the motion vocabulary from the pinned runtime's real properties. For runtimes that lack transform, repeat animation, or a public presentation-synchronized callback:

- prefer opacity-only entrances for named surfaces over animating layout properties across the whole page;
- keep coarse copy/save/success feedback inside a fixed control shell;
- assign one animated owner to each replaceable region; do not stack a parent fade with another fade on its nested label or icon;
- make keyboard-triggered state changes immediate;
- make reduced-motion positional changes immediate while retaining semantic color, icon, and text changes;
- keep direct-manipulation values such as seek, range, drag, and progress positions immediate rather than easing or crossfading them;
- allow a transient busy mark one bounded entrance beat, but do not substitute an endless decorative loop for real progress;
- keep continuous previews static rather than driving them with `setInterval`, `setTimeout`, or repeated React state updates;
- do not animate native window resizing with a JavaScript timer;
- when the runtime has no reliable exit-presence lifecycle, unmount a dismissed overlay immediately instead of retaining an opacity-zero hit target;
- clear or replace pending feedback timers when a view unmounts or a newer action supersedes them.

An existing static state is the approved fallback until a smooth native path is proven in a real capture. Do not infer smoothness from a browser prototype.

## Platform Window Shell

Keep platform window controls native. The root Rizum Glass surface reaches the window edge and clips with the system-provided outer silhouette; do not nest the approved product surface inside an additional rounded native card.

On Windows, reserve the real caption-button region on the upper-right for left-to-right layouts and preserve system minimize, maximize/restore, close, Snap Layout, border, shadow, and maximized/snapped geometry. On macOS, reserve the real leading traffic-light region and use standard close, minimize, and zoom buttons. Centered identity must be centered in the unobscured region rather than the raw window width.

Use `useWindowInsets()` when the pinned GPUIX version reports the required platform geometry. The public GPUIX 0.5.1 window options document transparent title bars and configurable macOS traffic-light origin, but do not promise a Windows caption-button rectangle. Capability-check the pinned version. If exact geometry is unavailable, keep that platform's native title bar rather than guessing system-control width or hit targets.

Exception for a deliberately fixed-size utility: when the product does not resize and explicitly accepts the loss of Snap Layout, a platform adapter may reproduce the standard caption slots in React while forwarding drag, minimize, and close to the operating system. Keep unsupported commands visibly disabled, record the exact slot geometry and lost behavior, and label this as an emulated visual fallback rather than native control ownership. Do not use this exception for a resizable window, workspace, editor, or multi-panel canvas.

Window-state rules:

- Normal: use the platform-managed outer radius and one continuous glass material.
- Maximized, snapped, tiled, or full screen: follow the platform silhouette; do not force rounded clipping.
- Inactive: reduce vibrancy or material emphasis in step with the platform while keeping text readable.
- Reduced transparency: use the approved neutral opaque surface and retain hierarchy through border light and shadow.

## Completion Gate

- `bun run typecheck` or the consuming repository's authorized equivalent passes.
- The exact GPUIX version is recorded and no unsupported DOM or CSS API is assumed.
- The component states match the reference contract with long Chinese and English labels.
- Native legibility is inspected at the target operating-system scale; any coherent scale correction and title exception are recorded.
- Keyboard, focus, selection beyond the field/window boundary, IME, drag regions, resize behavior, wheel routing, and native window commands remain intact.
- Windows and macOS top-frame layouts keep interactive content outside their platform-reserved regions.
- Motion is inspected during transitions and after interruption, not only at rest.
- Reduced motion is wired to the platform preference, and continuous motion has a static fallback when the pinned runtime cannot present it smoothly.
- Floating surfaces remain inside the owning column/window and asynchronous content does not change their footprint unexpectedly.
- Static UI text is not selectable, editable values remain selectable, and sensitive plaintext does not persist in presentation state.
- Geometry, scroll, automation, and window queries cross one lifecycle-safe adapter; minimized, hidden, closing, and transitioning states skip an interaction frame instead of throwing.
- Minimize/restore and close-during-interaction are verified with physical input where native input state is involved, and long-running child work survives presentation suspension.
- Material and platform capability fallbacks are documented and intentional.
