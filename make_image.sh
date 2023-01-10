#!/bin/bash

#set
#cat .config
#ls -la files

#sed \
#  -e '/^CONFIG_TARGET_ROOTFS_EXT4FS/ s/^#*/#/' \
#  -i .config
  
echo CONFIG_TARGET_ROOTFS_INITRAMFS=y >> .config
  
make image \
  FILES="$FILES" \
  PACKAGES="$PACKAGES" \
  DISABLED_SERVICES="$DISABLED_SERVICES" \
  EXTRA_IMAGE_NAME="$EXTRA_IMAGE_NAME"
