#!/bin/bash

echo "Updating PHP repository"
apt-get install python-software-properties build-essential -y > /dev/null 2>&1
add-apt-repository ppa:ondrej/php5 -y > /dev/null 2>&1
apt-get update > /dev/null 2>&1

echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null 2>&1
 
echo "Installing PHP extensions"
apt-get install php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null 2>&1