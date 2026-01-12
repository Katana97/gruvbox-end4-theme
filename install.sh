#!/bin/bash

set -e

THEME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Gruvbox Theme for end-4 dots..."
echo ""

if [ ! -d ~/.config/quickshell/ii ]; then
    echo "end-4 dots not found!"
    echo "Please install end-4 dots first"
    exit 1
fi

echo "Backing up existing files..."
BACKUP_DIR=~/.gruvbox-theme-backup/$(date +%Y%m%d_%H%M%S)
mkdir -p "$BACKUP_DIR"

[ -f ~/.config/matugen/templates/colors.json ] && cp ~/.config/matugen/templates/colors.json "$BACKUP_DIR/"
[ -f ~/.config/quickshell/ii/modules/common/Appearance.qml ] && cp ~/.config/quickshell/ii/modules/common/Appearance.qml "$BACKUP_DIR/"
[ -f ~/.config/quickshell/ii/modules/ii/bar/Resources.qml ] && cp ~/.config/quickshell/ii/modules/ii/bar/Resources.qml "$BACKUP_DIR/"
[ -f ~/.config/quickshell/ii/modules/ii/bar/Resource.qml ] && cp ~/.config/quickshell/ii/modules/ii/bar/Resource.qml "$BACKUP_DIR/"
[ -f ~/.config/quickshell/ii/modules/ii/bar/BatteryIndicator.qml ] && cp ~/.config/quickshell/ii/modules/ii/bar/BatteryIndicator.qml "$BACKUP_DIR/"
[ -f ~/.config/hypr/custom/general.conf ] && cp ~/.config/hypr/custom/general.conf "$BACKUP_DIR/"

echo "Backup saved to: $BACKUP_DIR"
echo ""

echo "Installing theme files..."

mkdir -p ~/.config/matugen/templates
cp "$THEME_DIR/files/matugen/colors.json" ~/.config/matugen/templates/

cp "$THEME_DIR/files/quickshell/Appearance.qml" ~/.config/quickshell/ii/modules/common/

cp "$THEME_DIR/files/quickshell/bar/Resources.qml" ~/.config/quickshell/ii/modules/ii/bar/
cp "$THEME_DIR/files/quickshell/bar/Resource.qml" ~/.config/quickshell/ii/modules/ii/bar/
cp "$THEME_DIR/files/quickshell/bar/BatteryIndicator.qml" ~/.config/quickshell/ii/modules/ii/bar/

mkdir -p ~/.config/hypr/custom
cp "$THEME_DIR/files/hypr/general.conf" ~/.config/hypr/custom/

echo ""
echo "Regenerating colors..."
WALLPAPER=$(cat ~/.cache/wal/wal 2>/dev/null || cat ~/.local/state/quickshell/user/generated/wallpaper/path.txt 2>/dev/null || echo "")
if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
    matugen image "$WALLPAPER"
fi

touch ~/.local/state/quickshell/user/generated/colors.json

echo ""
echo "Restarting Quickshell..."
pkill quickshell

echo ""
echo "Gruvbox theme installed successfully!"
echo "Backup: $BACKUP_DIR"
