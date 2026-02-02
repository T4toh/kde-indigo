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

Este es un **tema completo de Plasma**, no solo un esquema de colores. Incluye múltiples componentes:

### Componentes incluidos

```
KDE-Indigo/
├── color-schemes/
│   └── KDEIndigo.colors              # Esquema de colores para aplicaciones Qt/KDE
├── plasma/desktoptheme/
│   └── KDE-Indigo-round/
│       ├── metadata.desktop          # Metadatos y configuración del tema
│       ├── colors                    # Definición de colores del tema Plasma
│       └── dialogs/
│           └── background.svgz       # Apariencia de diálogos y notificaciones
├── gtk-2.0/
│   └── gtkrc                         # Tema GTK2 (aplicaciones antiguas)
├── gtk-3.0/
│   └── gtk.css                       # Tema GTK3 (Firefox, LibreOffice, GIMP, etc.)
└── Kvantum/
    └── KDEIndigo/
        ├── KDEIndigo.kvconfig        # Configuración del motor Kvantum
        └── KDEIndigo.svg             # Elementos gráficos para apps Qt
```

### ¿Qué es cada componente?

| Componente | Qué controla | Dónde se aplica |
|------------|--------------|-----------------|
| **Color Scheme** | Colores de texto, fondos, botones | Aplicaciones KDE/Qt nativas |
| **Desktop Theme** | Panel, widgets, **notificaciones**, menús | Todo el entorno Plasma |
| **GTK Themes** | Apariencia completa de apps GTK | Firefox, LibreOffice, GIMP, Thunderbird |
| **Kvantum** | Estilo avanzado de controles Qt | Apps Qt no-nativas, Telegram |

### Diferencia con un "Plasma Style"

Un **Desktop Theme** (como KDE-Indigo) controla la apariencia visual del escritorio (panel, notificaciones, widgets), mientras que un **Plasma Style** o **Application Style** (como Breeze, Oxygen) controla el comportamiento y forma de los controles de las aplicaciones (botones, sliders, etc.).

Este tema incluye:
- ✅ Desktop Theme (notificaciones, panel, widgets)
- ✅ Color Scheme (colores de aplicaciones)
- ✅ GTK Themes (apps como Firefox)
- ✅ Kvantum Theme (mejor integración Qt)
- ❌ Application Style (usa Breeze por defecto)
- ❌ Window Decorations (usa Breeze por defecto)

## Personalización Avanzada

### Modificar padding de notificaciones

El padding de las notificaciones se controla en el archivo SVG:

**Archivo:** `plasma/desktoptheme/KDE-Indigo-round/dialogs/background.svgz`

1. **Descomprimir el SVG:**
   ```bash
   cd plasma/desktoptheme/KDE-Indigo-round/dialogs
   gunzip -c background.svgz > background.svg
   ```

2. **Editar los márgenes** (actualmente 16px):
   ```bash
   # Buscar elementos con id="hint-top-margin", "hint-bottom-margin", etc.
   # Cambiar los valores de width y height
   sed -i 's/height="16"/height="24"/g' background.svg  # Aumentar a 24px
   sed -i 's/width="16"/width="24"/g' background.svg
   ```

3. **Recomprimir:**
   ```bash
   gzip -c background.svg > background.svgz
   rm background.svg
   ```

4. **Aplicar cambios:**
   ```bash
   ./install.sh  # O copiar manualmente a ~/.local/share/plasma/desktoptheme/
   kquitapp5 plasmashell && kstart5 plasmashell  # Reiniciar Plasma
   ```

### Dónde modificar cada aspecto

| Aspecto | Archivo | Descripción |
|---------|---------|-------------|
| Colores de apps | `color-schemes/KDEIndigo.colors` | RGB de botones, fondos, texto |
| Colores del panel | `plasma/desktoptheme/.../colors` | Colores específicos de Plasma |
| Padding notificaciones | `plasma/desktoptheme/.../dialogs/background.svgz` | Márgenes internos de diálogos |
| Colores Firefox/LibreOffice | `gtk-3.0/gtk.css` | CSS para apps GTK |
| Temas GTK2 | `gtk-2.0/gtkrc` | Apps GTK antiguas |
| Estilo Qt avanzado | `Kvantum/KDEIndigo/KDEIndigo.kvconfig` | Animaciones, transparencias, sombras |



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
- ✅ Tema de escritorio Plasma (Desktop Theme)
- ✅ Colores para diálogos y **notificaciones con padding personalizado**
- ✅ Efectos de contraste y transparencia
- ✅ **Tema GTK2/GTK3** para Firefox, LibreOffice, GIMP, etc.
- ✅ **Tema Kvantum** para mejor integración Qt

### ¿Por qué GTK y Kvantum?

- **GTK**: Firefox, LibreOffice, GIMP y muchas apps usan GTK en lugar de Qt. Sin el tema GTK, estas apps se verán con colores genéricos que no coinciden con tu escritorio.
- **Kvantum**: Motor de temas avanzado para Qt que permite mayor personalización y efectos visuales mejorados.

### Nota sobre Application Style (Plasma Style)

Este tema **NO incluye** un Application Style personalizado (como Breeze, Oxygen, Kvantum). El Application Style controla la forma de los botones, sliders, checkboxes, etc.

**¿Qué usar como Application Style?**
- **Breeze** (recomendado) - Estilo nativo de KDE, ligero y funcional
- **Kvantum** - Si instalaste el tema Kvantum, puedes usarlo como Application Style para efectos avanzados

**Para configurar:**
1. Configuración → Apariencia → **Estilo de aplicación**
2. Selecciona "Breeze" o "Kvantum" (si lo tienes instalado)

Algunos temas (como Emerald) pueden tener problemas visuales si usas un Application Style que no coincide con su Desktop Theme, por eso a veces necesitas cambiar ambos para que se vea bien.



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

## Troubleshooting (Solución de Problemas)

### Los colores se quedan violetas al cambiar a otro tema

**Problema:** Después de instalar KDE-Indigo, al cambiar a otro tema algunos elementos siguen violetas.

**Causa:** Las configuraciones GTK en `~/.config/gtk-3.0/settings.ini` pueden estar forzando el tema.

**Solución:**
1. Ejecuta `./uninstall.sh` para limpiar todas las configuraciones
2. O edita manualmente:
   ```bash
   nano ~/.config/gtk-3.0/settings.ini
   # Cambia gtk-theme-name a otro tema o elimina la línea
   ```
3. Cierra sesión y vuelve a entrar

### Las notificaciones tienen poco padding

**Solución:** El tema ya incluye 16px de padding. Si quieres más:
1. Edita `plasma/desktoptheme/KDE-Indigo-round/dialogs/background.svgz` (ver sección "Personalización Avanzada")
2. Aumenta los valores de margin a 20px o 24px
3. Reinstala con `./install.sh`

### Firefox/LibreOffice no toman los colores

**Solución:**
1. Verifica que el tema GTK esté en `~/.themes/KDE-Indigo/`
2. Configuración → Apariencia → GTK → Selecciona "KDE-Indigo"
3. Cierra **completamente** la aplicación y ábrela de nuevo
4. Si no funciona: cierra sesión y vuelve a entrar

### Las notificaciones se ven mal con otro Application Style

**Problema:** Al usar un Application Style diferente (no Breeze), las notificaciones pueden verse raras.

**Causa:** El Desktop Theme está diseñado para funcionar con Breeze.

**Solución:**
- Usa **Breeze** como Application Style (Configuración → Estilo de aplicación)
- O usa **Kvantum** si tienes el tema Kvantum instalado

### Diferencia entre Desktop Theme y Application Style

| Componente | Qué controla | Ejemplo |
|------------|--------------|---------|
| **Desktop Theme** | Panel, widgets, notificaciones, fondos | KDE-Indigo-round |
| **Application Style** | Forma de botones, sliders, controles | Breeze, Oxygen, Kvantum |

Ambos son independientes. KDE-Indigo es un Desktop Theme que funciona mejor con Breeze o Kvantum como Application Style.

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
