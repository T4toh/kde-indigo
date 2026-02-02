#!/bin/bash

# Script de desinstalación para CachyOS Indigo KDE Theme
# Versión: 1.0

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${RED}"
echo "╔══════════════════════════════════════════╗"
echo "║   CachyOS Indigo Theme Uninstaller      ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Función para mostrar mensajes
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Confirmación
echo ""
warning "¡ADVERTENCIA! Esta acción eliminará el tema CachyOS Indigo."
echo ""
read -p "¿Estás seguro de que deseas continuar? [s/N]: " confirm

if [[ ! $confirm =~ ^[SsYy]$ ]]; then
    info "Operación cancelada."
    exit 0
fi

# Detectar instalaciones
echo ""
info "Buscando instalaciones del tema..."

USER_COLOR="$HOME/.local/share/color-schemes/CachyOSIndigo.colors"
USER_PLASMA="$HOME/.local/share/plasma/desktoptheme/CachyOS-Indigo-round"
SYSTEM_COLOR="/usr/share/color-schemes/CachyOSIndigo.colors"
SYSTEM_PLASMA="/usr/share/plasma/desktoptheme/CachyOS-Indigo-round"

found=0

# Verificar instalación de usuario
if [ -f "$USER_COLOR" ] || [ -d "$USER_PLASMA" ]; then
    info "Encontrada instalación de usuario"
    found=1
fi

# Verificar instalación de sistema
if [ -f "$SYSTEM_COLOR" ] || [ -d "$SYSTEM_PLASMA" ]; then
    info "Encontrada instalación de sistema"
    found=2
fi

if [ $found -eq 0 ]; then
    warning "No se encontraron instalaciones del tema."
    exit 0
fi

# Preguntar qué desinstalar
if [ $found -eq 1 ]; then
    remove_user=true
    remove_system=false
elif [ $found -eq 2 ]; then
    remove_user=false
    remove_system=true
    
    warning "La instalación de sistema requiere permisos de sudo."
    if ! sudo -v; then
        error "No se pudieron obtener permisos de sudo."
        exit 1
    fi
else
    echo ""
    echo "Se encontraron múltiples instalaciones. ¿Qué deseas eliminar?"
    echo "  1) Solo instalación de usuario"
    echo "  2) Solo instalación de sistema (requiere sudo)"
    echo "  3) Ambas instalaciones"
    echo ""
    read -p "Opción [1-3]: " remove_choice
    
    case $remove_choice in
        1)
            remove_user=true
            remove_system=false
            ;;
        2)
            remove_user=false
            remove_system=true
            
            if ! sudo -v; then
                error "No se pudieron obtener permisos de sudo."
                exit 1
            fi
            ;;
        3)
            remove_user=true
            remove_system=true
            
            if ! sudo -v; then
                error "No se pudieron obtener permisos de sudo."
                exit 1
            fi
            ;;
        *)
            error "Opción inválida. Saliendo."
            exit 1
            ;;
    esac
fi

# Desinstalar de usuario
if [ "$remove_user" = true ]; then
    info "Eliminando instalación de usuario..."
    
    if [ -f "$USER_COLOR" ]; then
        rm "$USER_COLOR"
        success "Esquema de colores de usuario eliminado"
    fi
    
    if [ -d "$USER_PLASMA" ]; then
        rm -rf "$USER_PLASMA"
        success "Tema de Plasma de usuario eliminado"
    fi
fi

# Desinstalar de sistema
if [ "$remove_system" = true ]; then
    info "Eliminando instalación de sistema..."
    
    if [ -f "$SYSTEM_COLOR" ]; then
        sudo rm "$SYSTEM_COLOR"
        success "Esquema de colores de sistema eliminado"
    fi
    
    if [ -d "$SYSTEM_PLASMA" ]; then
        sudo rm -rf "$SYSTEM_PLASMA"
        success "Tema de Plasma de sistema eliminado"
    fi
fi

# Finalización
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Desinstalación completada           ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""

warning "IMPORTANTE: Si tenías el tema activo, cámbialo antes de cerrar sesión:"
echo "  1. Abre Configuración del Sistema"
echo "  2. Ve a Apariencia → Colores"
echo "  3. Selecciona otro esquema de colores (ej: Breeze)"
echo "  4. Ve a Apariencia → Tema de Plasma"
echo "  5. Selecciona otro tema (ej: Breeze)"
echo ""

read -p "¿Deseas abrir la Configuración del Sistema ahora? [s/N]: " open_settings

if [[ $open_settings =~ ^[SsYy]$ ]]; then
    info "Abriendo Configuración del Sistema..."
    systemsettings5 &
fi

success "Desinstalación completa."
exit 0
