# Estructura del Proyecto KDE Indigo

```
KDE-Indigo/
│
├── README.md                    # Documentación principal e instrucciones
├── CHANGELOG.md                 # Historial de cambios
├── COLORS.md                    # Referencia de paleta de colores
├── CUSTOMIZATION.md             # Guía de personalización avanzada
├── LICENSE                      # Licencia GPLv3
│
├── install.sh                   # Script de instalación automática
├── uninstall.sh                 # Script de desinstalación
│
├── color-schemes/               # Esquemas de color para aplicaciones
│   └── KDEIndigo.colors    # Archivo de colores principal
│
└── plasma/                      # Tema de Plasma Desktop
    └── desktoptheme/
        └── KDE-Indigo-round/
            ├── metadata.desktop # Metadatos del tema
            ├── colors          # Definición de colores del tema
            └── dialogs/
                └── background.svgz  # Configuración de diálogos
```

## Archivos Principales

### Documentación

- **README.md**: Instrucciones de instalación y uso
- **COLORS.md**: Paleta completa con códigos RGB/HEX
- **CUSTOMIZATION.md**: Guía para personalizar el tema
- **CHANGELOG.md**: Historial de versiones

### Instalación

- **install.sh**: Instala automáticamente el tema
- **uninstall.sh**: Desinstala el tema completamente

### Tema

- **color-schemes/**: Esquemas de color para apps Qt/KDE
- **plasma/**: Archivos del tema de escritorio Plasma

## Tamaño Total

Aproximadamente 30-40 KB (muy ligero)

## Archivos Requeridos para Funcionamiento Básico

1. `color-schemes/KDEIndigo.colors`
2. `plasma/desktoptheme/KDE-Indigo-round/metadata.desktop`
3. `plasma/desktoptheme/KDE-Indigo-round/colors`

## Próximas Adiciones Planeadas

- Widgets personalizados
- Efectos de transparencia
- Variante clara
- Temas complementarios (SDDM, GRUB)
