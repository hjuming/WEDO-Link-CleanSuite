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

# Compile Assets (AppIcon)
if [ -d "AppIcon.xcassets" ]; then
    echo "Compiling Assets..."
    /usr/bin/xcrun actool "AppIcon.xcassets" --compile "$APP_BUNDLE/Contents/Resources" --platform macosx --minimum-deployment-target 13.0 --app-icon AppIcon --output-partial-info-plist /tmp/assetcatalog_generated_info.plist
fi

# Copy Resources (Icons)
if [ -f "assets/icons/AppIcon.icns" ]; then
    cp "assets/icons/AppIcon.icns" "$APP_BUNDLE/Contents/Resources/AppIcon.icns"
fi
# Copy all PNG icons
cp assets/icons/*.png "$APP_BUNDLE/Contents/Resources/"

echo "Build Complete: $APP_BUNDLE"
