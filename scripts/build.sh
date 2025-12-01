#!/bin/bash
set -e

echo "📦 Building CleanSuite macOS App..."

xcodebuild -project CleanSuite/CleanSuite.xcodeproj \
  -scheme CleanSuite \
  -configuration Release \
  build

echo "🔐 Ad-hoc signing..."
codesign --force --deep --sign - "CleanSuite/build/Release/CleanSuite.app"

echo "📦 Building PKG..."
pkgbuild \
  --install-location /Applications \
  --component CleanSuite/build/Release/CleanSuite.app \
  build/CleanSuite.pkg

echo "✅ Build complete: build/CleanSuite.pkg"
