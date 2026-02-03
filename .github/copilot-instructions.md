# KDE Indigo Theme - Copilot Instructions

## Project Overview

KDE Indigo is a complete Plasma theme based on CachyOS Emerald, featuring an indigo/violet dark color scheme. This is a **Desktop Theme**, not an Application Style - it controls the visual appearance of the desktop environment (panel, notifications, widgets), color schemes, GTK themes, and Kvantum themes.

## Installation and Testing

### Installation
```bash
# Install for current user (recommended)
./install.sh
# Then select option 1

# Install system-wide (requires sudo)
./install.sh
# Then select option 2
```

### Uninstallation
```bash
./uninstall.sh
```

### Apply Changes After Editing
```bash
# Restart Plasma shell
kquitapp5 plasmashell && kstart5 plasmashell

# Or apply specific components
plasma-apply-colorscheme KDEIndigo
plasma-apply-desktoptheme KDE-Indigo-round

# For Kvantum (if installed)
kvantummanager --set KDEIndigo
```

## Project Architecture

### Component Breakdown

| Component | Location | Purpose | Affects |
|-----------|----------|---------|---------|
| **Color Scheme** | `color-schemes/KDEIndigo.colors` | Text, backgrounds, buttons colors | KDE/Qt native apps |
| **Desktop Theme** | `plasma/desktoptheme/KDE-Indigo-round/` | Panel, widgets, notifications appearance | Entire Plasma environment |
| **GTK2 Theme** | `gtk-2.0/gtkrc` | Legacy GTK apps styling | Old GTK apps |
| **GTK3 Theme** | `gtk-3.0/gtk.css` | Modern GTK apps styling | Firefox, LibreOffice, GIMP, Thunderbird |
| **Kvantum Theme** | `Kvantum/KDEIndigo/` | Advanced Qt control styling | Qt non-native apps, Telegram |

### Key Files

- `color-schemes/KDEIndigo.colors` - Main color definitions (RGB values, all theme colors)
- `plasma/desktoptheme/KDE-Indigo-round/metadata.desktop` - Theme metadata, contrast/saturation settings
- `plasma/desktoptheme/KDE-Indigo-round/colors` - Plasma-specific color definitions
- `plasma/desktoptheme/KDE-Indigo-round/dialogs/background.svgz` - Notification padding and dialog appearance (compressed SVG)
- `install.sh` - Automatic installation script with user/system-wide options
- `uninstall.sh` - Complete theme removal

## Color Palette

Primary colors (used throughout the codebase):

- **Primary Indigo**: `#673AB7` (RGB: 103, 58, 183) - Focus, primary buttons, links
- **Secondary Purple**: `#9C27B0` (RGB: 156, 39, 176) - Hover states, interactive elements
- **Dark Background**: `#181825` (RGB: 24, 24, 37) - Main windows, content areas
- **Alt Background**: `#1E1E2E` (RGB: 30, 30, 46) - Sidebars, panels, buttons
- **Primary Text**: `#CDD6F4` (RGB: 205, 214, 244) - Normal text
- **Inactive Text**: `#A1A9B1` (RGB: 161, 169, 177) - Secondary text, placeholders
- **Positive**: `#A6DA95` (RGB: 166, 218, 149) - Success states
- **Negative**: `#ED333B` (RGB: 237, 51, 59) - Error states

## Key Conventions

### Editing SVG Files

SVG files in `plasma/desktoptheme/KDE-Indigo-round/dialogs/` are **compressed** (.svgz):

```bash
# 1. Decompress before editing
cd plasma/desktoptheme/KDE-Indigo-round/dialogs
gunzip -c background.svgz > background.svg

# 2. Edit the SVG
# Notification padding controlled by elements with IDs:
#   - hint-top-margin
#   - hint-bottom-margin
#   - hint-left-margin
#   - hint-right-margin
# Current padding: 16px (width/height attributes)

# 3. Recompress after editing
gzip -c background.svg > background.svgz
rm background.svg
```

### Color Scheme Format

Colors in `.colors` files use RGB format (0-255), not hex:

```ini
[Colors:Window]
BackgroundNormal=24,24,37      # Not #181825
DecorationFocus=103,58,183     # Not #673AB7
```

### GTK Theme Integration

GTK themes require both installation AND configuration:

1. Theme files copied to `~/.themes/KDE-Indigo/` or `/usr/share/themes/KDE-Indigo/`
2. Configuration in `~/.config/gtk-3.0/settings.ini`:
   ```ini
   [Settings]
   gtk-theme-name=KDE-Indigo
   gtk-application-prefer-dark-theme=true
   ```
3. Environment variable: `export GTK_THEME=KDE-Indigo` (in `~/.bashrc` or `~/.zshrc`)

Apps like Firefox/LibreOffice need to be **fully restarted** (not just window closed) to apply GTK theme changes.

### Desktop Theme vs Application Style

**Desktop Theme** (this project):
- Controls: panel, notifications, widgets, menus
- Located in: `~/.local/share/plasma/desktoptheme/`
- Applied via: System Settings → Appearance → Plasma Theme

**Application Style** (NOT included):
- Controls: button shapes, sliders, checkboxes behavior
- Examples: Breeze, Oxygen, Kvantum
- Recommended: Use Breeze or Kvantum as Application Style with this theme

### Contrast and Visual Effects

Visual effects configured in `metadata.desktop`:

```ini
[ContrastEffect]
contrast=7          # Range: 1-10 (higher = more definition)
enabled=true
intensity=2         # Range: 1-3 (higher = more vibrant)
saturation=1.7      # Range: 0.5-2.0 (color saturation)
```

## Customization Patterns

### Modifying Main Colors

Edit `color-schemes/KDEIndigo.colors`:
- `DecorationFocus` - Primary accent color
- `DecorationHover` - Hover state color
- `BackgroundNormal` - Main background
- `ForegroundNormal` - Main text color

After changes: reinstall with `./install.sh` and apply via System Settings.

### Creating Theme Variants

1. Copy `KDEIndigo.colors` to new name (e.g., `KDEIndigoLight.colors`)
2. Modify color values (keep RGB format)
3. Copy `plasma/desktoptheme/KDE-Indigo-round/` to new directory
4. Update `metadata.desktop` with new name and description
5. Install using script or manual copy to `~/.local/share/`

## Common Troubleshooting

### Colors persist after switching themes
- GTK settings in `~/.config/gtk-3.0/settings.ini` may force theme
- Solution: Run `./uninstall.sh` or manually edit `settings.ini`

### GTK apps (Firefox/LibreOffice) don't apply theme
- Theme files must be in `~/.themes/KDE-Indigo/` (user) or `/usr/share/themes/KDE-Indigo/` (system)
- GTK settings must reference "KDE-Indigo" in `~/.config/gtk-3.0/settings.ini`
- Apps must be **fully closed** and reopened (not just window closed)
- Log out and back in if still not applied

### Notifications have wrong padding
- Padding controlled by SVG elements in `dialogs/background.svgz`
- Must decompress → edit → recompress → reinstall
- Current default: 16px margins

## Reference Documentation

- `README.md` - Installation instructions, component overview, troubleshooting
- `STRUCTURE.md` - File structure, required files for basic functionality
- `COLORS.md` - Complete color palette with hex/RGB, color customization tips
- `CUSTOMIZATION.md` - Advanced customization guide, variant creation, VS Code/Firefox integration
- `CHANGELOG.md` - Version history
