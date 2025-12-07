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

for file in bin/targets/*/*/openwrt-*
do 
  # TODO There might be a bug with the "openwrt-*-*-*-" pattern if not all profile match this format
  mv  "$file" "bin/${file#bin/targets/*/*/openwrt-*-*-*-}"
done

mv bin/targets/*/*/* bin
rm -rf bin/targets

ls -lah bin/
