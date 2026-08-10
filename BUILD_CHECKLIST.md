# Naruto RPG Godot - BUILD CHECKLIST

## 📋 Pre-Build Checklist

### Environment Setup
- [ ] Java 11+ installed
- [ ] JAVA_HOME set correctly
- [ ] Android SDK installed
- [ ] ANDROID_SDK_ROOT set correctly
- [ ] Android NDK installed
- [ ] ANDROID_NDK_ROOT set correctly
- [ ] Gradle wrapper (gradlew) executable

### Godot Project
- [ ] Godot 4.1+ installed
- [ ] Project loads without errors
- [ ] Main scene (res://scenes/Main.tscn) exists
- [ ] All assets imported correctly
- [ ] Scripts compile without errors
- [ ] No missing dependencies

### Android Configuration
- [ ] Export preset created for Android
- [ ] Package name: com.narutorpg.game
- [ ] Version: 1.0.0, Code: 1
- [ ] Minimum SDK: API 24+
- [ ] Target SDK: API 34+
- [ ] Permissions configured (INTERNET, STORAGE)
- [ ] Graphics: GL_COMPATIBILITY enabled
- [ ] Architectures: ARMv7 + ARM64

---

## 🔧 Build Process

### Step 1: Export Project
```bash
cd naruto-rpg-godot
godot4 --headless --export-debug android build/app-debug.apk
# atau gunakan GUI: Project → Export → Android
```

- [ ] Export complete without errors
- [ ] android/ folder created
- [ ] android/gradlew exists
- [ ] android/app/src exists

### Step 2: Configure Gradle

```bash
cd android
# Check gradle version
./gradlew --version
```

- [ ] Gradle 7.0+ installed
- [ ] Build-tools 34+ available

### Step 3: Build APK

```bash
# Clean build
./gradlew clean

# Debug build
./gradlew assembleDebug

# atau Release build (jika signed)
./gradlew assembleRelease
```

- [ ] Build starts successfully
- [ ] No compilation errors
- [ ] Build completes (5-15 menit)
- [ ] APK file generated

### Step 4: Verify APK

```bash
# Check file
ls -lh app/build/outputs/apk/debug/app-debug.apk

# Verify integrity
unzip -t app/build/outputs/apk/debug/app-debug.apk
```

- [ ] APK file exists
- [ ] File size reasonable (20-100MB)
- [ ] APK integrity verified
- [ ] Contains AndroidManifest.xml

---

## 📱 Testing

### Device Setup
- [ ] Android device connected via USB
- [ ] USB debugging enabled
- [ ] ADB recognizes device (`adb devices`)
- [ ] Device has Android 5.0+ (API 21+)

### Install & Test

```bash
# Install APK
adb install -r app/build/outputs/apk/debug/app-debug.apk

# Check installation
adb shell pm list packages | grep narutorpg

# Open app
adb shell am start -n com.narutorpg.game/.MainActivity

# Check logs
adb logcat | grep godot
```

- [ ] APK installs successfully
- [ ] App appears in app drawer
- [ ] App launches without crash
- [ ] Main menu displays correctly
- [ ] Controls responsive
- [ ] Graphics render properly
- [ ] Audio plays
- [ ] No memory leaks (check logcat)

### Gameplay Testing
- [ ] Player movement works
- [ ] Combat system functional
- [ ] Skills can be used
- [ ] Save/Load works
- [ ] No visual glitches
- [ ] FPS acceptable (30+ fps)
- [ ] Touch controls if mobile

### Performance Testing
```bash
# Monitor FPS
adb shell dumpsys gfxinfo com.narutorpg.game

# Memory usage
adb shell dumpsys meminfo com.narutorpg.game

# Battery usage
adb shell dumpsys batterystats --reset
# Play game
adb shell dumpsys batterystats
```

- [ ] CPU usage < 80%
- [ ] Memory < 500MB
- [ ] FPS stable
- [ ] Battery drain acceptable

---

## 🔐 Release Build

### Keystore
- [ ] Keystore file created (naruto-rpg.keystore)
- [ ] Keystore password saved securely
- [ ] Key alias configured
- [ ] Alias password saved

### Signing Configuration
```bash
# In Godot Export Android:
# - Keystore Release: /path/to/naruto-rpg.keystore
# - Release User: naruto-rpg-key
# - Release Password: [your-password]
```

- [ ] Keystore path correct
- [ ] Passwords correct
- [ ] Release signing configured

### Build Release APK
```bash
./gradlew assembleRelease
```

- [ ] Release build succeeds
- [ ] APK signed properly
- [ ] File at: app/build/outputs/apk/release/app-release.apk

### Verify Release APK
```bash
jarsigner -verify -verbose -certs app/build/outputs/apk/release/app-release.apk
```

- [ ] Signature verified
- [ ] Certificate details correct
- [ ] Ready for Play Store

---

## 📤 Distribution

### Google Play Store
- [ ] Developer account created
- [ ] New app created in Play Console
- [ ] Store listing completed
- [ ] Privacy policy added
- [ ] Screenshots uploaded
- [ ] App description written
- [ ] Content rating filled
- [ ] Version code incremented
- [ ] Release APK uploaded
- [ ] Target countries selected
- [ ] Submitted for review

### Testing Links
- [ ] Internal testing link generated
- [ ] Beta testing link generated
- [ ] Testers added
- [ ] Testing checklist sent

---

## 🐛 Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| Build fails - "SDK not found" | Set ANDROID_SDK_ROOT environment variable |
| Build fails - "NDK not found" | Download NDK, set ANDROID_NDK_ROOT |
| APK won't install | Check min API level, clear app data first |
| App crashes on launch | Check logcat for errors, fix script errors |
| Graphics not rendering | Enable GL_COMPATIBILITY, disable Vulkan |
| Out of memory | Increase Gradle heap: `-Xmx2048m` |
| Signing fails | Check keystore file, verify passwords |

---

## 📊 Build Performance

| Stage | Time | Status |
|-------|------|--------|
| Environment check | < 1 min | ⏱️ |
| Project export | 2-5 min | ⏱️ |
| Gradle download | 2-10 min | ⏱️ |
| Clean | 1-2 min | ⏱️ |
| Compile | 5-10 min | ⏱️ |
| Assemble APK | 1-2 min | ⏱️ |
| **Total** | **15-30 min** | ⏱️ |

---

## ✅ Final Verification

Before releasing:

- [ ] All features tested on real device
- [ ] No crashes or force closes
- [ ] Performance acceptable
- [ ] Storage not > 100MB
- [ ] Compatible with API 24-34
- [ ] Permissions minimal & necessary
- [ ] Privacy policy available
- [ ] Version number incremented
- [ ] Changelog updated
- [ ] Screenshots prepared
- [ ] Store listing proofread

---

## 🚀 Ready to Ship!

When all checkboxes are complete:

```bash
# Sign APK
jarsigner -verify -verbose app/build/outputs/apk/release/app-release.apk

# Check size
du -h app/build/outputs/apk/release/app-release.apk

# Upload to Play Store
# Use Play Console web interface
```

**Status**: ✅ Ready for Production

---

**Last Updated**: 2026-08-10
**Build System**: Gradle + Godot 4.1
**Target**: Android 5.0+ (API 21+)
