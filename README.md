# Naruto RPG Godot - README

**Game RPG Naruto super lengkap dengan build APK siap production!**

## 🎮 Tentang Game

Naruto RPG adalah game role-playing yang dibuat dengan Godot Engine 4.1+ dengan fitur-fitur lengkap:

- ⚔️ Combat System yang mendalam
- 🎯 Skill & Jutsu system
- 📦 Inventory management
- 💾 Save/Load system
- 🗺️ Multiple maps & exploration
- 👥 Character progression
- 🎨 Beautiful pixel art graphics
- 🔊 Background music & SFX

---

## 📁 Project Structure

```
naruto-rpg-godot/
├── assets/              # Game assets
│   ├── sprites/        # Character & enemy sprites
│   ├── animations/     # Sprite animations
│   ├── textures/       # Backgrounds & UI
│   ├── audio/          # Music & sound effects
│   └── fonts/          # Game fonts
├── scenes/             # Godot scenes
│   ├── Main.tscn       # Main game scene
│   ├── maps/           # Map scenes
│   ├── characters/     # Character scenes
│   ├── enemies/        # Enemy scenes
│   ├── skills/         # Skill effects
│   ├── ui/             # UI scenes
│   └── systems/        # Game systems
├── scripts/            # GDScript source code
│   ├── player/         # Player scripts
│   ├── enemy/          # Enemy AI
│   ├── combat/         # Combat system
│   ├── skills/         # Skill logic
│   ├── inventory/      # Inventory system
│   ├── quest/          # Quest system
│   └── save/           # Save/Load logic
├── data/               # Game data (JSON)
│   ├── characters.json # Character stats
│   ├── skills.json     # Skill definitions
│   ├── enemies.json    # Enemy data
│   ├── items.json      # Item database
│   ├── quests.json     # Quest data
│   └── maps.json       # Map configuration
├── project.godot       # Godot project config
├── BUILD_APK.md        # APK build guide
├── BUILD_CHECKLIST.md  # Build checklist
├── SETUP_ANDROID.sh    # Android setup script
└── build_apk.sh        # Build automation script
```

---

## 🚀 Quick Start

### Desktop (Testing)

```bash
# Clone repository
git clone https://github.com/YADI-ganteng/naruto-rpg-godot.git
cd naruto-rpg-godot

# Open with Godot Engine 4.1+
godot4

# Run (F5 or Play button)
```

### Android (APK Build)

Lihat: **[BUILD_APK.md](BUILD_APK.md)** untuk panduan lengkap

Quick build:
```bash
# Setup environment (one-time)
bash SETUP_ANDROID.sh

# Build APK
bash build_apk.sh
```

---

## 📋 Requirements

### Desktop Development
- **Godot Engine** 4.1 atau lebih baru
- **64-bit OS** (Windows/Mac/Linux)
- **4GB RAM** minimum

### Android Build
- **Godot Engine** 4.1+
- **Java JDK** 11+
- **Android SDK** API 24+
- **Android NDK** 21+
- **Gradle** 7.0+
- **2-4GB** free disk space

---

## 🎯 Development Tips

### Project Settings
```
File → Project Settings:
- General → Textures → VRAM Compression: Enable ETC2/S3TC
- Debug → GDScript → Android SDK/NDK paths
- Export → Android: Configure presets
```

### Running Game
```
F5              # Run current scene
F6              # Run main scene
F8              # Pause/Resume
Ctrl+Shift+F5  # Run with breakpoints
```

### Debugging
```bash
# View console output
Output → Toggle Console

# Enable debug prints
print("Debug message")

# Profiler
Debug → Monitor
Debug → Profiler
```

### Building
```bash
# Export for testing
Project → Export → Android → Export & Run

# Export for distribution
Project → Export → Android → Export Project
# Then: cd android && ./gradlew assembleRelease
```

---

## 🔧 Configuration

### Input Controls
Edit di `project.godot`:
```
[input]
move_up     → W / UP Arrow
move_down   → S / DOWN Arrow
move_left   → A / LEFT Arrow
move_right  → D / RIGHT Arrow
ui_attack   → SPACE / Left Click
ui_skill    → Q / Right Click
ui_dash     → SHIFT
```

### Game Balance
Edit di `data/`:
- `characters.json` - Player stats & abilities
- `enemies.json` - Enemy difficulty
- `skills.json` - Skill damage & cooldown
- `items.json` - Equipment & consumables

### Graphics Settings
Edit di `project.godot`:
```
[rendering]
renderer/rendering_method     = "gl_compatibility"  # GL untuk compatibility
textures/vram_compression     = true                 # Enable compression
vulkan/enable                 = false                # Disable Vulkan
```

---

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Windows | ✅ Full | Desktop play |
| Mac | ✅ Full | Desktop play |
| Linux | ✅ Full | Desktop play |
| Android | ✅ Full | APK build ready |
| iOS | ⚠️ Paid | Requires Godot Pro |
| Web (HTML5) | ⚠️ Partial | Limited performance |

---

## 🎨 Customization

### Changing Game Name
```
project.godot:
[application]
config/name = "Your Game Name"

[application]
run/main_scene = "res://scenes/Main.tscn"
```

### Changing Package Name
```
project.godot or Export → Android:
package/unique_name = "com.yourcompany.gamename"
```

### Changing Appearance
- Icons: `assets/icon/`
- Sprites: `assets/sprites/`
- Fonts: `assets/fonts/`
- Colors: Edit shaders in `scenes/`

---

## 🐛 Troubleshooting

### Game won't run
```bash
# Check console for errors
# Fix any script errors in scripts/

# Reset project
Project → Tools → Orphan Resources Explorer
```

### Performance issues
```
1. Check in Debug → Profiler
2. Reduce draw calls
3. Optimize shaders
4. Use LOD (Level of Detail)
5. Profile FPS with: get_tree().get_multiplayer().get_debug_info()
```

### Build fails
Lihat: **[BUILD_CHECKLIST.md](BUILD_CHECKLIST.md)**

### APK crashes on Android
```bash
# Check logs
adb logcat | grep godot

# Ensure minimum API 24
# Test on multiple devices
# Check VRAM compression compatibility
```

---

## 📚 Documentation

- [BUILD_APK.md](BUILD_APK.md) - Panduan build APK lengkap
- [BUILD_CHECKLIST.md](BUILD_CHECKLIST.md) - Checklist pre-build
- [SETUP_ANDROID.sh](SETUP_ANDROID.sh) - Setup script otomatis
- [build_apk.sh](build_apk.sh) - Build script otomatis

---

## 🔗 Useful Links

- **Godot**: https://godotengine.org/
- **Godot Docs**: https://docs.godotengine.org/
- **Godot Community**: https://forum.godotengine.org/
- **Android Dev**: https://developer.android.com/
- **Google Play**: https://play.google.com/console

---

## 👨‍💻 Contributing

Kontribusi welcome! Untuk contribute:

1. Fork repository
2. Buat branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

## 📄 License

Project ini open source. Silahkan gunakan untuk project personal maupun komersial.

---

## 📧 Contact

- **GitHub**: [@YADI-ganteng](https://github.com/YADI-ganteng)
- **Repository**: https://github.com/YADI-ganteng/naruto-rpg-godot

---

## 🎉 Credits

- **Engine**: Godot Engine 4.1+
- **Language**: GDScript
- **Theme**: Naruto Anime
- **Status**: ✅ Ready for Production

---

## 📊 Project Stats

- **Language**: 100% GDScript
- **Engine**: Godot 4.1+
- **Platforms**: Windows, Mac, Linux, Android
- **Last Updated**: 2026-08-10
- **Build Status**: ✅ Production Ready

---

**Happy Coding! 🚀**

Untuk build APK production-ready, ikuti panduan di [BUILD_APK.md](BUILD_APK.md)
