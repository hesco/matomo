#!/usr/bin/env bash


echo "Making sure www folder has the right permissions."
sleep 10

chown -R apache:apache ${docroot}/matomo
chmod -R 0755 ${docroot}/matomo/tmp
chmod -R 0755 ${docroot}/matomo/tmp/assets
chmod -R 0755 ${docroot}/matomo/tmp/cache
chmod -R 0755 ${docroot}/matomo/tmp/logs
chmod -R 0755 ${docroot}/matomo/tmp/tcpdf
chmod -R 0755 ${docroot}/matomo/tmp/templates_c
echo "alex" >> /tmp/alex.txt
echo "...done!"
