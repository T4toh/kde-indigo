# CachyOS Indigo KDE Theme

Un tema índigo/violeta para KDE Plasma basado en el tema CachyOS Emerald original.

## Paleta de Colores

Este tema utiliza una paleta de colores índigo/violeta oscura:

- **Color principal (Indigo)**: `#673AB7` (RGB: 103, 58, 183)
- **Color secundario (Purple)**: `#9C27B0` (RGB: 156, 39, 176)
- **Fondo oscuro**: `#181825` (RGB: 24, 24, 37)
- **Fondo alternativo**: `#1E1E2E` (RGB: 30, 30, 46)
- **Texto principal**: `#CDD6F4` (RGB: 205, 214, 244)
- **Texto inactivo**: `#A1A9B1` (RGB: 161, 169, 177)

## Estructura del Tema

```
CachyOS-Indigo/
├── color-schemes/
│   └── CachyOSIndigo.colors          # Esquema de colores para aplicaciones
└── plasma/
    └── desktoptheme/
        └── CachyOS-Indigo-round/
            ├── metadata.desktop      # Metadatos del tema
            ├── colors                # Colores del tema Plasma
            └── dialogs/
                └── background.svgz   # Configuración de diálogos
```

## Instalación

### Método 1: Instalación manual (recomendado)

1. **Instalar el esquema de colores:**
   ```bash
   mkdir -p ~/.local/share/color-schemes
   cp color-schemes/CachyOSIndigo.colors ~/.local/share/color-schemes/
   ```

2. **Instalar el tema de Plasma:**
   ```bash
   mkdir -p ~/.local/share/plasma/desktoptheme
   cp -r plasma/desktoptheme/CachyOS-Indigo-round ~/.local/share/plasma/desktoptheme/
   ```

3. **Aplicar el tema:**
   - Abre Configuración del Sistema
   - Ve a **Apariencia** → **Colores**
   - Selecciona "CachyOS Indigo"
   - Ve a **Apariencia** → **Tema de Plasma**
   - Selecciona "CachyOS Indigo Round"

### Método 2: Instalación a nivel de sistema

Si deseas que el tema esté disponible para todos los usuarios:

```bash
sudo mkdir -p /usr/share/color-schemes
sudo cp color-schemes/CachyOSIndigo.colors /usr/share/color-schemes/

sudo mkdir -p /usr/share/plasma/desktoptheme
sudo cp -r plasma/desktoptheme/CachyOS-Indigo-round /usr/share/plasma/desktoptheme/
```

## Personalización

### Cambiar tonalidades

Si deseas ajustar los colores, edita el archivo `color-schemes/CachyOSIndigo.colors`:

- **DecorationFocus**: Color de acento principal (actualmente índigo `103,58,183`)
- **DecorationHover**: Color al pasar el mouse (actualmente púrpura `156,39,176`)
- **BackgroundNormal**: Color de fondo principal
- **ForegroundNormal**: Color del texto principal

### Variantes de color sugeridas

Para un tono más violeta:
- DecorationFocus: `138,43,226` (BlueViolet)
- DecorationHover: `147,51,234` (Violet claro)

Para un tono más azul:
- DecorationFocus: `63,81,181` (Indigo material)
- DecorationHover: `92,107,192` (Indigo claro)

## Componentes del tema

Este tema incluye:

- ✅ Esquema de colores para aplicaciones Qt/KDE
- ✅ Tema de escritorio Plasma
- ✅ Colores para diálogos y ventanas
- ✅ Efectos de contraste y transparencia

## Componentes adicionales recomendados

Para completar el look, considera instalar:

- **Iconos**: Papirus-Dark o Tela (con variante violeta)
- **Cursor**: Breeze Snow Purple o Bibata Modern Ice
- **Tipografía**: Noto Sans o Inter
- **Decoración de ventanas**: Breeze o Klassy

## Desinstalación

Para eliminar el tema:

```bash
rm ~/.local/share/color-schemes/CachyOSIndigo.colors
rm -rf ~/.local/share/plasma/desktoptheme/CachyOS-Indigo-round
```

## Créditos

- Tema original: [CachyOS Emerald KDE](https://github.com/CachyOS/CachyOS-Emerald-KDE)
- Modificado a: Versión Índigo/Violeta
- Licencia: GPLv3

## Soporte

Para reportar problemas o sugerencias:
- Abre un issue en el repositorio
- Contacta al equipo de CachyOS

---

**Nota**: Este tema está optimizado para Plasma 5.27+ y puede requerir ajustes en versiones anteriores.
