#!/bin/bash

APP_NAME="Wedo Link CleanSuite"
BUILD_DIR="build"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
SRC_DIR="src"

# Clean build dir
rm -rf "$BUILD_DIR"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# Compile Swift
swiftc \
    "$SRC_DIR/main.swift" \
    "$SRC_DIR/core/Config.swift" \
    "$SRC_DIR/core/Scheduler.swift" \
    "$SRC_DIR/core/AutoStart.swift" \
    "$SRC_DIR/core/Updater.swift" \
    "$SRC_DIR/core/CleanerCore.swift" \
    "$SRC_DIR/cleaners/QuickCleaner.swift" \
    "$SRC_DIR/cleaners/DeepCleaner.swift" \
    "$SRC_DIR/cleaners/MailCleaner.swift" \
    "$SRC_DIR/cleaners/BrowserCleaner.swift" \
    "$SRC_DIR/utils/Logger.swift" \
    "$SRC_DIR/utils/DiskUtils.swift" \
    -o "$APP_BUNDLE/Contents/MacOS/$APP_NAME"

# Copy Info.plist
cp scripts/Info.plist "$APP_BUNDLE/Contents/Info.plist"

# Copy Resources (Icons)
if [ -f "assets/icons/AppIcon.icns" ]; then
    cp "assets/icons/AppIcon.icns" "$APP_BUNDLE/Contents/Resources/AppIcon.icns"
fi
if [ -f "assets/icons/menubar_active.png" ]; then
    cp "assets/icons/menubar_active.png" "$APP_BUNDLE/Contents/Resources/menubar_active.png"
fi
if [ -f "assets/icons/menubar_inactive.png" ]; then
    cp "assets/icons/menubar_inactive.png" "$APP_BUNDLE/Contents/Resources/menubar_inactive.png"
fi

echo "Build Complete: $APP_BUNDLE"
