FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

#install
RUN apk update && apk upgrade && apk add --no-cache bash openrc wget openssl php7 php7-fpm php7-opcache nginx curl
RUN apk add --no-cache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring

RUN mkdir -p /var/www/html
RUN cd /var/www/html && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz \
&& tar -xvzf phpMyAdmin-5.0.4-english.tar.gz && mv phpMyAdmin-5.0.4-english phpmyadmin && rm phpMyAdmin-5.0.4-english.tar.gz

RUN apk add --no-cache phpmyadmin

#delete obsolete config files
RUN rm -rf /usr/share/phpmyadmin/config.sample.inc.php
RUN rm -rf /var/www/html/phpmyadmin/config.sample.inc.php
RUN rm -rf /etc/php7/php-fpm.conf
RUN rm -rf /etc/php7/php-fpm.d/www.conf

#copy proper config files
COPY config.inc.php /usr/share/phpmyadmin/config.inc.php
COPY config.inc.php /var/www/html/phpmyadmin/config.inc.php
COPY nginx.conf /etc/nginx/http.d/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf
COPY php.ini /etc/php7/php.ini
COPY start_php.sh start_php.sh

#Create ssl key
RUN cd /etc/nginx/ && mkdir ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out \
/etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=percevallechat/CN=bebechat"

RUN chmod +x start_php.sh

ENTRYPOINT ./start_php.sh