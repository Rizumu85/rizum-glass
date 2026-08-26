#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const sourcePath = path.join(repoRoot, "tokens", "rizum-glass.tokens.json");
const themePath = path.join(repoRoot, "adapters", "gpui", "themes", "rizum-glass.json");
const rustPath = path.join(
  repoRoot,
  "adapters",
  "gpui",
  "generated",
  "rizum_glass_tokens.rs",
);

const tokens = JSON.parse(fs.readFileSync(sourcePath, "utf8"));

function color(name) {
  const value = tokens.color?.[name]?.$value?.hex;
  if (!value) throw new Error(`Missing color token: ${name}`);
  return value.toUpperCase();
}

function length(group, name) {
  const token = tokens[group]?.[name]?.$value;
  if (!token || typeof token.value !== "number") {
    throw new Error(`Missing length token: ${group}.${name}`);
  }
  if (token.unit === "px") return token.value;
  if (token.unit === "rem") return token.value * 16;
  throw new Error(`Unsupported unit for ${group}.${name}: ${token.unit}`);
}

function fontSize(name) {
  const token = tokens.typography?.[name]?.$value?.fontSize;
  if (!token || typeof token.value !== "number") {
    throw new Error(`Missing typography token: ${name}`);
  }
  return token.unit === "rem" ? token.value * 16 : token.value;
}

function firstFontFamily(name) {
  const value = tokens.typography?.[name]?.$value?.fontFamily;
  if (typeof value !== "string" || value.length === 0) {
    throw new Error(`Missing font family token: ${name}`);
  }
  const quoted = value.match(/^['"]([^'"]+)['"]/);
  return quoted ? quoted[1] : value.split(",", 1)[0].trim();
}

function rgbLiteral(hex) {
  return `0x${hex.replace("#", "")}`;
}

function rustFloat(value) {
  return Number.isInteger(value) ? `${value}.0` : String(value);
}

const surface = color("surface");
const surfaceMuted = color("surface-muted");
const surfaceLine = color("surface-line");
const ink = color("ink");
const inkSoft = color("ink-soft");
const inkMuted = color("ink-muted");
const caption = color("caption");
const teal = color("accent-teal");
const cyan = color("accent-cyan");
const yellow = color("accent-yellow");
const violet = color("accent-violet");
const rose = color("accent-rose");
const mint = color("accent-mint");

const theme = {
  $schema:
    "https://github.com/longbridge/gpui-component/raw/refs/heads/main/.theme-schema.json",
  name: "Rizum Glass",
  author: "Rizum Glass contributors",
  url: "https://github.com/Rizumu85/rizum-glass",
  themes: [
    {
      is_default: true,
      name: "Rizum Glass Light",
      mode: "light",
      "font.size": fontSize("body-ui"),
      "font.family": ".SystemUIFont",
      "mono_font.family": "Menlo",
      "mono_font.size": fontSize("mono-note"),
      radius: length("rounded", "sm"),
      "radius.lg": length("rounded", "xl"),
      shadow: true,
      colors: {
        "accent.background": surfaceMuted,
        "accent.foreground": inkSoft,
        "accordion.background": surface,
        background: color("canvas"),
        border: surfaceLine,
        "group_box.background": surface,
        "group_box.foreground": inkSoft,
        caret: ink,
        "chart.1": teal,
        "chart.2": cyan,
        "chart.3": yellow,
        "chart.4": violet,
        "chart.5": rose,
        "danger.background": surface,
        "danger.active.background": surfaceMuted,
        "danger.foreground": inkSoft,
        "danger.hover.background": surfaceMuted,
        "description_list.label.background": surfaceMuted,
        "description_list.label.foreground": inkMuted,
        "drag.border": teal,
        "drop_target.background": `${teal}26`,
        foreground: ink,
        "info.background": surface,
        "info.active.background": surfaceMuted,
        "info.foreground": inkSoft,
        "info.hover.background": surfaceMuted,
        "input.border": surfaceLine,
        link: inkSoft,
        "link.active": ink,
        "link.hover": ink,
        "list.background": surface,
        "list.active.background": `${teal}1F`,
        "list.active.border": teal,
        "list.even.background": surface,
        "list.head.background": surfaceMuted,
        "list.hover.background": surfaceMuted,
        "muted.background": surfaceMuted,
        "muted.foreground": inkMuted,
        "popover.background": surface,
        "popover.foreground": inkSoft,
        "primary.background": surface,
        "primary.active.background": surfaceMuted,
        "primary.foreground": inkSoft,
        "primary.hover.background": surfaceMuted,
        "progress.bar.background": teal,
        ring: teal,
        "scrollbar.background": "#FFFFFF00",
        "scrollbar.thumb.background": `${caption}80`,
        "scrollbar.thumb.hover.background": caption,
        "secondary.background": surface,
        "secondary.active.background": surfaceMuted,
        "secondary.foreground": inkSoft,
        "secondary.hover.background": surfaceMuted,
        "selection.background": `${teal}45`,
        "sidebar.background": surface,
        "sidebar.accent.background": surfaceMuted,
        "sidebar.accent.foreground": inkSoft,
        "sidebar.border": surfaceLine,
        "sidebar.foreground": inkSoft,
        "sidebar.primary.background": surface,
        "sidebar.primary.foreground": inkSoft,
        "skeleton.background": surfaceMuted,
        "slider.background": surfaceLine,
        "slider.thumb.background": inkMuted,
        "success.background": surface,
        "success.active.background": surfaceMuted,
        "success.foreground": inkSoft,
        "success.hover.background": surfaceMuted,
        "bullish.background": mint,
        "bearish.background": rose,
        "switch.background": surfaceLine,
        "switch.thumb.background": surface,
        "tab.background": "#FFFFFF00",
        "tab.active.background": surface,
        "tab.active.foreground": inkSoft,
        "tab_bar.background": surfaceMuted,
        "tab_bar.segmented.background": surfaceMuted,
        "tab.foreground": inkMuted,
        "table.background": surface,
        "table.active.background": `${teal}1F`,
        "table.active.border": teal,
        "table.even.background": surface,
        "table.head.background": surfaceMuted,
        "table.head.foreground": inkMuted,
        "table.hover.background": surfaceMuted,
        "table.row.border": surfaceLine,
        "tiles.background": surface,
        "title_bar.background": color("canvas"),
        "title_bar.border": surfaceLine,
        "warning.background": surface,
        "warning.active.background": surfaceMuted,
        "warning.foreground": inkSoft,
        "warning.hover.background": surfaceMuted,
        overlay: "#18181B14",
        "window.border": surfaceLine,
        "base.red": rose,
        "base.red.light": `${rose}40`,
        "base.green": mint,
        "base.green.light": `${mint}40`,
        "base.blue": cyan,
        "base.blue.light": `${cyan}40`,
        "base.yellow": yellow,
        "base.yellow.light": `${yellow}40`,
        "base.magenta": violet,
        "base.magenta.light": `${violet}40`,
        "base.cyan": teal,
        "base.cyan.light": `${teal}40`,
      },
    },
  ],
};

const rustColors = [
  "ink",
  "ink-soft",
  "ink-muted",
  "caption",
  "canvas",
  "surface",
  "surface-muted",
  "surface-line",
  "accent-teal",
  "accent-cyan",
  "accent-orange",
  "accent-yellow",
  "accent-violet",
  "accent-rose",
  "accent-mint",
];

const rust = `// Generated by scripts/export-gpui-theme.mjs. Do not edit by hand.\n\
\n\
pub const WEB_REFERENCE_STACK: &str = "React + TypeScript + Vite + Tailwind CSS + shadcn/ui + Rizum Glass";\n\
pub const DISPLAY_FONT_FAMILY: &str = "${firstFontFamily("display-serif")}";\n\
pub const TITLE_FONT_FAMILY: &str = "${firstFontFamily("title-serif")}";\n\
pub const BODY_FONT_SIZE_PX: f32 = ${rustFloat(fontSize("body-ui"))};\n\
pub const TITLE_FONT_SIZE_PX: f32 = ${rustFloat(fontSize("title-serif"))};\n\
pub const DISPLAY_FONT_SIZE_PX: f32 = ${rustFloat(fontSize("display-serif"))};\n\
pub const MONO_FONT_SIZE_PX: f32 = ${rustFloat(fontSize("mono-note"))};\n\
pub const PANEL_RADIUS_PX: f32 = ${rustFloat(length("rounded", "xl"))};\n\
pub const CONTROL_RADIUS_PX: f32 = ${rustFloat(length("rounded", "sm"))};\n\
pub const SPACE_XS_PX: f32 = ${rustFloat(length("spacing", "xs"))};\n\
pub const SPACE_SM_PX: f32 = ${rustFloat(length("spacing", "sm"))};\n\
pub const SPACE_MD_PX: f32 = ${rustFloat(length("spacing", "md"))};\n\
pub const SPACE_LG_PX: f32 = ${rustFloat(length("spacing", "lg"))};\n\
pub const SPACE_XL_PX: f32 = ${rustFloat(length("spacing", "xl"))};\n\
${rustColors
  .map(
    (name) =>
      `pub const COLOR_${name.replaceAll("-", "_").toUpperCase()}: u32 = ${rgbLiteral(color(name))};`,
  )
  .join("\n")}\n`;

fs.mkdirSync(path.dirname(themePath), { recursive: true });
fs.mkdirSync(path.dirname(rustPath), { recursive: true });
fs.writeFileSync(themePath, `${JSON.stringify(theme, null, 2)}\n`);
fs.writeFileSync(rustPath, rust);
console.log(`Exported ${path.relative(repoRoot, themePath)} and ${path.relative(repoRoot, rustPath)}.`);
