#!/bin/bash

set -e

echo ImageBuilder 

make info || sh -c ./setup.sh && make info

echo Config
echo "* Debug=$DEBUG"
echo "* PROFILE=$PROFILE"
echo "* FILES=$FILES"
echo "* PACKAGES=$PACKAGES"

if [[ "$(pwd)" != "/builder" ]]; then
  echo This action assumes that the imagebuilder docker image default folder is '/builder' but found:
  pwd
  exit -1
fi

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

sed -f config.sed -i .config

make image \
  PROFILE="$PROFILE" \
  FILES="$FILES" \
  PACKAGES="$PACKAGES"

mkdir bin/target/

echo Remove prefix...
ls -lah bin/targets/*/*/openwrt-*

for file in bin/targets/*/*/openwrt-*.gz
do 
  # TODO There might be a bug with the "openwrt-*-*-*-" pattern if not all profile match this format
  mv  -v "$file" "bin/${file#bin/targets/*/*/openwrt-*-*-*-}"
done

echo Cleanup...
ls -lah bin/targets/*/*/*

mv -v bin/targets/*/*/* bin
rm -rf bin/targets

echo Done:
ls -lah bin/
