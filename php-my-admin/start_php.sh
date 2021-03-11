#!/bin/sh
rm -rf ./etc/nginx/http.d/default.conf
rc-update add php-fpm7 default
openrc boot
rc-update add nginx default
openrc boot
rc-service php-fpm7 start
rc-service nginx start
sleep infinity & wait