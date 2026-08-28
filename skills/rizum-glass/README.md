# Rizum Glass Skill

This Skill applies the Rizum Glass design system to browser references and desktop products. It uses an approved interactive web reference as the design source, GPUIX as the default new desktop delivery stack, and direct GPUI only for a documented lower-level exception.

## Installation

Copy the `rizum-glass` directory into the host's Skill directory, or install it through the repository mechanism used by that host. Keep the complete `references/`, `evals/`, and `agents/` directories beside `SKILL.md`.

## Usage

Invoke `$rizum-glass` when designing or revising a Rizum Glass surface. The Agent must approve or locate the interactive browser reference first, then follow the GPUIX translation guide for new desktop delivery. Existing products keep their current toolkit unless the user explicitly authorizes a migration.

## Configuration

No runtime secret or account is required. Pin the consuming product's GPUIX package and record its version, platform-window decisions, native calibration, interaction ownership, and capability fallbacks in the target-specific reference contract.

## What it enforces

- Product-neutral visual, spacing, typography, material, motion, and platform-window rules from `references/DESIGN.md`.
- A web-first approval workflow before native translation.
- Optical native calibration at the target operating-system scale.
- Explicit ownership for text selection, pointer capture, wheel routing, overlays, and sensitive values.
- Reusable compact-control recipes and documented fallbacks for unavailable GPUIX capabilities.
- Promotion of field-tested lessons only after an unrelated transfer test.

## Package notes

`agents/openai.yaml` is an optional Codex/OpenAI host adapter. The design guidance itself remains product-neutral, but the complete package is intentionally not host-universal while that adapter is present.

## Compatibility and dependencies

The reference workflow assumes React, TypeScript, Vite, Tailwind CSS, and shadcn/ui. New desktop delivery assumes Bun, React 19, and the consuming product's pinned `@gpuix/react` release. Direct GPUI requires the pinned Rust renderer and is an exception, not a second default. GPUIX is pre-1.0, so supported props and behavior must be verified against the installed package source.

## Security, data, and permissions

The Skill changes visual and interaction guidance; it does not authorize toolkit migration, network access, account use, secret storage, or product-architecture replacement. Keep credentials in the consuming product's trusted persistence layer and never place plaintext secrets in browser UI state or reference artifacts.

Read `SKILL.md` for routing and invariants. Do not use archived galleries or product screenshots as specifications.
