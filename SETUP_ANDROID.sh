#!/bin/bash

# Naruto RPG Godot - Android Setup Script
# Script untuk setup environment Android Godot

echo "======================================"
echo "Naruto RPG Godot - Android Setup"
echo "======================================"

# Check if Java is installed
echo "Checking Java..."
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -1)
    echo "✓ Java found: $JAVA_VERSION"
else
    echo "✗ Java not found. Please install Java 11+"
    exit 1
fi

# Check if Android SDK exists
if [ -z "$ANDROID_SDK_ROOT" ]; then
    echo "Setting ANDROID_SDK_ROOT..."
    if [ -d "$HOME/Android/Sdk" ]; then
        export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
        echo "✓ Found Android SDK at: $ANDROID_SDK_ROOT"
    else
        echo "✗ Android SDK not found. Download from:"
        echo "  https://developer.android.com/studio"
        exit 1
    fi
fi

# Check if NDK exists
if [ -z "$ANDROID_NDK_ROOT" ]; then
    echo "Looking for Android NDK..."
    NDK_PATH=$(find $ANDROID_SDK_ROOT/ndk -maxdepth 1 -type d | head -1)
    if [ -n "$NDK_PATH" ]; then
        export ANDROID_NDK_ROOT="$NDK_PATH"
        echo "✓ Found Android NDK at: $ANDROID_NDK_ROOT"
    else
        echo "✗ Android NDK not found. Download via SDK Manager"
        exit 1
    fi
fi

# Check Gradle
echo "Checking Gradle..."
if [ -f "android/gradlew" ]; then
    chmod +x android/gradlew
    GRADLE_VERSION=$(./android/gradlew --version 2>&1 | head -1)
    echo "✓ Gradle found: $GRADLE_VERSION"
else
    echo "✗ Gradle not found in android/"
fi

echo ""
echo "======================================"
echo "Setup Complete!"
echo "======================================"
echo ""
echo "Export Presets:"
echo "  ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT"
echo "  ANDROID_NDK_ROOT=$ANDROID_NDK_ROOT"
echo ""
echo "Next steps:"
echo "1. Open Godot"
echo "2. Project → Project Settings → Export"
echo "3. Add Android preset"
echo "4. Configure paths above"
echo "5. Build APK!"
echo ""
