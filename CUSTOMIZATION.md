# Guía de Personalización Avanzada

## Ajustando Colores Específicos

### Cambiar el Color de Acento Principal

El color de acento principal (índigo `#673AB7`) aparece en:
- Botones enfocados
- Enlaces
- Barras de progreso
- Elementos seleccionados

Para cambiarlo, busca `DecorationFocus` en `CachyOSIndigo.colors` y reemplaza:
```ini
DecorationFocus=103,58,183
```

Por tu color favorito (en RGB). Ejemplos:

**Violeta Intenso**: `138,43,226` (BlueViolet)
**Índigo Suave**: `100,100,200` (Indigo suave)
**Morado Royal**: `120,81,169` (Morado medio)

### Cambiar el Color Hover

Para el color que aparece cuando pasas el mouse, modifica `DecorationHover`:

```ini
DecorationHover=156,39,176  # Purple actual
```

Debe ser un tono complementario a tu color principal.

### Ajustar Transparencia y Contraste

En el archivo `metadata.desktop`:

```ini
[ContrastEffect]
contrast=7          # Aumenta para más definición (1-10)
enabled=true
intensity=2         # Aumenta para colores más vibrantes (1-3)
saturation=1.7      # Controla saturación (0.5-2.0)
```

## Creando Variantes del Tema

### Variante Clara (Light)

1. Copia `CachyOSIndigo.colors` a `CachyOSIndigoLight.colors`
2. Modifica los fondos:

```ini
[Colors:Window]
BackgroundNormal=245,245,250     # Gris muy claro
BackgroundAlternate=235,235,242  # Gris ligeramente más oscuro

[Colors:View]
BackgroundNormal=250,250,255     # Casi blanco
BackgroundAlternate=245,245,250
```

3. Modifica los textos:

```ini
ForegroundNormal=30,30,46        # Texto oscuro
ForegroundInactive=100,100,120   # Texto gris
```

### Variante Neón/Cyberpunk

Aumenta la saturación e intensidad:

```ini
DecorationFocus=138,43,226       # Violeta brillante
DecorationHover=255,0,255        # Magenta neón

[General]
saturation=2.0                   # Máxima saturación
```

### Variante Pastel

Suaviza los colores:

```ini
DecorationFocus=150,120,200      # Lavanda
DecorationHover=180,140,210      # Lila claro
saturation=0.8                   # Baja saturación
```

## Personalizando Elementos Específicos

### Barras de Título de Ventanas

Edita la sección `[WM]` (Window Manager):

```ini
[WM]
activeBackground=24,24,37        # Color de barra activa
activeForeground=205,214,244     # Texto de barra activa
inactiveBackground=30,30,46      # Color de barra inactiva
inactiveForeground=161,169,177   # Texto de barra inactiva
```

### Botones y Controles

En `[Colors:Button]`:

```ini
BackgroundNormal=30,30,46        # Color de botón normal
BackgroundAlternate=103,58,183   # Color de botón alternativo/hover
ForegroundNormal=205,214,244     # Texto del botón
```

### Áreas de Selección

En `[Colors:Selection]`:

```ini
BackgroundNormal=103,58,183      # Fondo del texto seleccionado
ForegroundNormal=252,252,252     # Color del texto seleccionado
```

## Efectos Visuales

### Sombras y Bordes

Crea/edita `plasma/desktoptheme/CachyOS-Indigo-round/widgets/panel-background.svgz`:

Para aumentar sombras, ajusta el archivo SVG con inkscape:
```bash
inkscape plasma/desktoptheme/CachyOS-Indigo-round/widgets/panel-background.svgz
```

### Redondez de Esquinas

La redondez viene determinada por los archivos SVG. Para esquinas más/menos redondeadas:

1. Extrae los SVG del tema
2. Edítalos con Inkscape
3. Ajusta el radio de las esquinas
4. Vuelve a comprimir en `.svgz`

## Integración con Aplicaciones

### Firefox

Crea un tema de Firefox que coincida:

1. Instala Firefox Color
2. Usa estos colores:
   - **Toolbar**: `#1E1E2E`
   - **Toolbar Text**: `#CDD6F4`
   - **Acento**: `#673AB7`
   - **Tab seleccionada**: `#313244`

### VS Code / VSCodium

Instala el tema "One Dark Pro" y personaliza:

```json
{
  "workbench.colorCustomizations": {
    "activityBar.background": "#1E1E2E",
    "editor.background": "#181825",
    "sideBar.background": "#1E1E2E",
    "statusBar.background": "#673AB7",
    "titleBar.activeBackground": "#1E1E2E"
  }
}
```

### Discord (BetterDiscord)

Usa un tema base oscuro y sobrescribe:

```css
:root {
  --background-primary: #181825;
  --background-secondary: #1E1E2E;
  --background-accent: #673AB7;
  --text-normal: #CDD6F4;
}
```

## Creando Temas Derivados

### Tema "Sunset Indigo"

Añade tonos naranjas y rosas:

```ini
DecorationFocus=156,39,176       # Magenta
DecorationHover=255,87,51        # Coral
ForegroundLink=255,121,198       # Rosa
```

### Tema "Ocean Indigo"

Mezcla con tonos azules:

```ini
DecorationFocus=63,81,181        # Azul índigo
DecorationHover=33,150,243       # Azul material
BackgroundNormal=18,24,37        # Azul oscuro
```

### Tema "Forest Indigo"

Añade verdes suaves:

```ini
ForegroundPositive=102,187,106   # Verde más saturado
DecorationHover=104,159,56       # Verde oliva
```

## Testing y Debug

### Previsualizar Cambios Rápidamente

1. Edita el archivo `.colors`
2. Ejecuta:
```bash
kquitapp5 plasmashell
kstart5 plasmashell
```

3. Verifica los cambios

### Herramientas Útiles

```bash
# Ver tema actual
kreadconfig5 --group "General" --key "ColorScheme"

# Aplicar tema desde terminal
plasma-apply-colorscheme CachyOSIndigo

# Recargar configuración
qdbus org.kde.KWin /KWin reconfigure
```

### Backup

Antes de modificar:
```bash
cp -r ~/.local/share/plasma/desktoptheme/CachyOS-Indigo-round \
      ~/.local/share/plasma/desktoptheme/CachyOS-Indigo-round.backup
```

## Tips Finales

1. **Menos es más**: No uses demasiados colores de acento
2. **Prueba en diferentes iluminaciones**: Tu monitor puede engañarte
3. **Pide opiniones**: Lo que se ve bien para ti puede no serlo para otros
4. **Documenta tus cambios**: Anota qué modificaste y por qué
5. **Versiona tu tema**: Usa git para trackear cambios

## Recursos Adicionales

- [KDE Store](https://store.kde.org) - Inspira con otros temas
- [Material Design](https://material.io/design/color) - Guías de color
- [Adobe Color](https://color.adobe.com) - Generador de paletas
- [Contrast Checker](https://webaim.org/resources/contrastchecker/) - Verifica accesibilidad
