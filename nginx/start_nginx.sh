#!/bin/sh
mv srcs/nginx.conf /etc/nginx/nginx.conf
rc-update add nginx default
openrc boot
rc-service nginx start
sleep infinity & wait