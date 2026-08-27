# Visual References

The complete product-neutral light and dark galleries are the only active visual references for Rizum Glass. `DESIGN.md` remains canonical.

## Active Reference

- `rizum-glass-ui-gallery-v11.html` is the current curated reusable light appearance gallery.
- `rizum-glass-ui-gallery-dark-v11.html` contains the same curated component and interaction coverage using the approved solid-canvas dark appearance, readable semantic text roles, continuous-plane search, and softened shallow-control reflections.
- `icons/game-icon-pack/` contains the icon subset used by that snapshot, sourced from [Nieobie/Game-Icon-Pack](https://github.com/Nieobie/Game-Icon-Pack) and stored with its upstream license.

The `v1` through `v10` light and dark galleries remain versioned historical snapshots. They are not active references.

## Archive

- `archive/nolnol-ui-prototype-v14.2.html` preserves the original product-specific source snapshot. It is historical evidence only. Do not use it to guide new product UI or copy its labels, feature inventory, information architecture, or flows.

The HTML references load Tailwind from a CDN and need internet access for complete rendering. Their game-icon paths remain relative to this directory.

## How To Use References

1. Read `../DESIGN.md` first.
2. Use only the light or dark `rizum-glass-ui-gallery` file that matches the target appearance.
3. Generalize any useful lesson before adding it to the canonical guide.
4. Do not copy product labels, feature names, information architecture, or screen flows into an unrelated project.
5. Keep only reviewed component families in the active gallery. Unfinished experiments belong in an older snapshot or a transfer test, not as hidden panels in the current reference.
6. Add a new versioned gallery when the active reference evolves. Never overwrite an older gallery.

The reference can contradict a newer canonical rule because it records a moment in the design process. In that case, `DESIGN.md` wins.
