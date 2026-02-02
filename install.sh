#!/bin/bash

# Script de instalación para CachyOS Indigo KDE Theme
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
echo "║   CachyOS Indigo KDE Theme Installer    ║"
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
        USE_SUDO=""
        ;;
    2)
        info "Instalando para todo el sistema..."
        COLOR_DIR="/usr/share/color-schemes"
        PLASMA_DIR="/usr/share/plasma/desktoptheme"
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
success "Directorios creados"

# Instalar esquema de colores
info "Instalando esquema de colores..."
$USE_SUDO cp color-schemes/CachyOSIndigo.colors "$COLOR_DIR/"
success "Esquema de colores instalado"

# Instalar tema de Plasma
info "Instalando tema de Plasma..."
$USE_SUDO cp -r plasma/desktoptheme/CachyOS-Indigo-round "$PLASMA_DIR/"
success "Tema de Plasma instalado"

# Finalización
echo ""
echo -e "${PURPLE}╔══════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║          ¡Instalación completa!          ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════╝${NC}"
echo ""
info "Para aplicar el tema:"
echo "  1. Abre Configuración del Sistema"
echo "  2. Ve a Apariencia → Colores"
echo "  3. Selecciona 'CachyOS Indigo'"
echo "  4. Ve a Apariencia → Tema de Plasma"
echo "  5. Selecciona 'CachyOS Indigo Round'"
echo ""
info "Puede que necesites cerrar sesión y volver a entrar para ver todos los cambios."
echo ""

# Preguntar si desea abrir la configuración
read -p "¿Deseas abrir la Configuración del Sistema ahora? [s/N]: " open_settings

if [[ $open_settings =~ ^[SsYy]$ ]]; then
    info "Abriendo Configuración del Sistema..."
    systemsettings5 &
    success "¡Disfruta tu nuevo tema!"
else
    success "¡Tema instalado! Aplícalo cuando quieras."
fi

exit 0
