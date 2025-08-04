#!/bin/bash
# stop si une erreur se produit
set -e

# Wait for MariaDB to be ready
until mysqladmin ping -h mariadb -u ${SQL_USER} -p${SQL_PASSWORD} --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Configure WordPress if not already done
if [ ! -e /var/www/wordpress/wp-config.php ]; then
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'

    wp core install --allow-root \
        --url=https://$DOMAIN_NAME \
        --title="$SITE_TITLE" \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --path='/var/www/wordpress'

    wp user create $USER1_LOGIN $USER1_MAIL \
        --allow-root \
        --role=author \
        --user_pass=$USER1_PASS \
        --path='/var/www/wordpress'
fi

# Create PHP-FPM run directory
mkdir -p /run/php
chown -R www-data:www-data /run/php

# Start PHP-FPM
exec /usr/sbin/php-fpm7.4 -F