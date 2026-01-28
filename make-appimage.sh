#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q tutanota-desktop | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook:fix-namespaces.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/512x512/apps/tutanota-desktop.png
export DESKTOP=/usr/share/applications/tutanota-desktop.desktop
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1

# Deploy dependencies
mkdir -p ./AppDir/bin
cp -rv /opt/tutanota-desktop/* ./AppDir/bin/
quick-sharun ./AppDir/bin/* \
             /usr/lib/libsecret* \
             /usr/lib/libsqlcipher*

# This is hardcoded to look into /usr/bin/ldd and causes a crash
# looks like we only need to patch this path away, it seems to work without it
sed -i -e 's|/usr/bin/ldd|/XXX/YYY/ZZZ|g' ./AppDir/bin/resources/app.asar

# Turn AppDir into AppImage
quick-sharun --make-appimage
