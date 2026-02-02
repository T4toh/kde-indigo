#!/bin/bash

# Script de instalación para KDE Indigo KDE Theme
# Versión: 1.0

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${PURPLE}"
echo "╔══════════════════════════════════════════╗"
echo "║   KDE Indigo KDE Theme Installer    ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Función para mostrar mensajes
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Verificar que estamos en el directorio correcto
if [ ! -d "color-schemes" ] || [ ! -d "plasma" ]; then
    error "Error: No se encuentran los directorios del tema."
    error "Asegúrate de ejecutar este script desde el directorio raíz del tema."
    exit 1
fi

# Verificar dependencias opcionales
info "Verificando dependencias opcionales..."
HAS_KVANTUM=false
if command -v kvantummanager &> /dev/null; then
    HAS_KVANTUM=true
    success "Kvantum detectado"
else
    info "Kvantum no instalado (opcional, mejora la apariencia de apps Qt)"
fi

# Preguntar tipo de instalación
echo ""
echo "Selecciona el tipo de instalación:"
echo "  1) Usuario actual (solo para ti) - Recomendado"
echo "  2) Sistema completo (para todos los usuarios) - Requiere sudo"
echo ""
read -p "Opción [1-2]: " install_type

case $install_type in
    1)
        info "Instalando para usuario actual..."
        COLOR_DIR="$HOME/.local/share/color-schemes"
        PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
        GTK2_DIR="$HOME/.themes/KDE-Indigo/gtk-2.0"
        GTK3_DIR="$HOME/.themes/KDE-Indigo/gtk-3.0"
        KVANTUM_DIR="$HOME/.config/Kvantum"
        USE_SUDO=""
        ;;
    2)
        info "Instalando para todo el sistema..."
        COLOR_DIR="/usr/share/color-schemes"
        PLASMA_DIR="/usr/share/plasma/desktoptheme"
        GTK2_DIR="/usr/share/themes/KDE-Indigo/gtk-2.0"
        GTK3_DIR="/usr/share/themes/KDE-Indigo/gtk-3.0"
        KVANTUM_DIR="/usr/share/Kvantum"
        USE_SUDO="sudo"
        
        # Verificar si tenemos permisos de sudo
        if ! sudo -v; then
            error "Se requieren permisos de sudo para instalación a nivel de sistema."
            exit 1
        fi
        ;;
    *)
        error "Opción inválida. Saliendo."
        exit 1
        ;;
esac

# Crear directorios si no existen
info "Creando directorios necesarios..."
$USE_SUDO mkdir -p "$COLOR_DIR"
$USE_SUDO mkdir -p "$PLASMA_DIR"
$USE_SUDO mkdir -p "$(dirname "$GTK2_DIR")"
$USE_SUDO mkdir -p "$(dirname "$GTK3_DIR")"
success "Directorios creados"

# Instalar esquema de colores
info "Instalando esquema de colores..."
$USE_SUDO cp color-schemes/KDEIndigo.colors "$COLOR_DIR/"
success "Esquema de colores instalado"

# Instalar tema de Plasma
info "Instalando tema de Plasma..."
$USE_SUDO cp -r plasma/desktoptheme/KDE-Indigo-round "$PLASMA_DIR/"
success "Tema de Plasma instalado"

# Instalar temas GTK
if [ -d "gtk-2.0" ] && [ -d "gtk-3.0" ]; then
    info "Instalando temas GTK para Firefox, LibreOffice, etc..."
    if [ "$install_type" = "1" ]; then
        # Instalación para usuario: copiar a ~/.themes/KDE-Indigo/
        mkdir -p "$HOME/.themes/KDE-Indigo"
        cp -r gtk-2.0 "$HOME/.themes/KDE-Indigo/"
        cp -r gtk-3.0 "$HOME/.themes/KDE-Indigo/"
    else
        # Instalación sistema: copiar a /usr/share/themes/
        $USE_SUDO mkdir -p "/usr/share/themes/KDE-Indigo"
        $USE_SUDO cp -r gtk-2.0 "/usr/share/themes/KDE-Indigo/"
        $USE_SUDO cp -r gtk-3.0 "/usr/share/themes/KDE-Indigo/"
    fi
    success "Temas GTK instalados"
else
    info "Temas GTK no encontrados (opcional)"
fi

# Instalar tema Kvantum
if [ "$HAS_KVANTUM" = true ] && [ -d "Kvantum" ]; then
    info "Instalando tema Kvantum..."
    $USE_SUDO mkdir -p "$KVANTUM_DIR"
    $USE_SUDO cp -r Kvantum/KDEIndigo "$KVANTUM_DIR/"
    success "Tema Kvantum instalado"
elif [ -d "Kvantum" ]; then
    info "Copiando tema Kvantum (instala Kvantum para usarlo)..."
    $USE_SUDO mkdir -p "$KVANTUM_DIR"
    $USE_SUDO cp -r Kvantum/KDEIndigo "$KVANTUM_DIR/"
    success "Tema Kvantum copiado"
fi

# Aplicar configuraciones automáticamente (solo para usuario)
if [ "$install_type" = "1" ]; then
    info "Aplicando configuraciones automáticas..."
    
    # Configurar tema GTK
    if command -v kwriteconfig5 &> /dev/null; then
        kwriteconfig5 --file ~/.config/gtk-3.0/settings.ini --group Settings --key gtk-theme-name "KDE-Indigo"
        kwriteconfig5 --file ~/.config/gtk-4.0/settings.ini --group Settings --key gtk-theme-name "KDE-Indigo"
        
        # También configurarlo en KDE para que las apps GTK lo usen
        kwriteconfig5 --file kdeglobals --group General --key widgetStyle "Breeze"
        
        # Crear/actualizar archivo de configuración GTK
        mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
        echo "[Settings]" > ~/.config/gtk-3.0/settings.ini
        echo "gtk-theme-name=KDE-Indigo" >> ~/.config/gtk-3.0/settings.ini
        echo "gtk-application-prefer-dark-theme=true" >> ~/.config/gtk-3.0/settings.ini
        
        echo "[Settings]" > ~/.config/gtk-4.0/settings.ini
        echo "gtk-theme-name=KDE-Indigo" >> ~/.config/gtk-4.0/settings.ini
        echo "gtk-application-prefer-dark-theme=true" >> ~/.config/gtk-4.0/settings.ini
        
        success "Tema GTK configurado automáticamente"
    fi
    
    # Aplicar esquema de colores KDE
    if command -v plasma-apply-colorscheme &> /dev/null; then
        plasma-apply-colorscheme KDEIndigo 2>/dev/null && success "Esquema de colores aplicado" || info "Aplica el esquema manualmente"
    fi
    
    # Aplicar tema de Plasma
    if command -v plasma-apply-desktoptheme &> /dev/null; then
        plasma-apply-desktoptheme KDE-Indigo-round 2>/dev/null && success "Tema Plasma aplicado" || info "Aplica el tema Plasma manualmente"
    fi
    
    # Aplicar tema Kvantum
    if [ "$HAS_KVANTUM" = true ]; then
        kvantummanager --set KDEIndigo 2>/dev/null && success "Tema Kvantum aplicado" || info "Abre Kvantum Manager para aplicar el tema"
    fi
    
    # Exportar variables de entorno
    info "Configurando variables de entorno..."
    SHELL_RC=""
    if [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        SHELL_RC="$HOME/.bashrc"
    fi
    
    if [ -n "$SHELL_RC" ]; then
        if ! grep -q "GTK_THEME=KDE-Indigo" "$SHELL_RC"; then
            echo "" >> "$SHELL_RC"
            echo "# KDE Indigo Theme" >> "$SHELL_RC"
            echo "export GTK_THEME=KDE-Indigo" >> "$SHELL_RC"
            echo "export QT_QPA_PLATFORMTHEME=kvantum" >> "$SHELL_RC"
            success "Variables de entorno añadidas a $SHELL_RC"
        else
            info "Variables de entorno ya configuradas"
        fi
    fi
fi

# Finalización
echo ""
echo -e "${PURPLE}╔══════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║          ¡Instalación completa!          ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════╝${NC}"
echo ""

if [ "$install_type" = "1" ]; then
    success "Tema aplicado automáticamente"
    echo ""
    info "Si algunos cambios no se ven, puedes:"
    echo "  • Cerrar y reabrir las aplicaciones (Firefox, LibreOffice, etc.)"
    echo "  • Cerrar sesión y volver a entrar para aplicar todo completamente"
else
    info "Para aplicar el tema completo:"
    echo ""
    echo "  1. KDE Plasma y aplicaciones Qt:"
    echo "     • Configuración → Apariencia → Colores → 'KDE Indigo'"
    echo "     • Configuración → Apariencia → Tema de Plasma → 'KDE Indigo Round'"
    echo ""
    echo "  2. Aplicaciones GTK (Firefox, LibreOffice, GIMP, etc.):"
    echo "     • Configuración → Apariencia → Estilo de aplicación"
    echo "     • Click en 'Configurar estilo de aplicaciones GNOME/GTK'"
    echo "     • Selecciona 'KDE-Indigo' en tema GTK"
    echo ""
    if [ "$HAS_KVANTUM" = true ]; then
        echo "  3. Tema Kvantum (mejora apps Qt):"
        echo "     • Abre Kvantum Manager"
        echo "     • Selecciona 'KDEIndigo'"
        echo "     • Click en 'Use this theme'"
        echo ""
    fi
    info "Puede que necesites cerrar sesión y volver a entrar para ver todos los cambios."
fi
echo ""

# Preguntar si desea abrir la configuración
if [ "$install_type" = "2" ]; then
    read -p "¿Deseas abrir la Configuración del Sistema ahora? [s/N]: " open_settings
    
    if [[ $open_settings =~ ^[SsYy]$ ]]; then
        info "Abriendo Configuración del Sistema..."
        systemsettings5 &
        success "¡Disfruta tu nuevo tema!"
    else
        success "¡Tema instalado! Aplícalo cuando quieras."
    fi
else
    read -p "¿Deseas recargar el shell para aplicar las variables de entorno ahora? [s/N]: " reload_shell
    
    if [[ $reload_shell =~ ^[SsYy]$ ]]; then
        success "¡Tema aplicado! Reinicia tus aplicaciones para ver los cambios."
        info "Las variables de entorno se aplicarán en tu próxima sesión de terminal."
    else
        success "¡Disfruta tu nuevo tema! Reinicia las aplicaciones para ver cambios."
    fi
fi

exit 0
