# 🍂 Gruvbox Theme for end-4 dots

A complete, muted Gruvbox color scheme for [end-4 dots-hyprland](https://github.com/end-4/dots-hyprland) (illogical-impulse) with Spotify-inspired text colors.

![Screenshot](screenshot.png)

## ✨ Features

- 🎨 **Authentic muted Gruvbox colors** - Only colors from the original Gruvbox Dark palette
- 🎵 **Spotify-inspired text** - Bright green (#b8bb26) for readable text
- 🌈 **Colorful bar icons** - Red CPU, Yellow RAM, Blue Swap, Pink Battery, Orange Media
- 🟢 **Muted aqua accents** - For active window titles and highlights
- 🪟 **Animated gradient borders** - Blue-to-aqua window borders
- 📝 **Consistent cream text** - Unified #ebdbb2 for all body text
- 🔄 **Update-resistant** - Designed to survive end-4 dots updates

## 🎯 Color Palette

**Bar/Menu Text:**
- Main text: `#b8bb26` (bright green, Spotify-inspired)
- Body text: `#ebdbb2` (cream)
- Accents: `#8ec07c` (muted aqua)

**Bar Icons:**
- CPU: `#fb4934` (red)
- RAM: `#fabd2f` (yellow)  
- Swap: `#458588` (blue)
- Battery: `#b16286` (purple)
- Media: `#d65d0e` (orange)

**UI Elements:**
- Workspace: `#427b58` (dark aqua) with `#ebdbb2` (cream) icons
- Backgrounds: `#7c6f64`, `#665c54` (subtle browns)
- Window borders: `#83a598` → `#8ec07c` gradient

## 📋 Prerequisites

- [end-4 dots-hyprland](https://github.com/end-4/dots-hyprland) (illogical-impulse)
- Hyprland
- Quickshell
- matugen

## 🚀 Installation
```bash
git clone https://github.com/Katana97/gruvbox-end4-theme.git
cd gruvbox-end4-theme
./install.sh
```

The installer will:
1. Backup your existing configuration
2. Install all theme files
3. Regenerate colors
4. Restart Quickshell

## 🔄 After end-4 Updates

If end-4 dots updates overwrite your theme, simply run:
```bash
cd ~/gruvbox-end4-theme
./install.sh
```

Or use the convenient alias:
```bash
restore-gruvbox
```

Your backups are saved in `~/.gruvbox-theme-backup/`

## 🎧 Bluetooth Fix Included

This theme includes a fix for Bluetooth headphones (tested with Shure AONIC TW2). See [BLUETOOTH-FIX.md](BLUETOOTH-FIX.md) for details.

## 📁 What Gets Modified

- `~/.config/matugen/templates/colors.json` - Color generation template
- `~/.config/quickshell/ii/modules/common/Appearance.qml` - Default colors
- `~/.config/quickshell/ii/modules/ii/bar/Resources.qml` - Bar resource colors
- `~/.config/quickshell/ii/modules/ii/bar/Resource.qml` - Individual resource styling
- `~/.config/quickshell/ii/modules/ii/bar/BatteryIndicator.qml` - Battery color
- `~/.config/quickshell/ii/modules/ii/bar/Media.qml` - Media player color
- `~/.config/hypr/custom/general.conf` - Window borders (survives updates!)

## 🗑️ Uninstallation
```bash
cd ~/gruvbox-end4-theme
./uninstall.sh
```

This will offer to restore your previous configuration from backup.

## 🐛 Troubleshooting

**Colors don't apply after installation:**
```bash
pkill quickshell
matugen image ~/.cache/wal/wal
```

**Theme reverted after dots update:**
```bash
restore-gruvbox
```

**Bluetooth headphones not working:**
See [BLUETOOTH-FIX.md](BLUETOOTH-FIX.md)

## 🤝 Contributing

Found a bug? Have suggestions? Open an issue or PR!

## 📜 License

MIT License - See [LICENSE](LICENSE)

## 🙏 Credits

- [Gruvbox](https://github.com/morhetz/gruvbox) by morhetz
- [end-4 dots](https://github.com/end-4/dots-hyprland) by end-4
- Spotify for color inspiration
- Theme developed with assistance from Claude (Anthropic)

---

**Enjoy your cozy, retro Gruvbox desktop!** 🍂
