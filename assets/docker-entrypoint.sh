#!/bin/bash
# -----------------------------------------------------------------------------
# Plainpad - Self Hosted Note Taking App
#
# @package     Plainpad
# @author      A.Tselegidis <alextselegidis@gmail.com>
# @copyright   Copyright (c) Alex Tselegidis
# @license     https://opensource.org/licenses/GPL-3.0 - GPLv3
# @link        https://plainpad.org
# -----------------------------------------------------------------------------

# Copy .env.example to .env if .env doesn't exist
if [ ! -f /var/www/html/.env ]; then
    cp /var/www/html/.env.example /var/www/html/.env
fi

# Apply environment variables to .env file
if [ -n "$BASE_URL" ]; then
    sed -i "s|APP_URL=.*|APP_URL=${BASE_URL}|g" /var/www/html/.env
fi
if [ -n "$DEBUG_MODE" ]; then
    if [ "$DEBUG_MODE" = "TRUE" ] || [ "$DEBUG_MODE" = "true" ]; then
        sed -i "s|APP_DEBUG=.*|APP_DEBUG=true|g" /var/www/html/.env
    else
        sed -i "s|APP_DEBUG=.*|APP_DEBUG=false|g" /var/www/html/.env
    fi
fi
if [ -n "$DB_HOST" ]; then
    sed -i "s|DB_HOST=.*|DB_HOST=${DB_HOST}|g" /var/www/html/.env
fi
if [ -n "$DB_NAME" ]; then
    sed -i "s|DB_DATABASE=.*|DB_DATABASE=${DB_NAME}|g" /var/www/html/.env
fi
if [ -n "$DB_USERNAME" ]; then
    sed -i "s|DB_USERNAME=.*|DB_USERNAME=${DB_USERNAME}|g" /var/www/html/.env
fi
if [ -n "$DB_PASSWORD" ]; then
    sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=${DB_PASSWORD}|g" /var/www/html/.env
fi

# Generate APP_KEY if not set
if grep -q "APP_KEY=$" /var/www/html/.env || grep -q "APP_KEY={KEY}" /var/www/html/.env; then
    cd /var/www/html && php artisan key:generate --force
fi

chown www-data:www-data /var/www/html/.env

# Add mod_setenvif snippet to .htaccess if not already present
if [ -f /var/www/html/public/.htaccess ]; then
    if ! grep -q "SetEnvIf Authorization" /var/www/html/public/.htaccess; then
        HTACCESS_SNIPPET='<IfModule mod_setenvif.c>
    SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1
</IfModule>
'
        echo "$HTACCESS_SNIPPET" | cat - /var/www/html/public/.htaccess > /tmp/.htaccess.tmp
        mv /tmp/.htaccess.tmp /var/www/html/public/.htaccess
        chown www-data:www-data /var/www/html/public/.htaccess
    fi
fi

# Set Apache DocumentRoot to public directory (only if not already set)
if ! grep -q "DocumentRoot /var/www/html/public" /etc/apache2/sites-available/000-default.conf; then
    sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
fi

# Add Directory directive for /var/www/html/public with AllowOverride All (only if not already set)
if ! grep -q "<Directory /var/www/html/public>" /etc/apache2/apache2.conf; then
    cat >> /etc/apache2/apache2.conf << 'APACHECONF'
<Directory /var/www/html/public>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
APACHECONF
fi
# Start Apache
apache2-foreground
