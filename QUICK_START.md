# Quick Start Guide - Naruto RPG Godot APK Build

**⚡ Panduan cepat untuk build APK dalam 30 menit!**

---

## 🎯 5 Langkah Cepat

### Langkah 1: Persiapan (5 menit)

#### Install Requirements
```bash
# 1. Download Godot 4.1+
https://godotengine.org/download

# 2. Install Java 11+
# Mac:
brew install openjdk@11

# Ubuntu/Debian:
sudo apt install openjdk-11-jdk

# Windows:
# Download dari: https://www.oracle.com/java/technologies/downloads/
```

#### Download Android SDK & NDK
- Download Android Studio: https://developer.android.com/studio
- Buka Android Studio
- Tools → SDK Manager
- Install:
  - Android API 34
  - Build-Tools 34.0.0
  - NDK 25.1.8937393

---

### Langkah 2: Setup Environment (3 menit)

#### Linux/Mac
```bash
# Edit ~/.bashrc atau ~/.zshrc
export JAVA_HOME=/usr/libexec/java_home -v 11  # Mac
# atau
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk  # Linux

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_NDK_ROOT=$HOME/Android/Sdk/ndk/25.1.8937393

# Apply
source ~/.bashrc
```

#### Windows (PowerShell Admin)
```powershell
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-11", "User")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", "C:\Users\YourName\AppData\Local\Android\Sdk", "User")
[Environment]::SetEnvironmentVariable("ANDROID_NDK_ROOT", "C:\Users\YourName\AppData\Local\Android\Sdk\ndk\25.1.8937393", "User")
```

#### Verifikasi
```bash
java -version
echo $ANDROID_SDK_ROOT
echo $ANDROID_NDK_ROOT
```

---

### Langkah 3: Setup Godot (10 menit)

#### Buka Project
```bash
cd naruto-rpg-godot
godot4
```

#### Buat Export Preset
1. **Project → Project Settings → Export**
2. Klik **Add Preset → Android**
3. Isi konfigurasi:

| Setting | Value |
|---------|-------|
| Package Name | `com.narutorpg.game` |
| App Name | `Naruto RPG` |
| Version | `1.0.0` |
| Min SDK | `21` |
| Target SDK | `34` |
| Architectures | ✅ ARMv7 + ARM64 |
| Permissions | ✅ INTERNET, STORAGE |

4. **Save & Close**

---

### Langkah 4: Export & Build (10 menit)

#### Opsi A: Export & Run (Fastest)
```bash
# Di Godot
Project → Export → Android → Export & Run

# Device harus connected via USB
# APK install langsung ke device
```

#### Opsi B: Export Manual
```bash
# Di Godot
Project → Export → Android → Export Project

# Akan buat folder 'android/'
# Kemudian:
cd android
./gradlew assembleDebug

# Output: app/build/outputs/apk/debug/app-debug.apk
```

#### Opsi C: Release APK (untuk Google Play)
```bash
# Setup Keystore (first time only)
keytool -genkey -v -keystore naruto-rpg.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias naruto-rpg-key

# Di Godot Export Android → Release:
# Keystore Release: naruto-rpg.keystore
# Release User: naruto-rpg-key
# Release Password: [your-password]

# Export & Build
cd android
./gradlew assembleRelease

# Output: app/build/outputs/apk/release/app-release.apk
```

---

### Langkah 5: Test & Deploy (2 menit)

#### Install ke Device
```bash
# Check device
adb devices

# Install APK
adb install -r app/build/outputs/apk/debug/app-debug.apk

# Buka app
adb shell am start -n com.narutorpg.game/.MainActivity
```

#### Check Logs
```bash
adb logcat | grep godot
```

---

## 🚀 Automated Build Script

**Lebih mudah lagi? Gunakan script otomatis!**

```bash
# Setup (sekali saja)
bash SETUP_ANDROID.sh

# Build
bash build_apk.sh

# Pilih:
# 1) Debug APK (testing)
# 2) Release APK (production)
```

---

## 🎮 Testing Checklist

```
✅ APK berhasil build
✅ APK install ke device
✅ Game buka tanpa crash
✅ Kontrol responsif
✅ Graphics bagus
✅ Audio jalan
✅ Save/Load bekerja
✅ FPS stable (30+)
```

---

## 📱 Size & Performance

| Metric | Target | Status |
|--------|--------|--------|
| APK Size | < 100MB | ⏱️ |
| Startup | < 5s | ⏱️ |
| RAM Usage | < 500MB | ⏱️ |
| FPS | 30+ | ⏱️ |

---

## ⚠️ Common Issues & Quick Fixes

| Error | Fix |
|-------|-----|
| "SDK not found" | `export ANDROID_SDK_ROOT=$HOME/Android/Sdk` |
| "NDK not found" | Download via Android Studio SDK Manager |
| "Gradle not found" | `chmod +x android/gradlew && cd android && ./gradlew --version` |
| "App crashes" | Check: `adb logcat \| grep godot` |
| "Out of memory" | Add to gradle.properties: `org.gradle.jvmargs=-Xmx2048m` |

---

## 📚 Dokumentasi Lengkap

Untuk info lebih detail:
- **[README.md](README.md)** - Project overview
- **[BUILD_APK.md](BUILD_APK.md)** - Build guide lengkap
- **[BUILD_CHECKLIST.md](BUILD_CHECKLIST.md)** - Pre-build checklist
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to contribute

---

## 🎯 Next Steps

### Setelah Build Berhasil
1. ✅ Test di multiple devices
2. ✅ Optimize performance
3. ✅ Create release version
4. ✅ Upload ke Google Play

### Untuk Google Play
1. Create developer account: https://play.google.com/console
2. Upload signed APK
3. Fill store listing
4. Submit for review

---

## 💡 Pro Tips

```bash
# 1. Build lebih cepat
# Disable unused architectures (x86/x86_64)
# Enable only ARM64 untuk production

# 2. Reduce APK size
# Enable VRAM compression: ETC2/S3TC
# Remove unused assets

# 3. Better performance
# Use GL Compatibility renderer
# Profile dengan Godot Profiler: Debug → Profiler

# 4. Faster iteration
# Use build_apk.sh script
# Automated checks & install

# 5. Debugging
# Enable logcat monitoring:
# adb logcat -f logfile.txt
# Play game
# Check logfile.txt for errors
```

---

## 🆘 Perlu Bantuan?

Jika mengalami masalah:

1. Check documentation: [BUILD_APK.md](BUILD_APK.md)
2. Check checklist: [BUILD_CHECKLIST.md](BUILD_CHECKLIST.md)
3. View logs: `adb logcat | grep godot`
4. Open GitHub Issue

---

## ⏱️ Timeline

```
Start → 30 menit later → APK Ready! 🎉

5 min  | Preparation
3 min  | Environment Setup
10 min | Godot Configuration
10 min | Build & Export
2 min  | Testing
------
30 min | TOTAL
```

---

## ✨ You Did It!

Selamat! 🎊 APK Anda sudah siap!

**Next:** Upload ke Google Play atau bagikan ke teman! 🚀

---

**Status**: ✅ Ready to Deploy
**Last Updated**: 2026-08-10
**Time to Build**: ~30 minutes
