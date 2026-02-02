# Configuración de Aplicaciones Específicas

Esta guía te ayudará a aplicar el tema KDE Indigo a aplicaciones específicas que pueden requerir configuración adicional.

## Firefox

Firefox usa GTK, así que debería tomar el tema automáticamente después de configurar el tema GTK en KDE.

### Verificar que Firefox use el tema del sistema

1. Escribe en la barra de direcciones: `about:config`
2. Busca: `widget.use-xdg-desktop-portal.file-picker`
3. Establécelo en `1`
4. Reinicia Firefox

### Si Firefox no toma el tema

1. Abre Firefox
2. Ve a Configuración → Extensiones y Temas
3. Busca e instala un tema oscuro como "Firefox Alpenglow" o crea uno personalizado

### Tema personalizado para Firefox (opcional)

Usa Firefox Color (<https://color.firefox.com>) con estos colores:

- **Toolbar**: `#1E1E2E`
- **Toolbar Text**: `#CDD6F4`
- **Acento**: `#673AB7`
- **Background**: `#181825`

## LibreOffice

LibreOffice también usa GTK, pero tiene sus propias preferencias de interfaz.

### Configurar LibreOffice

1. Abre LibreOffice (Writer, Calc, etc.)
2. Ve a **Herramientas** → **Opciones**
3. Selecciona **LibreOffice** → **Vista**
4. En **Tema de iconos**, selecciona **Breeze (oscuro)** o **Karasa Jaga**
5. En **Estilo de aplicación**, selecciona **Automático** o **gtk3**
6. Reinicia LibreOffice

Si los colores aún no coinciden:

- Asegúrate de que el tema GTK esté correctamente aplicado en KDE
- Cierra sesión y vuelve a entrar

## GIMP

GIMP 2.10+ usa GTK3, por lo que debería tomar el tema automáticamente.

### Configurar GIMP

1. Abre GIMP
2. Ve a **Editar** → **Preferencias**
3. Selecciona **Tema**
4. Elige **Sistema** o **Oscuro**
5. Reinicia GIMP

## VS Code / VSCodium

VS Code no usa GTK para el contenido, pero puedes crear un tema que coincida:

### Tema recomendado

Instala la extensión "One Dark Pro" y personaliza:

1. Abre VS Code
2. `Ctrl+Shift+P` → "Preferences: Open Settings (JSON)"
3. Añade:

```json
{
  "workbench.colorTheme": "One Dark Pro",
  "workbench.colorCustomizations": {
    "activityBar.background": "#1E1E2E",
    "activityBar.foreground": "#CDD6F4",
    "editor.background": "#181825",
    "editor.foreground": "#CDD6F4",
    "sideBar.background": "#1E1E2E",
    "sideBar.foreground": "#CDD6F4",
    "statusBar.background": "#673AB7",
    "statusBar.foreground": "#FCFCFC",
    "titleBar.activeBackground": "#1E1E2E",
    "titleBar.activeForeground": "#CDD6F4",
    "tab.activeBackground": "#181825",
    "tab.inactiveBackground": "#1E1E2E"
  }
}
```

## Telegram Desktop

Telegram usa Qt, así que el tema Kvantum debería funcionar.

### Si necesitas ajustes

1. Abre Telegram
2. Configuración → Apariencia
3. Selecciona un tema oscuro base
4. Personaliza los colores de acento a `#673AB7`

O descarga un tema custom de: <https://t.me/themes>

## Discord (BetterDiscord)

Si usas BetterDiscord, puedes crear un tema personalizado:

### CSS personalizado

```css
:root {
  --background-primary: #181825;
  --background-secondary: #1e1e2e;
  --background-tertiary: #313244;
  --background-accent: #673ab7;
  --background-floating: #1e1e2e;
  --text-normal: #cdd6f4;
  --text-muted: #a1a9b1;
  --interactive-normal: #cdd6f4;
  --interactive-hover: #673ab7;
  --interactive-active: #9c27b0;
}
```

## Spotify (Spicetify)

Si usas Spicetify para tematizar Spotify:

### Colores base

```ini
[Base]
main_fg = cdd6f4
secondary_fg = a1a9b1
main_bg = 181825
sidebar_and_player_bg = 1e1e2e
cover_overlay_and_shadow = 000000
indicator_fg_and_button_bg = 673ab7
pressing_fg = fcfcfc
slider_bg = 313244
sidebar_indicator_and_hover_button_bg = 9c27b0
scrollbar_fg_and_selected_row_bg = 673ab7
pressing_button_fg = fcfcfc
pressing_button_bg = 512da8
selected_button = 673ab7
miscellaneous_bg = 1e1e2e
miscellaneous_hover_bg = 313244
preserve_1 = cdd6f4
```

## Thunderbird

Thunderbird usa GTK, similar a Firefox:

1. Abre Thunderbird
2. Ve a Configuración → General
3. En **Idioma y apariencia**, selecciona tema oscuro
4. Reinicia Thunderbird

## Dolphin / Konqueror

Estas apps KDE nativas deberían tomar automáticamente el tema Plasma y el esquema de colores.

Si no es así:

- Verifica que hayas aplicado el tema en Configuración del Sistema
- Cierra sesión y vuelve a entrar

## Chromium / Chrome

Chromium puede usar GTK para decoraciones de ventana:

### Habilitar GTK

1. Ve a `chrome://flags`
2. Busca: `gtk`
3. Habilita "Use GTK"
4. Reinicia Chromium

### Tema alternativo

Busca en Chrome Web Store: "Dark Theme" o crea uno personalizado en:
<https://www.themebeta.com/chrome-theme-creator-online.html>

## Aplicaciones Flatpak

Las apps Flatpak pueden no ver tus temas del sistema.

### Solución

```bash
# Dar acceso a los temas
flatpak override --user --filesystem=~/.themes
flatpak override --user --filesystem=~/.local/share/themes
flatpak override --user --filesystem=/usr/share/themes

# Para aplicaciones GTK específicas:
flatpak override --user --env=GTK_THEME=KDE-Indigo org.mozilla.firefox
```

## Aplicaciones Snap

Similar a Flatpak, pueden necesitar permisos adicionales:

```bash
# Conectar el plug de temas GTK
sudo snap connect nombre-de-la-app:gtk-3-themes :gtk-common-themes
```

## Kvantum - Configuración Avanzada

Si quieres personalizar más el tema Kvantum:

1. Abre Kvantum Manager
2. Selecciona "KDEIndigo"
3. Click en "Configure Active Theme"
4. Ajusta opacidad, sombras, animaciones, etc.

### Configuraciones recomendadas

- **Translucent windows**: Activado (para transparencias)
- **Blurring**: Activado (si tu compositor lo soporta)
- **Reduce window opacity**: 0-10% para paneles semi-transparentes
- **Animate states**: Activado para transiciones suaves

## Aplicar tema a todo el sistema

Para asegurar consistencia total:

```bash
# Exportar variables de entorno (añadir a ~/.bashrc o ~/.zshrc)
export QT_QPA_PLATFORMTHEME=kvantum
export GTK_THEME=KDE-Indigo
```

Luego cierra sesión y vuelve a entrar.

## Troubleshooting

### Firefox/LibreOffice se ven raros

- Verifica que el tema GTK esté en `~/.themes/KDE-Indigo/`
- Aplica el tema en Configuración → Apariencia → GTK
- Cierra completamente la app y ábrela de nuevo

### Las apps Qt no usan Kvantum

- Verifica instalación: `kvantummanager --version`
- Establece: `export QT_STYLE_OVERRIDE=kvantum`
- Reinicia las apps

### Colores inconsistentes

- Asegúrate de haber aplicado:
  1. Esquema de colores de KDE
  2. Tema de Plasma
  3. Tema GTK
  4. Tema Kvantum
- Cierra sesión y vuelve a entrar

### Flatpak/Snap no toman el tema

- Sigue las instrucciones específicas de Flatpak/Snap arriba
- Algunas apps empaquetadas tienen limitaciones

---

**Nota**: No todas las aplicaciones respetan completamente los temas del sistema. Algunas (como Spotify, Discord nativo) requieren temas/modificaciones específicas de la app.
