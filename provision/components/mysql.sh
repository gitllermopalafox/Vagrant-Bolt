#!/bin/bash

echo "Installing MySQL"
echo "mysql-server mysql-server/root_password password $1" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $1" | debconf-set-selections

apt-get -y install mysql-server > /dev/null 2>&1

echo "Creating Database"

if [ ! -f /var/log/databasesetup ];
then
    echo "CREATE USER 'bolt'@'localhost' IDENTIFIED BY 'bolt'" | mysql -uroot -p$1
    echo "CREATE DATABASE bolt" | mysql -uroot -p$1
    echo "GRANT ALL ON bolt.* TO 'bolt'@'localhost'" | mysql -uroot -p$1
    echo "flush privileges" | mysql -uroot -p$1

    touch /var/log/databasesetup

fi
