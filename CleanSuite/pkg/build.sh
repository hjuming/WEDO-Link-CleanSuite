#!/bin/bash

set -e

echo "🚀 CleanSuite v1.2 — Building macOS Installer (PKG)..."

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
APP_NAME="CleanSuite.app"
CLI_NAME="cleansuite"

# Clean & recreate build folder
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/root/usr/local/bin"
mkdir -p "$BUILD_DIR/root/Applications"
mkdir -p "$BUILD_DIR/root/Library/LaunchAgents"

echo "📁 Build structure prepared."

# Copy App bundle
if [ -d "$PROJECT_ROOT/CleanSuiteApp/$APP_NAME" ]; then
    cp -R "$PROJECT_ROOT/CleanSuiteApp/$APP_NAME" "$BUILD_DIR/root/Applications/"
    echo "📦 Copied $APP_NAME"
else
    echo "❌ ERROR: $APP_NAME not found at CleanSuiteApp/"
    exit 1
fi

# Copy CLI (compiled binary expected)
if [ -f "$PROJECT_ROOT/CLI/$CLI_NAME" ]; then
    cp "$PROJECT_ROOT/CLI/$CLI_NAME" "$BUILD_DIR/root/usr/local/bin/"
    chmod +x "$BUILD_DIR/root/usr/local/bin/$CLI_NAME"
    echo "🔧 Copied CLI → /usr/local/bin/$CLI_NAME"
else
    echo "⚠️ WARNING: CLI binary not found. App will install without CLI."
fi

# LaunchAgents (optional)
LAUNCH_AGENTS_SRC="$PROJECT_ROOT/pkg/LaunchAgents"
if [ -d "$LAUNCH_AGENTS_SRC" ]; then
    cp "$LAUNCH_AGENTS_SRC"/*.plist "$BUILD_DIR/root/Library/LaunchAgents/" 2>/dev/null || true
    echo "🧩 LaunchAgents copied."
else
    echo "ℹ️ No LaunchAgents found, skipping."
fi

# Distribution.xml
DIST_XML="$PROJECT_ROOT/pkg/distribution.xml"
if [ ! -f "$DIST_XML" ]; then
cat > "$DIST_XML" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<installer-gui-script minSpecVersion="1">
  <title>CleanSuite v1.2</title>
  <domains enable_anywhere="true"/>
  <options customize="never" require-scripts="false"/>
  <pkg-ref id="com.wedo.cleansuite"/>
  <pkg-ref id="com.wedo.cleansuite" version="1.2" onConclusion="none">CleanSuite.pkg</pkg-ref>
</installer-gui-script>
EOF
echo "📝 Created distribution.xml"
fi

# Build component package
echo "📦 Building component PKG..."
pkgbuild \
  --root "$BUILD_DIR/root" \
  --identifier "com.wedo.cleansuite" \
  --version "1.2.0" \
  --install-location "/" \
  "$BUILD_DIR/CleanSuite.pkg"

# Build final installer
echo "📦 Building final installer (productbuild)..."
productbuild \
  --distribution "$DIST_XML" \
  --package-path "$BUILD_DIR" \
  "$BUILD_DIR/CleanSuite-v1.2.0.pkg"

echo "🎉 Build complete!"
echo "📍 Output: $BUILD_DIR/CleanSuite-v1.2.0.pkg"
