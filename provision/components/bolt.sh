#!/bin/bash

DIRBOLT="/var/www/src/bolt"

echo "Installing Bolt (This take a while)"
mkdir $DIRBOLT
cd $DIRBOLT
curl -O http://bolt.cm/distribution/bolt-latest.tar.gz > /dev/null 2>&1
tar -xzf bolt-latest.tar.gz --strip-components=1 > /dev/null 2>&1
cp /var/www/provision/config/config.yml $DIRBOLT/app/config/ > /dev/null 2>&1
chmod -R 777 files/ app/database/ app/cache/ app/config/ theme/ extensions/ > /dev/null 2>&1
