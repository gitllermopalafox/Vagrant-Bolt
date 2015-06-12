#!/bin/bash

echo "Installing PHPMyAdmin"
echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $1" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $1" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $1" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none" | debconf-set-selections
apt-get -y install phpmyadmin > /dev/null 2>&1