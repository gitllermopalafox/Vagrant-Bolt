#!/bin/bash

echo "Installing and configuring Composer"
mkdir /opt/composer > /dev/null 2>&1
cd /opt/composer > /dev/null 2>&1
curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1
mv /opt/composer/composer.phar /usr/local/bin/composer > /dev/null 2>&1