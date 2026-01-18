#!/bin/bash
COLOR_SCHEME="${1:-GruvboxColors}"
SCHEME_FILE="$HOME/.local/share/color-schemes/${COLOR_SCHEME}.colors"

if [[ ! -f "$SCHEME_FILE" ]]; then
    echo "Warning: Color scheme file not found: $SCHEME_FILE"
    exit 1
fi

# Backup kdeglobals
cp ~/.config/kdeglobals ~/.config/kdeglobals.matugen-backup

# Remove all [Colors:*] sections from kdeglobals and replace with the scheme
awk '/^\[Colors:/{flag=1} flag && /^\[/ && !/^\[Colors:/{flag=0} !flag' ~/.config/kdeglobals > /tmp/kdeglobals_no_colors

# Append the Colors sections from the color scheme
awk '/^\[Colors:/{flag=1} flag' "$SCHEME_FILE" >> /tmp/kdeglobals_no_colors

# Replace kdeglobals
mv /tmp/kdeglobals_no_colors ~/.config/kdeglobals

# Set the ColorScheme name
kwriteconfig5 --file kdeglobals --group General --key ColorScheme "$COLOR_SCHEME"

echo "Applied $COLOR_SCHEME to kdeglobals"
