#!/bin/bash

# Naruto RPG Godot - Build APK Script
# Script untuk automated build APK

set -e  # Exit on error

echo "=================================="
echo "Naruto RPG Godot - APK Builder"
echo "=================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check requirements
echo -e "${YELLOW}[1/5] Checking requirements...${NC}"

if ! command -v java &> /dev/null; then
    echo -e "${RED}✗ Java not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Java found: $(java -version 2>&1 | head -1)${NC}"

if [ -z "$ANDROID_SDK_ROOT" ]; then
    echo -e "${RED}✗ ANDROID_SDK_ROOT not set${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Android SDK: $ANDROID_SDK_ROOT${NC}"

if [ -z "$ANDROID_NDK_ROOT" ]; then
    echo -e "${RED}✗ ANDROID_NDK_ROOT not set${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Android NDK: $ANDROID_NDK_ROOT${NC}"

# Build type
echo ""
echo -e "${YELLOW}[2/5] Select build type:${NC}"
echo "1) Debug APK (testing)"
echo "2) Release APK (production)"
read -p "Choose (1-2): " BUILD_TYPE

case $BUILD_TYPE in
    1)
        BUILD_MODE="debug"
        echo -e "${GREEN}Building Debug APK${NC}"
        ;;
    2)
        BUILD_MODE="release"
        echo -e "${GREEN}Building Release APK${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

# Check android folder
echo ""
echo -e "${YELLOW}[3/5] Checking Android folder...${NC}"

if [ ! -d "android" ]; then
    echo -e "${RED}✗ android/ folder not found${NC}"
    echo "Export project from Godot first:"
    echo "  Project → Export → Android → Export Project"
    exit 1
fi

if [ ! -f "android/gradlew" ]; then
    echo -e "${RED}✗ gradlew not found${NC}"
    exit 1
fi

chmod +x android/gradlew
echo -e "${GREEN}✓ Gradle wrapper found${NC}"

# Clean build
echo ""
echo -e "${YELLOW}[4/5] Building APK...${NC}"

cd android

# Clean
echo "Cleaning..."
./gradlew clean

# Assemble
if [ "$BUILD_MODE" = "debug" ]; then
    echo "Building debug APK..."
    ./gradlew assembleDebug
    APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
else
    echo "Building release APK..."
    ./gradlew assembleRelease
    APK_PATH="app/build/outputs/apk/release/app-release.apk"
fi

cd ..

# Check output
echo ""
echo -e "${YELLOW}[5/5] Finalizing...${NC}"

if [ -f "$APK_PATH" ]; then
    SIZE=$(du -h "$APK_PATH" | cut -f1)
    echo -e "${GREEN}✓ Build successful!${NC}"
    echo ""
    echo "📦 APK Details:"
    echo "  Path: $(pwd)/$APK_PATH"
    echo "  Size: $SIZE"
    echo "  Type: $BUILD_MODE"
    echo ""
    
    # Optional: Install to device
    read -p "Install to connected device? (y/n): " INSTALL
    if [ "$INSTALL" = "y" ]; then
        if ! command -v adb &> /dev/null; then
            echo -e "${YELLOW}⚠ ADB not found${NC}"
        else
            DEVICES=$(adb devices | grep -v "List" | grep "device$" | wc -l)
            if [ "$DEVICES" -eq 0 ]; then
                echo -e "${YELLOW}⚠ No devices connected${NC}"
            else
                echo "Installing APK..."
                adb install -r "$APK_PATH"
                echo -e "${GREEN}✓ APK installed${NC}"
                echo ""
                echo "To open app:"
                echo "  adb shell am start -n com.narutorpg.game/.MainActivity"
            fi
        fi
    fi
else
    echo -e "${RED}✗ Build failed${NC}"
    exit 1
fi

echo ""
echo "Done! 🎉"
