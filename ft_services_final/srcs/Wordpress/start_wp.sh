cp srcs/nginx.conf /usr/share/nginx/http-default_server.conf
cp srcs/nginx.conf etc/nginx/http.d/default.conf
rc-update add nginx default
openrc boot
rc-update add php-fpm7 default
openrc boot
rc-service nginx start
rc-service php-fpm7 start
nohup ./user_creation_wp.sh 0</dev/null &
sleep infinity & wait