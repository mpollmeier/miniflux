#!/bin/bash

# default Dockerfile only works with docker-compose
# see https://github.com/miniflux/miniflux/pull/592

service cron start

mkdir -p /var/www/html/data/favicons
chown -R www-data:www-data /var/www/html/data
#/usr/sbin/apache2ctl -D FOREGROUND 
service apache2 start
tail -f /var/log/apache2/error.log

