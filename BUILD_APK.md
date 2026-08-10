# Build APK Guide - Naruto RPG Godot

## 📋 Persyaratan (Prerequisites)

### 1. Godot Engine 4.1+
- Download: https://godotengine.org/download
- Pilih versi **Standard (4.1 atau lebih baru)**
- Ekstrak dan jalankan

### 2. Java Development Kit (JDK) 11+
```bash
# Linux/Mac
brew install openjdk@11  # Mac
sudo apt install openjdk-11-jdk  # Ubuntu/Debian

# Windows
# Download dari: https://www.oracle.com/java/technologies/downloads/
```

### 3. Android SDK & NDK
**Opsi A: Install via Android Studio (Recommended)**
- Download: https://developer.android.com/studio
- Buka Android Studio
- Tools → SDK Manager
- Pilih:
  - SDK Platforms: Android 12 (API 31) - API 34
  - SDK Tools: NDK, Build-Tools

**Opsi B: Command Line (Linux/Mac)**
```bash
# Buat direktori
mkdir -p ~/Android/Sdk
cd ~/Android/Sdk

# Download SDK tools
# https://developer.android.com/studio/releases/sdk-tools

# Atau gunakan sdkmanager
./cmdline-tools/latest/bin/sdkmanager "platforms;android-34"
./cmdline-tools/latest/bin/sdkmanager "build-tools;34.0.0"
./cmdline-tools/latest/bin/sdkmanager "ndk;25.1.8937393"
```

---

## 🔧 Langkah 1: Setup Environment Variables

### Linux/Mac
```bash
# Edit ~/.bashrc atau ~/.zshrc
export JAVA_HOME=/path/to/jdk11
export ANDROID_SDK_ROOT=~/Android/Sdk
export ANDROID_NDK_ROOT=~/Android/Sdk/ndk/25.1.8937393
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# Apply changes
source ~/.bashrc  # atau ~/.zshrc
```

### Windows (PowerShell Admin)
```powershell
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-11", "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", "C:\Users\YourName\AppData\Local\Android\Sdk", "User")
[Environment]::SetEnvironmentVariable("ANDROID_NDK_ROOT", "C:\Users\YourName\AppData\Local\Android\Sdk\ndk\25.1.8937393", "User")
```

### Verifikasi
```bash
java -version
# Output: openjdk version "11.x.x"

echo $ANDROID_SDK_ROOT
# Output: /home/user/Android/Sdk

echo $ANDROID_NDK_ROOT
# Output: /home/user/Android/Sdk/ndk/25.1.8937393
```

---

## 🚀 Langkah 2: Setup Godot Export untuk Android

### 1. Buka Godot Project
```bash
cd naruto-rpg-godot
godot4
```

### 2. Konfigurasi Export Preset
- Buka: **Project → Project Settings → Export**
- Klik **Add Preset**
- Pilih **Android**

### 3. Isi Konfigurasi Android

#### Application Tab
| Setting | Value |
|---------|-------|
| Package Name | `com.narutorpg.game` |
| App Name | `Naruto RPG` |
| Version | `1.0.0` |
| Version Code | `1` |
| Classify as Game | ✅ ON |

#### Permissions Tab
```
✅ INTERNET
✅ ACCESS_NETWORK_STATE
✅ READ_EXTERNAL_STORAGE
✅ WRITE_EXTERNAL_STORAGE
```

#### Graphics Tab
```
✅ GLES3
✅ Vulkan (Optional)
❌ OpenGL
VRAM Compression: ETC2/S3TC
```

#### Architectures
```
✅ ARMv7 (32-bit)
✅ ARM64 (64-bit) - Recommended
❌ x86
❌ x86_64
```

#### Screen Orientation
```
Portrait: ✅ ON
Landscape: ❌ OFF
(Sesuaikan dengan game Anda)
```

---

## 🔐 Langkah 3: Setup Keystore (Signing)

### Generate Keystore Baru (First Time)
```bash
# Linux/Mac/Windows (PowerShell)
keytool -genkey -v -keystore naruto-rpg.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias naruto-rpg-key

# Masukkan data:
# - Password: (masukkan password)
# - First/Last Name: Your Name
# - Organization: Naruto RPG
# - City/State/Country: Indonesia
# - Confirm: yes
```

### Di Godot Export Android
- **Release → Keystore → Release**: Pilih file `naruto-rpg.keystore`
- **Release → Keystore User**: `naruto-rpg-key`
- **Release → Keystore Password**: (masukkan password keystore)

---

## 📦 Langkah 4: Build APK

### Metode 1: Build Debug APK (Testing)
```bash
# Di Godot Project
Project → Export → Android → Export & Run
```

Output: `build/app-debug.apk`

### Metode 2: Build Release APK (Production)
```bash
# Di Godot Project
Project → Export → Android → Export Project

# Akan generate folder 'android/'
# Build dengan Gradle:
cd android
./gradlew assembleRelease

# Tunggu selesai (5-10 menit)
# Output: android/app/build/outputs/apk/release/app-release.apk
```

### Metode 3: Build & Run ke Device
```bash
# Pastikan device connected
adb devices

# Di Godot
Project → Export → Android → Export & Run
# APK akan install langsung ke device
```

---

## ✅ Verifikasi Build

### Check APK File
```bash
ls -lh build/app-release.apk
# Output: -rw-r--r-- 1 user user 45M Aug 10 12:00 build/app-release.apk
```

### Install ke Device
```bash
adb install -r build/app-release.apk

# atau dengan adb push + install
adb push build/app-release.apk /data/local/tmp/
adb shell pm install /data/local/tmp/app-release.apk
```

### Check di Device
```bash
adb shell pm list packages | grep narutorpg
# Output: package:com.narutorpg.game

# Lihat logs
adb logcat | grep godot
```

### Uninstall (Jika perlu)
```bash
adb uninstall com.narutorpg.game
```

---

## 🐛 Troubleshooting

### Error: "Gradle not found"
```bash
cd naruto-rpg-godot/android
chmod +x gradlew
./gradlew --version
```

### Error: "Android SDK not found"
```bash
# Cek path
echo $ANDROID_SDK_ROOT

# Set manually di Godot
Project → Project Settings → Debug → GDScript
Android SDK Path: /path/to/sdk
Android NDK Path: /path/to/ndk
```

### Error: "NDK not found"
```bash
# Download NDK lewat SDK Manager
# atau manual:
cd ~/Android/Sdk/ndk
ls -la
# Seharusnya ada folder seperti: 25.1.8937393

# Update path di Godot
```

### Error: "JDK not found"
```bash
which java
# Jika tidak ketemu, install JDK 11

# Set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
echo $JAVA_HOME
```

### Error: "Build failed - OutOfMemory"
```bash
# Tambah heap size di gradle.properties
echo "org.gradle.jvmargs=-Xmx2048m" >> android/gradle.properties

# Rebuild
cd android && ./gradlew clean assembleRelease
```

### Error: "Rendering fails on device"
```
Solusi:
1. Ubah rendering method ke GL_COMPATIBILITY
2. Disable Vulkan
3. Enable ETC2/S3TC compression
4. Test di device lebih lama (5-10 menit first launch)
```

---

## 📱 Testing Checklist

- [ ] APK berhasil dicompile tanpa error
- [ ] APK berukuran wajar (< 100MB)
- [ ] Install di device/emulator berhasil
- [ ] Game bisa dibuka
- [ ] Kontrol bergerak responsif
- [ ] Graphics terlihat bagus
- [ ] Audio berjalan
- [ ] Save/Load berfungsi
- [ ] Tidak ada crash

---

## 🎯 Optimization Tips

### Reduce APK Size
```
1. Enable: Textures → VRAM Compression → ETC2/S3TC
2. Remove unused assets
3. Minify Resources
4. Disable unused features (3D, physics, etc)
5. Compress scenes
```

Target size: 30-60MB untuk RPG

### Better Performance
```
1. Use GL Compatibility renderer
2. Reduce draw calls
3. Optimize shaders
4. Use LOD (Level of Detail)
5. Profile dengan Godot Profiler
```

### Battery Optimization
```
1. Reduce FPS pada pause menu
2. Optimize physics step
3. Minimal background processing
4. Use power efficient animations
```

---

## 📤 Upload ke Google Play

### Requirements
- APK signed dengan private keystore
- Version Code increment setiap update
- Minimum API: 21 (Android 5.0)
- Target API: 34+ (Android 14+)

### Steps
1. Create Google Play Developer Account
2. Create new app in Play Console
3. Upload signed APK
4. Fill store listing (description, screenshots, etc)
5. Set price & distribution
6. Submit for review (24-48 jam)

---

## 📞 Support Links

- **Godot Documentation**: https://docs.godotengine.org/
- **Godot Android Export**: https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html
- **Android Developer**: https://developer.android.com/
- **Google Play Console**: https://play.google.com/console
- **Godot Discord**: https://discord.gg/godotengine
- **Godot Forums**: https://forum.godotengine.org/

---

**Last Updated**: 2026-08-10
**Godot Version**: 4.1+
**Status**: Ready for Production ✅
