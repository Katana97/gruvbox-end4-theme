#!/bin/bash

echo "Uninstalling Gruvbox theme..."
echo ""
echo "Available backups:"
ls -d ~/.gruvbox-theme-backup/* 2>/dev/null || echo "No backups found"
echo ""
read -p "Enter backup directory to restore (or 'skip' to just remove theme): " BACKUP_DIR

if [ "$BACKUP_DIR" != "skip" ] && [ -d "$BACKUP_DIR" ]; then
    echo "Restoring from $BACKUP_DIR..."
    [ -f "$BACKUP_DIR/colors.json" ] && cp "$BACKUP_DIR/colors.json" ~/.config/matugen/templates/
    [ -f "$BACKUP_DIR/Appearance.qml" ] && cp "$BACKUP_DIR/Appearance.qml" ~/.config/quickshell/ii/modules/common/
    [ -f "$BACKUP_DIR/Resources.qml" ] && cp "$BACKUP_DIR/Resources.qml" ~/.config/quickshell/ii/modules/ii/bar/
    [ -f "$BACKUP_DIR/Resource.qml" ] && cp "$BACKUP_DIR/Resource.qml" ~/.config/quickshell/ii/modules/ii/bar/
    [ -f "$BACKUP_DIR/BatteryIndicator.qml" ] && cp "$BACKUP_DIR/BatteryIndicator.qml" ~/.config/quickshell/ii/modules/ii/bar/
    [ -f "$BACKUP_DIR/general.conf" ] && cp "$BACKUP_DIR/general.conf" ~/.config/hypr/custom/
    
    pkill quickshell
    echo "Restored successfully!"
fi
