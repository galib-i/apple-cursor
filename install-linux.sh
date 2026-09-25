#!/bin/sh

set -e

THEME_NAMES="macOS macOS-White"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_DIR="$SCRIPT_DIR/themes"

usage() {
    echo "Usage: $0 <install|uninstall> <local|global>"
    echo ""
    echo "Examples:"
    echo "  $0 install local     # Install to ~/.icons (no sudo)"
    echo "  $0 install global    # Install to /usr/share/icons (requires sudo)"
    echo "  $0 uninstall local   # Remove from local directories"
    echo "  $0 uninstall global  # Remove from system directories"
    exit 1
}

if [ "$#" -ne 2 ]; then
    usage
fi

ACTION="$1"
TARGET="$2"

case "$TARGET" in
    local)
        DEST_DIR="$HOME/.local/share/icons"
        ;;
    global)
        DEST_DIR="/usr/share/icons"
        ;;
    *)
        echo "Error: Target must be 'local' or 'global'."
        usage
        ;;
esac

_sudo() {
    if command -v sudo >/dev/null; then
        sudo "$@"
    elif command -v doas >/dev/null; then
        doas "$@"
    else
        echo "Failed to execute '$*'. Please run the script with root permissions." >&2
        exit 1
    fi
}

install_theme() {
    echo "Installing cursors ($TARGET)..."
    
    if [ ! -d "$THEME_DIR" ]; then
        echo "Error: 'themes' directory not found. Please run ./build.sh first."
        exit 1
    fi

    if [ "$TARGET" = "local" ]; then
        mkdir -p "$DEST_DIR"
        for THEME in $THEME_NAMES; do
            if [ -d "$THEME_DIR/$THEME" ]; then
                cp -r "$THEME_DIR/$THEME" "$DEST_DIR/"
                echo "Installed $THEME to $DEST_DIR/"
            fi
        done
    else
        _sudo mkdir -p "$DEST_DIR"
        for THEME in $THEME_NAMES; do
            if [ -d "$THEME_DIR/$THEME" ]; then
                _sudo cp -r "$THEME_DIR/$THEME" "$DEST_DIR/"
                echo "Installed $THEME to $DEST_DIR/"
            fi
        done
    fi
}

uninstall_theme() {
    echo "Removing cursors ($TARGET)..."

    for THEME in $THEME_NAMES; do
        if [ "$TARGET" = "local" ]; then
            if [ -d "$DEST_DIR/$THEME" ]; then
                rm -rf "$DEST_DIR/$THEME"
                echo "Removed $THEME from $DEST_DIR/"
            else
                echo "  $THEME not installed locally."
            fi
        else
            if [ -d "$DEST_DIR/$THEME" ]; then
                _sudo rm -rf "$DEST_DIR/$THEME"
                echo "Removed $THEME from $DEST_DIR/"
            else
                echo "  $THEME not installed globally."
            fi
        fi
    done
}

case "$ACTION" in
    install)
        install_theme
        ;;
    uninstall)
        uninstall_theme
        ;;
    *)
        echo "Error: Action must be 'install' or 'uninstall'."
        usage
        ;;
esac
