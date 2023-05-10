#!/bin/bash

if [[ "$DEBUG" == "1" ]]; then
  pwd
  echo ====== ./files ==
  ls -la $FILES
  echo ====== set ======
  set
  echo ====== .config ==
  cat .config
  echo ====== end ======
fi

sed \
  -e '/^CONFIG_TARGET_ROOTFS_EXT4FS/ s/^#*/#/' \
  -i .config
  
make image \
  FILES="$FILES" \
  PACKAGES="$PACKAGES" \
  DISABLED_SERVICES="$DISABLED_SERVICES"

mkdir bin/target/

for file in bin/targets/*/*/openwrt-*
do 
  # TODO There might be a bug with the "openwrt-*-*-*-" pattern if not all profile match this format
  mv  "$file" "bin/${file#bin/targets/*/*/openwrt-*-*-*-}"
done

mv bin/targets/*/*/* bin
rm -rf bin/targets

ls -lah bin/
