# Rizum Glass Design Rationale

This document explains the judgment behind `DESIGN.md`. It is not a second specification. When a numeric value or component rule differs, `DESIGN.md` wins.

## North Star

Rizum Glass should feel present without taking over the room. It is quiet, tactile, compact, and slightly editorial. It borrows qualities rather than appearances:

- **Apple:** material depth, soft edge highlights, carefully staged motion, and strong state continuity.
- **Things:** paper-like breathing room, serif hierarchy, and orderly information without dashboard heaviness.
- **Arc:** spatial transitions, tiny hover movement, and interactions that feel alive without becoming theatrical.

The result is not a monochrome Apple clone, a newspaper theme, or a colorful glass demo. It is a neutral working surface with small moments of character.

## Decision Order

When rules compete, decide in this order:

1. Content remains readable and the next action is clear.
2. The panel hugs its content without clipping or wasteful width.
3. The shell stays neutral and visually calm.
4. Typography and spacing establish hierarchy before decoration does.
5. Accent color communicates a small semantic distinction.
6. Motion clarifies continuity and state change.

Decoration never gets to repair weak hierarchy.

## Material And Color

The canvas is a quiet neutral grey with extremely faint violet, cyan-green, and amber ambient light. It must still read as grey at a glance. A yellow bottom wash, a blue-green page gradient, or a strong purple atmosphere changes the identity too much.

Dark appearance is deliberately stricter: its canvas is one solid near-black neutral. It does not inherit the light appearance's ambient gradients, because colored light becomes much louder against black and quickly turns the interface into a themed demo. Depth comes from neutral surface values, translucency, border light, and shadow.

Glass is made from translucency, high blur, a white inner highlight, a fine white border, and a restrained neutral shadow. Glass should feel airy rather than milky or glossy. White light is the default highlight; colored glow is exceptional.

Color behaves like pointillism. Teal, orange, violet, rose, mint, cyan, and yellow appear in dots, icon strokes, small stamps, status fills, and other tiny semantic marks. A large colored button or tinted panel usually spends too much of the color budget at once.

## Typography

Serif type marks authored or editorial moments: titles, panel headings, service labels, mastheads, and occasional paper-like notes. System sans-serif carries dialogue, controls, menus, settings, and operational metadata.

The distinction matters more than novelty. Mixing serif, sans, mono, and italics without a role makes the interface look accidental. Monospace belongs to code, commands, and file-like fragments. Italics are rare.

Button text is regular weight. Emphasis comes from placement, wording, and an optional semantic micro-icon, not bold labels or a colored shell.

## Compact, Not Cramped

The style does not impose one narrow page width. Each panel should be only as wide as its content needs, plus comfortable padding. A menu, a form, a dialogue bubble, and an editorial card should naturally have different widths.

Compactness fails when labels collide with shortcuts, text wraps unexpectedly, or a control dominates the available line. Width should follow text measure and the widest meaningful control. Empty space is welcome around a cluster of panels, but not as unused acreage inside every panel.

## Controls

Ordinary controls share a neutral white shell, fine grey border, regular grey text, modest radius, and a soft 1px hover lift. A primary or special action should not become a different visual species. When semantic emphasis is useful, add one small palette-colored icon while keeping the shell and label identical to neighboring actions.

Not every button needs an icon. Familiar text commands are often clearer alone. Dismissive actions recede through lighter text, not through a different button shape.

Large pill toggles are avoided because they add visual weight and repetitive machinery. Prefer segmented choices, selectable rows, state chips, icon actions, or a domain-specific control. A replacement must still expose state clearly and remain interactive; novelty is not an excuse for ambiguity.

## Dividers And Grouping

Dividers are a last-mile grouping tool. Major sections may use a faint inset rule. Menus may use short inset rules between command groups. Individual rows should rely on spacing, alignment, and typography instead of becoming a table.

Lines should not touch panel edges or duplicate a nearby border. A title does not automatically earn a line underneath it.

## Motion

Motion should preserve an object's identity across states. A control moves rather than being replaced; a paused sound wave resumes from the same frame; a panel grows from its trigger; a selected card is already near its destination before it lifts.

Good motion uses transforms and opacity, short preparation and settle beats, mild overshoot, and small stagger. It should be easy to follow at normal speed and still look coherent frame by frame. Avoid abrupt keyframe swaps, corrective end-of-animation slides, gratuitous bounce, and multiple simultaneous flourishes competing for attention.

Cursor-following glow is intentionally excluded. It decorates pointer position rather than explaining state, competes with the restrained pointillist color budget, and makes large dark surfaces feel busier without improving their operation. Hover feedback should stay attached to the control or panel being used.

## Editorial And Playful Moments

Editorial asymmetry, stamps, slips, card decks, and collectible glyphs are optional expressive patterns. They belong where the content has a narrative, reward, or artifact quality. They are not generic decorations for settings and utility panels.

These moments still obey the neutral shell and small color budget. A creative component should feel physically layered, but its text and controls remain legible.

## Explicit Avoidances

- Large warm or purple page washes.
- Uniform dashboard cards forced to one width.
- Oversized pill toggles and thick sliders.
- Bold labels for ordinary actions.
- Decorative icons on every button.
- Outline-only stars used as generic corner decoration.
- Emoji used as production interface chrome.
- Dividers after every row or subtitle.
- Serif type leaking into ordinary controls.
- Animation that hides state, resets continuity, or delays routine work.
- Cursor-following canvas glow or panel spotlight effects.
- Visible design-audit copy inside a product sample.
