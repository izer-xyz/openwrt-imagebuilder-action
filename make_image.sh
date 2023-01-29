#!/bin/bash

if [[ "$DEBUG" == "1" ]]; then
  set
  cat .config
  ls -la files
fi

sed \
  -e '/^CONFIG_TARGET_ROOTFS_EXT4FS/ s/^#*/#/' \
  -i .config
  
make image \
  FILES="$FILES" \
  PACKAGES="$PACKAGES" \
  DISABLED_SERVICES="$DISABLED_SERVICES" \
  EXTRA_IMAGE_NAME="$EXTRA_IMAGE_NAME"

mkdir bin/target/

for file in bin/targets/*/*/openwrt-*
do 
  ln -s  "$file" "bin/target/${file#bin/targets/*/*/openwrt-*-*-*-}"
done
