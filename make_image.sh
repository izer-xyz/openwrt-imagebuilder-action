#!/bin/bash

#set
sed -e '/^CONFIG_TARGET_ROOTFS_EXT4FS/ s/^#*/#/' -i .config

cat .config

ls -la files

make image FILES="$FILES" PACKAGES="$PACKAGES" DISABLED_SERVICES="$DISABLED_SERVICES"
