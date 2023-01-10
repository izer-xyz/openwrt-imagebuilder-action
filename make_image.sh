#!/bin/bash

if [ "$DEBUG" -eq "1" ]; then
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
