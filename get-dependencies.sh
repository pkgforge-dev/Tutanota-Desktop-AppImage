#!/bin/sh

set -eu

ARCH=$(uname -m)

pacman -Syu --noconfirm sqlcipher

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ! llvm-libs

PRE_BUILD_CMDS='sed -i "s/sha256sums=(\*/sha256sums=('SKIP'/g" ./PKGBUILD' make-aur-package tutanota-desktop
