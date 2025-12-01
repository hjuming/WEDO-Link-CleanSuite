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
# Build the component package
pkgbuild --root build/root --identifier com.wedo.cleansuite --version 1.0.0 --install-location / build/WEDO-Link-CleanSuite-Component.pkg

# Prepare resources
mkdir -p build/resources
cp assets/icons/installer-icon.png build/resources/background.png
cp scripts/welcome.html build/resources/welcome.html
cp scripts/distribution.xml build/distribution.xml

# Build the product archive
productbuild --distribution build/distribution.xml --resources build/resources --package-path build build/WEDO-Link-CleanSuite.pkg

echo "Package Created: build/WEDO-Link-CleanSuite.pkg"
