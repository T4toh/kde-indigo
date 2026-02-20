#!/bin/bash

# Script de instalación para KDE Indigo KDE Theme
# Versión: 2.0 (Plasma 6 Support)

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
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

warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Función de limpieza profunda
clean_previous_installations() {
    info "Limpiando instalaciones previas y caché..."
    
    # Limpiar caché de Plasma (Crucial para que se apliquen cambios de SVGs)
    rm -rf ~/.cache/plasma* ~/.cache/icon-cache.kcache 2>/dev/null
    rm -rf ~/.cache/ksycoca* ~/.cache/kioexec* 2>/dev/null
    success "Caché de Plasma limpiado"
    
    # Eliminar instalaciones previas del usuario
    if [ -f "$HOME/.local/share/color-schemes/KDEIndigo.colors" ]; then
        rm -f "$HOME/.local/share/color-schemes/KDEIndigo.colors"
    fi
    
    if [ -d "$HOME/.local/share/plasma/desktoptheme/KDE-Indigo-round" ]; then
        rm -rf "$HOME/.local/share/plasma/desktoptheme/KDE-Indigo-round"
    fi

    if [ -d "$HOME/.local/share/plasma/lookandfeel/com.github.t4toh.kde-indigo-round" ]; then
        rm -rf "$HOME/.local/share/plasma/lookandfeel/com.github.t4toh.kde-indigo-round"
    fi
    
    success "Limpieza completada"
    echo ""
}

# Verificar que estamos en el directorio correcto
if [ ! -d "color-schemes" ] || [ ! -d "plasma" ]; then
    error "Error: No se encuentran los directorios del tema."
    error "Asegúrate de ejecutar este script desde el directorio raíz del tema."
    exit 1
fi

# Limpiar instalaciones previas
clean_previous_installations

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
        LOOKANDFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
        GTK2_DIR="$HOME/.themes/KDE-Indigo/gtk-2.0"
        GTK3_DIR="$HOME/.themes/KDE-Indigo/gtk-3.0"
        KVANTUM_DIR="$HOME/.config/Kvantum"
        USE_SUDO=""
        ;;
    2)
        info "Instalando para todo el sistema..."
        COLOR_DIR="/usr/share/color-schemes"
        PLASMA_DIR="/usr/share/plasma/desktoptheme"
        LOOKANDFEEL_DIR="/usr/share/plasma/look-and-feel"
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
$USE_SUDO mkdir -p "$LOOKANDFEEL_DIR"
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

# Instalar Global Theme (Look and Feel)
if [ -d "plasma/lookandfeel" ]; then
    info "Instalando Global Theme (Look and Feel)..."
    $USE_SUDO mkdir -p "$LOOKANDFEEL_DIR"
    $USE_SUDO cp -r plasma/lookandfeel/com.github.t4toh.kde-indigo-round "$LOOKANDFEEL_DIR/"
    success "Global Theme instalado"
fi

# Instalar temas GTK
if [ -d "gtk-2.0" ] && [ -d "gtk-3.0" ]; then
    info "Instalando temas GTK para Firefox, LibreOffice, etc..."
    if [ "$install_type" = "1" ]; then
        mkdir -p "$HOME/.themes/KDE-Indigo"
        cp -r gtk-2.0 "$HOME/.themes/KDE-Indigo/"
        cp -r gtk-3.0 "$HOME/.themes/KDE-Indigo/"
    else
        $USE_SUDO mkdir -p "/usr/share/themes/KDE-Indigo"
        $USE_SUDO cp -r gtk-2.0 "/usr/share/themes/KDE-Indigo/"
        $USE_SUDO cp -r gtk-3.0 "/usr/share/themes/KDE-Indigo/"
    fi
    success "Temas GTK instalados"
fi

# Instalar tema Kvantum
if [ -d "Kvantum" ]; then
    info "Instalando tema Kvantum..."
    $USE_SUDO mkdir -p "$KVANTUM_DIR"
    $USE_SUDO cp -r Kvantum/KDEIndigo "$KVANTUM_DIR/"
    success "Tema Kvantum instalado"
fi

# Aplicar configuraciones automáticamente (solo para usuario)
if [ "$install_type" = "1" ]; then
    echo ""
    read -p "¿Deseas aplicar el tema completo automáticamente ahora? [s/N]: " auto_apply
    
    if [[ $auto_apply =~ ^[SsYy]$ ]]; then
        info "Aplicando configuraciones automáticas..."
        
        # Aplicar Global Theme (Esto sincroniza todo lo demás)
        if command -v plasma-apply-lookandfeel &> /dev/null; then
            plasma-apply-lookandfeel -a com.github.t4toh.kde-indigo-round && success "Estilo Global aplicado" || info "Aplica el Estilo Global manualmente"
        else
            # Fallback a partes individuales si no hay comando global
            if command -v plasma-apply-colorscheme &> /dev/null; then
                plasma-apply-colorscheme KDEIndigo 2>/dev/null && success "Esquema de colores aplicado"
            fi
            if command -v plasma-apply-desktoptheme &> /dev/null; then
                plasma-apply-desktoptheme KDE-Indigo-round 2>/dev/null && success "Tema Plasma aplicado"
            fi
        fi
        
        # Aplicar tema Kvantum
        if [ "$HAS_KVANTUM" = true ]; then
            kvantummanager --set KDEIndigo 2>/dev/null && success "Tema Kvantum aplicado"
        fi
    fi
fi

echo ""
echo -e "${PURPLE}╔══════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║          ¡Instalación completa!          ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════╝${NC}"
echo ""
info "Para que los cambios se reflejen en la pantalla de bloqueo:"
echo "  1. Ve a Configuración → Apariencia → Estilo Global"
echo "  2. Asegúrate de tener seleccionado 'KDE Indigo Round'"
echo "  3. Ve a Pantalla de inicio de sesión (SDDM) → Pulsa 'Aplicar configuración de Plasma'"
echo ""
success "¡Disfruta tu nuevo tema KDE Indigo!"

exit 0
