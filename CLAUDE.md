# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

KDE Indigo: complete **Plasma 6 Desktop Theme** (indigo/violet, dark) based on CachyOS Emerald. Bundles color scheme, desktop theme, look-and-feel global theme, GTK2/3 themes, and Kvantum theme. UI text and comments in Spanish.

This is a Desktop Theme + Global Theme — **not** an Application Style. Pair with Breeze or Kvantum as Application Style.

## Commands

```bash
./install.sh           # Install (option 1 = user, option 2 = system w/ sudo)
./uninstall.sh         # Full removal incl. GTK config cleanup

# Apply after edits (Plasma 6)
plasma-apply-lookandfeel -a com.github.t4toh.kde-indigo-round
plasma-apply-colorscheme KDEIndigo
plasma-apply-desktoptheme KDE-Indigo-round
kvantummanager --set KDEIndigo

# Force reload (clears Plasma SVG cache — required when SVGs change)
rm -rf ~/.cache/plasma* ~/.cache/ksycoca*
kquitapp6 plasmashell && kstart plasmashell    # Plasma 6
kquitapp5 plasmashell && kstart5 plasmashell   # Plasma 5 fallback
```

`install.sh` auto-purges `~/.cache/plasma*` and prior installs before copying — required for SVG changes to take effect.

## Architecture

Theme = 5 independent layers, each lives in its own subsystem path on install:

| Source | Install path (user) | Controls |
|--------|--------------------|---------|
| `color-schemes/KDEIndigo.colors` | `~/.local/share/color-schemes/` | Qt/KDE app colors |
| `plasma/desktoptheme/KDE-Indigo-round/` | `~/.local/share/plasma/desktoptheme/` | Panel, widgets, notifications |
| `plasma/lookandfeel/com.github.t4toh.kde-indigo-round/` | `~/.local/share/plasma/look-and-feel/` | Global Theme bundle (ties layers together) |
| `gtk-2.0/`, `gtk-3.0/` | `~/.themes/KDE-Indigo/` | Firefox, LibreOffice, GIMP |
| `Kvantum/KDEIndigo/` | `~/.config/Kvantum/` | Advanced Qt styling |

Global Theme (`lookandfeel`) is the entry point — applying it cascades color scheme + desktop theme. `install.sh` prefers `plasma-apply-lookandfeel` and falls back to per-component apply commands.

## Editing Conventions

### SVGs are gzip-compressed (`.svgz`)
Notification padding lives in `plasma/desktoptheme/KDE-Indigo-round/dialogs/background.svgz`. Workflow:
```bash
gunzip -c background.svgz > background.svg
# edit hint-{top,bottom,left,right}-margin width/height (default 16px)
gzip -c background.svg > background.svgz && rm background.svg
```

### Color format = RGB tuples, not hex
`.colors` files use `BackgroundNormal=24,24,37` (not `#181825`). Same for `plasma/desktoptheme/KDE-Indigo-round/colors`.

### Visual effects in `metadata.desktop`
```ini
[AdaptiveTransparency] enabled=true
[ContrastEffect] contrast=1.2 intensity=0.50 saturation=1.5
```

## Color Palette (canonical)

- Indigo `#673AB7` (103,58,183) — DecorationFocus
- Purple `#9C27B0` (156,39,176) — DecorationHover
- BG dark `#181825` (24,24,37) — BackgroundNormal
- BG alt `#1E1E2E` (30,30,46) — BackgroundAlternate
- Text `#CDD6F4` (205,214,244) — ForegroundNormal
- Inactive `#A1A9B1` (161,169,177)
- Positive `#A6DA95` / Negative `#ED333B`

`COLORS.md` has the full palette.

## Gotchas

- After SVG edits, **must** clear `~/.cache/plasma*` or changes are invisible (install.sh does this).
- Uninstall must clean `~/.config/gtk-3.0/settings.ini` — stale `gtk-theme-name=KDE-Indigo` keeps colors violet after switching themes.
- GTK apps need full process restart (not window close) to pick up theme changes.
- Theme is targeted at Plasma 6 (`install.sh` v2.0); legacy Plasma 5 paths still partly present in docs.
