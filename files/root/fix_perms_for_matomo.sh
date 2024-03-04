#!/bin/bash

chown -R www-data:www-data /var/www/html/matomo
find /var/www/html/matomo/tmp -type f -exec chmod 644 {} \;
find /var/www/html/matomo/tmp -type d -exec chmod 755 {} \;
find /var/www/html/matomo/tmp/assets/ -type f -exec chmod 644 {} \;
find /var/www/html/matomo/tmp/assets/ -type d -exec chmod 755 {} \;
find /var/www/html/matomo/tmp/cache/ -type f -exec chmod 644 {} \;
find /var/www/html/matomo/tmp/cache/ -type d -exec chmod 755 {} \;
find /var/www/html/matomo/tmp/logs/ -type f -exec chmod 644 {} \;
find /var/www/html/matomo/tmp/logs/ -type d -exec chmod 755 {} \;
find /var/www/html/matomo/tmp/tcpdf/ -type f -exec chmod 644 {} \;
find /var/www/html/matomo/tmp/tcpdf/ -type d -exec chmod 755 {} \;
find /var/www/html/matomo/tmp/templates_c -type f -exec chmod 644 {} \;
find /var/www/html/matomo/tmp/templates_c -type d -exec chmod 755 {} \;

