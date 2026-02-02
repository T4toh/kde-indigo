# KDE Indigo KDE Theme

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
KDE-Indigo/
├── color-schemes/
│   └── KDEIndigo.colors          # Esquema de colores para aplicaciones
├── plasma/
│   └── desktoptheme/
│       └── KDE-Indigo-round/
│           ├── metadata.desktop      # Metadatos del tema
│           ├── colors                # Colores del tema Plasma
│           └── dialogs/
│               └── background.svgz   # Configuración de diálogos
├── gtk-2.0/
│   └── gtkrc                         # Tema GTK2 (apps antiguas)
├── gtk-3.0/
│   └── gtk.css                       # Tema GTK3 (Firefox, LibreOffice, etc.)
└── Kvantum/
    └── KDEIndigo/
        ├── KDEIndigo.kvconfig    # Configuración Kvantum
        └── KDEIndigo.svg         # Elementos gráficos
```

## Instalación

### Método 1: Script automático (Recomendado) ⚡

El script de instalación se encarga de todo automáticamente:

```bash
./install.sh
```

El script:
- ✅ Instala todos los componentes del tema
- ✅ Configura automáticamente aplicaciones GTK (Firefox, LibreOffice, etc.)
- ✅ Aplica el esquema de colores de KDE
- ✅ Aplica el tema Plasma
- ✅ Configura Kvantum (si está instalado)
- ✅ Añade variables de entorno necesarias

**¡Todo listo en un solo comando!** Solo necesitas reiniciar las aplicaciones para ver los cambios.

### Método 2: Instalación manual

Si prefieres hacerlo manualmente:

1. **Instalar componentes:**

   ```bash
   # Esquema de colores
   mkdir -p ~/.local/share/color-schemes
   cp color-schemes/KDEIndigo.colors ~/.local/share/color-schemes/
   
   # Tema Plasma
   mkdir -p ~/.local/share/plasma/desktoptheme
   cp -r plasma/desktoptheme/KDE-Indigo-round ~/.local/share/plasma/desktoptheme/
   
   # Temas GTK (Firefox, LibreOffice, etc.)
   mkdir -p ~/.themes/KDE-Indigo
   cp -r gtk-2.0 gtk-3.0 ~/.themes/KDE-Indigo/
   
   # Kvantum (opcional)
   mkdir -p ~/.config/Kvantum
   cp -r Kvantum/KDEIndigo ~/.config/Kvantum/
   ```

2. **Aplicar configuraciones:**

   ```bash
   # Configurar GTK
   mkdir -p ~/.config/gtk-3.0
   echo "[Settings]" > ~/.config/gtk-3.0/settings.ini
   echo "gtk-theme-name=KDE-Indigo" >> ~/.config/gtk-3.0/settings.ini
   
   # Variables de entorno (añadir a ~/.bashrc o ~/.zshrc)
   echo "export GTK_THEME=KDE-Indigo" >> ~/.bashrc
   echo "export QT_QPA_PLATFORMTHEME=kvantum" >> ~/.bashrc
   ```

3. **Aplicar temas en Configuración del Sistema:**
   - **Apariencia** → **Colores** → "KDE Indigo"
   - **Apariencia** → **Tema de Plasma** → "KDE Indigo Round"
   - **Apariencia** → **Estilo de aplicación** → Configurar GTK → "KDE-Indigo"

### Instalación a nivel de sistema

Para hacer el tema disponible para todos los usuarios, usa el script con opción 2 o:

```bash
sudo ./install.sh
# Y selecciona la opción 2 cuando se te pregunte
```

## Personalización

### Cambiar tonalidades

Si deseas ajustar los colores, edita el archivo `color-schemes/KDEIndigo.colors`:

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
- ✅ **Tema GTK2/GTK3** para Firefox, LibreOffice, GIMP, etc.
- ✅ **Tema Kvantum** para mejor integración Qt

### ¿Por qué GTK y Kvantum?

- **GTK**: Firefox, LibreOffice, GIMP y muchas apps usan GTK en lugar de Qt. Sin el tema GTK, estas apps se verán con colores genéricos que no coinciden con tu escritorio.
- **Kvantum**: Motor de temas avanzado para Qt que permite mayor personalización y efectos visuales mejorados.

## Componentes adicionales recomendados

Para completar el look, considera instalar:

- **Iconos**: Papirus-Dark o Tela (con variante violeta)
- **Cursor**: Breeze Snow Purple o Bibata Modern Ice
- **Tipografía**: Noto Sans o Inter
- **Decoración de ventanas**: Breeze o Klassy

## Desinstalación

Para eliminar el tema, usa el script de desinstalación:

```bash
./uninstall.sh
```

O manualmente:

```bash
rm ~/.local/share/color-schemes/KDEIndigo.colors
rm -rf ~/.local/share/plasma/desktoptheme/KDE-Indigo-round
rm -rf ~/.themes/KDE-Indigo
rm -rf ~/.config/Kvantum/KDEIndigo
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
