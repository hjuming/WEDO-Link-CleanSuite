#!/bin/bash

APP_NAME="Wedo Link CleanSuite"
BUILD_DIR="build"
PKG_DIR="pkg"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
PKG_NAME="$PKG_DIR/$APP_NAME.pkg"

mkdir -p "$PKG_DIR"

# Build first
./scripts/build.sh

# Create PKG
pkgbuild --root "$APP_BUNDLE" \
         --identifier "com.wedo.cleansuite" \
         --version "1.0" \
         --install-location "/Applications/$APP_NAME.app" \
         "$PKG_NAME"

echo "Package Created: $PKG_NAME"
