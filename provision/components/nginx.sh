#!/bin/bash

echo "Installing Nginx"
apt-get install nginx -y > /dev/null 2>&1

echo "Configuring Nginx"
cat << EOF > "/var/www/provision/config/nginx_vhost"
server {
    listen 80;
    server_name localhost;

    root /var/www/src/bolt;
    index index.php index.html;

    # Important for VirtualBox
    sendfile off;

    # The main Bolt website
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    # Generated thumbnail images
    location ~* /thumbs/(.*)$ {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    # Bolt backend access
    #
    # NOTE: If you set a custom branding path, you will need to change '/bolt/'
    #       here to match
    location ~* /bolt/(.*)$ {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    # Enforce caching for certain file extension types
    location ~* \.(?:ico|css|js|gif|jpe?g|png|ttf|woff|woff2)$ {
        access_log off;
        expires 30d;
        add_header Pragma public;
        add_header Cache-Control "public, mustrevalidate, proxy-revalidate";
    }

    # Don't create logs for favicon.ico or robots.txt requests
    location = /(?:favicon.ico|robots.txt) {
        access_log off;
        log_not_found off;
    }

    # Block PHP files from being run in upload (files), app, theme and extension directories
    location ~* /(?:app|extensions|files|theme)/(.*)\.php$ {
        deny all;
    }

    # Block access to Sqlite database files, Apache .htaccess & .htpasswd files
    location ~ \.(?:db|htaccess|htpasswd)$ {
        deny all;
    }

    # Block access to the app, cache & vendor directories
    location ~ /(?:app|src|tests|vendor) {
        deny all;
    }

    # Block access to Markdown, Twig & YAML files directly
    location ~* /(.*)\.(?:markdown|md|twig|yaml|yml)$ {
        deny all;
    }


    location /phpmyadmin {
       root /usr/share/;
       index index.php index.html index.htm;
       location ~ ^/phpmyadmin/(.+\.php)$ {
           try_files \$uri =404;
           root /usr/share/;
           fastcgi_pass unix:/var/run/php5-fpm.sock;
           fastcgi_index index.php;
           fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
           include /etc/nginx/fastcgi_params;
       }
       location ~* ^/phpmyadmin/(.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt))$ {
           root /usr/share/;
       }
    }

    location ~* \.php {
        include fastcgi_params;

        fastcgi_pass unix:/var/run/php5-fpm.sock;

        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_cache off;
        fastcgi_index index.php;
    }

}
EOF

cp /var/www/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost > /dev/null 2>&1
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/ > /dev/null 2>&1
rm -rf /etc/nginx/sites-available/default > /dev/null 2>&1
