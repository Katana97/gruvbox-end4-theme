# Gruvbox End-4 Theme

A complete, production-ready Gruvbox desktop environment for Arch Linux/CachyOS featuring Hyprland, QuickShell, and extensive customization.

![Desktop Preview](screenshot.png)

## ✨ Features

### 🎨 Complete Gruvbox Theming
- **Static Gruvbox colors** - No Material You override, consistent theming
- **GTK 3/4** - Full Gruvbox integration for all GTK applications
- **Qt5/6 + Kvantum** - Matching theme for Qt applications
- **KDE Color Schemes** - Multiple Gruvbox variants included
- **Dolphin File Manager** - Fully themed to match desktop

### 🖥️ QuickShell Bar (End-4 II)
- **Fixed Media Player** 
  - Smooth text scrolling with proper padding
  - Width-constrained (max 200px) to prevent overlap
  - 8px left padding for short text
  - Pause animations at start/end
- **Resource Monitors**
  - Swap usage **always visible** (fixed!)
  - CPU, RAM monitoring with Gruvbox colors
- **Light/Dark Mode Toggle**
  - Bar toggle now works **both directions** (fixed!)
  - Settings menu toggle also works
  - No wallpaper switching with `--noswitch` flag
- **Battery Indicator** with Gruvbox styling
- **Network, Bluetooth, Volume** indicators

### 🚀 Plymouth Boot Animation
- **Animated Gruvbox Rubik's Cube**
- 36 frames at 1920x1080 resolution
- Plays once and holds on final frame
- Gruvbox dark background (#282828)
- Smooth ~15fps animation

### 🎯 Hyprland Configuration
- Custom keybindings optimized for workflow
- Multi-monitor support
- Workspace management
- Window rules and animations
- eGPU support configurations

### 🖱️ Oreo Gruvbox Cursor Theme
- Complete cursor set with Gruvbox grey colors
- Hyprcursor support
- All cursor states included

## 📦 What's Included

```
gruvbox-end4-theme/
├── config/
│   ├── quickshell/          # Complete QuickShell configuration
│   │   └── ii/              # End-4 II setup with all fixes
│   ├── hypr/                # Hyprland configuration
│   │   ├── hyprland.conf
│   │   ├── custom/          # Custom rules and settings
│   │   └── monitors.conf
│   └── dolphin/             # File manager configuration
├── themes/
│   ├── gtk/                 # GTK 3/4 Gruvbox themes
│   ├── qt/                  # Qt5/6 + Kvantum themes
│   ├── cursors/             # Oreo Gruvbox cursor theme
│   └── color-schemes/       # KDE Gruvbox color schemes
├── plymouth/
│   └── gruvbox-rubiks/      # Boot animation (36 frames)
├── cursors/
│   └── oreo_gruvbox_grey_cursors/  # Complete cursor set
├── files/                   # Additional configuration files
├── install.sh               # Automated installer
├── uninstall.sh            # Uninstaller
└── BLUETOOTH-FIX.md        # Bluetooth troubleshooting
```

## 🚀 Quick Install

### Prerequisites
- Fresh or existing Arch Linux/CachyOS installation
- End-4 dots already installed (or will be installed by script)
- AUR helper (yay/paru)
- Internet connection

### One-Command Install
```bash
git clone https://github.com/Katana97/gruvbox-end4-theme.git
cd gruvbox-end4-theme
chmod +x install.sh
./install.sh
```

The installer will:
1. ✅ Detect existing End-4 installation (or install it)
2. ✅ Install all required packages
3. ✅ Apply Gruvbox themes system-wide
4. ✅ Install QuickShell with all fixes
5. ✅ Set up Plymouth boot animation
6. ✅ Configure Hyprland
7. ✅ Install Oreo Gruvbox cursor theme
8. ✅ Set up Dolphin theming

## 🎨 Gruvbox Color Palette

| Element | Hex | Usage |
|---------|-----|-------|
| Background | `#282828` | Main background |
| Foreground | `#ebdbb2` | Main text |
| Dark Grey | `#3c3836` | Borders, inactive |
| Red | `#cc241d` | Errors, CPU monitor |
| Orange | `#d65d0e` | Media player accent |
| Yellow | `#fabd2f` | Primary, memory monitor |
| Green | `#98971a` | Success states |
| Aqua | `#689d6a` | Secondary |
| Blue | `#458588` | Swap monitor, links |
| Purple | `#b16286` | Tertiary, highlights |

## 🔧 Key Fixes & Improvements

### Media Player (QuickShell)
**Before:** Text cut off on left, no width limit, pushed swap icon away  
**After:** 
- 8px left padding for short text
- 200px maximum width
- Smooth scrolling with pauses
- `Layout.fillWidth: false` prevents expansion

**File:** `config/quickshell/ii/modules/ii/bar/Media.qml`

### Swap Icon Always Visible
**Before:** Hidden when media was playing  
**After:** Always visible with `|| true` in visibility condition

**File:** `config/quickshell/ii/modules/ii/bar/Resources.qml`

### Light/Dark Mode Bar Toggle
**Before:** Only switched TO light mode, couldn't switch back  
**After:** Proper if/else conditional logic toggles both directions

**File:** `config/quickshell/ii/modules/common/models/quickToggles/DarkModeToggle.qml`

### Static Gruvbox Colors
**Before:** Material You overrode manual colors based on wallpaper  
**After:** All Material 3 colors hardcoded to Gruvbox values

**File:** `config/quickshell/ii/modules/common/Appearance.qml`

See [FIXES.md](FIXES.md) for detailed technical documentation of all fixes.

## 📸 Screenshots

### Desktop
![Main Desktop](screenshot.png)

### QuickShell Bar
*Media player with smooth scrolling, always-visible swap icon*

### Plymouth Boot
*Gruvbox Rubik's Cube animation*

### Applications
*Dolphin file manager with full Gruvbox integration*

## 🛠️ Customization

### Adjust Media Player Width
Edit `config/quickshell/ii/modules/ii/bar/Media.qml`:
```qml
Layout.maximumWidth: 200  // Change to your preference
```

### Change Scroll Speed
Edit `config/quickshell/ii/modules/ii/bar/Media.qml`:
```qml
duration: 8000  // Milliseconds for full scroll
```

### Plymouth Animation Speed
Edit `plymouth/gruvbox-rubiks/gruvbox-rubiks.script`:
```qml
global.frame_delay = 4;  // Lower = faster (2-8 recommended)
```

### Apply to Existing End-4 Installation
The install script detects existing End-4 installations and only applies Gruvbox modifications without reinstalling base components.

## 🐛 Troubleshooting

### QuickShell not starting
```bash
# Check logs
journalctl --user -xe | grep quickshell

# Restart manually
killall quickshell
quickshell &
```

### Media player text still cut off
Ensure you've copied the fixed `Media.qml`:
```bash
cp config/quickshell/ii/modules/ii/bar/Media.qml \
   ~/.config/quickshell/ii/modules/ii/bar/Media.qml
killall quickshell && quickshell &
```

### Swap icon still disappearing
Ensure you've copied the fixed `Resources.qml`:
```bash
cp config/quickshell/ii/modules/ii/bar/Resources.qml \
   ~/.config/quickshell/ii/modules/ii/bar/Resources.qml
killall quickshell && quickshell &
```

### Bar toggle only works one way
Copy the fixed `DarkModeToggle.qml`:
```bash
cp config/quickshell/ii/modules/common/models/quickToggles/DarkModeToggle.qml \
   ~/.config/quickshell/ii/modules/common/models/quickToggles/DarkModeToggle.qml
killall quickshell && quickshell &
```

### Plymouth not showing
```bash
# Verify kernel parameters
cat /proc/cmdline | grep "quiet splash"

# Check theme is set
sudo plymouth-set-default-theme

# Rebuild initramfs
sudo mkinitcpio -P

# Update GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Bluetooth Issues
See [BLUETOOTH-FIX.md](BLUETOOTH-FIX.md) for detailed Bluetooth troubleshooting.

### Themes not applying
```bash
# GTK apps
gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Dark"

# Qt apps - run Kvantum Manager
kvantummanager
```

## 📚 Additional Documentation

- **[FIXES.md](FIXES.md)** - Detailed technical documentation of all fixes
- **[BLUETOOTH-FIX.md](BLUETOOTH-FIX.md)** - Bluetooth troubleshooting guide
- **[install.sh](install.sh)** - Automated installation script
- **[uninstall.sh](uninstall.sh)** - Complete removal script

## 🔄 Updates & Maintenance

To update your installation with latest improvements:
```bash
cd gruvbox-end4-theme
git pull
./install.sh
```

## 💾 Backup Before Installing

The install script creates automatic backups in:
```
~/Backups/pre-gruvbox-install-TIMESTAMP/
```

## 🎯 Compatibility

**Tested on:**
- CachyOS (primary development platform)
- Arch Linux
- EndeavourOS

**Desktop Environment:**
- Hyprland (required)
- QuickShell End-4 II (required)

**Display Server:**
- Wayland only

## 🤝 Contributing

Contributions are welcome! Areas for improvement:
- Additional color scheme variants
- More Plymouth animations
- Widget additions to QuickShell bar
- Additional application themes
- Documentation improvements

## 📜 License

This project is released under the MIT License. See [LICENSE](LICENSE) for details.

## 🙏 Credits & Acknowledgments

### Theme & Colors
- **Gruvbox** by [morhetz](https://github.com/morhetz/gruvbox) - The incredible color scheme
- **Gruvbox Material** - Color palette inspiration

### Desktop Environment
- **End-4 dots** by [end-4](https://github.com/end-4/dots) - Base QuickShell configuration
- **Hyprland** by [vaxerski](https://github.com/hyprwlorg/Hyprland) - Wayland compositor

### Cursor Theme
- **Oreo cursors** - Base cursor theme, modified for Gruvbox colors

### Boot Animation
- **Plymouth** - Boot splash framework
- Custom Gruvbox Rubik's Cube animation

### Development
- Developed with assistance from Claude AI (Anthropic)
- Extensive testing and refinement on CachyOS

## 💬 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/Katana97/gruvbox-end4-theme/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Katana97/gruvbox-end4-theme/discussions)

## ⭐ Show Your Support

If you find this theme useful, please consider:
- ⭐ Starring the repository
- 🐛 Reporting bugs or issues
- 💡 Suggesting improvements
- 📸 Sharing screenshots of your setup
- 🔄 Contributing fixes or enhancements

## 🗺️ Roadmap

- [ ] Additional Gruvbox light mode refinements
- [ ] More Plymouth animation variants
- [ ] Waybar configuration option
- [ ] Additional widget integrations
- [ ] Video installation tutorial
- [ ] Pre-built theme packages
- [ ] One-click installer for major distros

---

**Made with ☕ and Gruvbox** | Last updated: January 2026

**Current Version:** 2.0.0 - Complete rewrite with all fixes and improvements
