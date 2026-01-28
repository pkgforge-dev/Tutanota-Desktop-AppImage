#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

PRE_BUILD_CMDS='sed -i "s/sha256sums=(\*/sha256sums=('SKIP'/g" ./PKGBUILD' make-aur-package tutanota-desktop
