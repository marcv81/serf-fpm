#!/bin/sh

TIMESTAMP=`date +%s`
TYPES="rpm deb"

# Download sources
if [ ! -f rootfs/usr/bin/serf ]
then
  mkdir -p rootfs/usr/bin
  echo "Downloading sources..."
  wget -qO- https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip | funzip > rootfs/usr/bin/serf
  chmod 0755 rootfs/usr/bin/serf
fi

# Delete existing packages
for TYPE in $TYPES
do
  rm *."$TYPE" -f
done

# Create package
for TYPE in $TYPES
do
  echo "Creating $TYPE package..."
  fpm -s dir -t $TYPE -C rootfs -n serf -v 0.6.4 \
  --iteration $TIMESTAMP --epoch $TIMESTAMP \
  --after-install meta/after-install.sh \
  --before-remove meta/before-remove.sh \
  --after-remove meta/after-remove.sh
done
