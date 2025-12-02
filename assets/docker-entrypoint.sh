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


# Set Apache DocumentRoot to public directory
sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf
sed -i 's|<Directory /var/www/html>|<Directory /var/www/html/public>|g' /etc/apache2/apache2.conf

# Update AllowOverride if needed for .htaccess
sed -i '/<Directory \/var\/www\/html\/public>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf


# Start Apache

apache2-foreground
