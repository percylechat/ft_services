FROM alpine:latest

# VOLUME ["/sys/fs/cgroup"]

#install
RUN apk update && apk upgrade && apk add --no-cache bash wget openrc openssl curl nginx php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-zlib php7-json php7-session php7-phar

#install wordpress
RUN mkdir /var/www/html
RUN cd /var/www/html/ && wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && touch .htaccess && chmod 660 .htaccess
RUN cd /var/www/html/wordpress/ && rm wp-config-sample.php
COPY wp-config.php /var/www/html/wordpress/
RUN cp -a /var/www/html/wordpress/. /var/www/html && cd /var/www/html && rm -rf wordpress
RUN cd /var/www/html/ && mkdir wp-content/upgrade
# RUN cd /var/www/html/ && chown -R root:www-data /var/www/html && find /var/www/html -type d -exec chmod g+s {} \; \
# && chmod g+w /var/www/html/wp-content && chmod -R g+w /var/www/html/wp-content/themes && chmod -R g+w /var/www/html/wp-content/plugins
# RUN cd /var/www/html/ && wget https://api.wordpress.org/secret-key/1.1/salt/
# RUN cd /var/www/html/ && rm index.html

#copy scripts and docs and change permissions
COPY nginx.conf srcs/nginx.conf
COPY user_creation_wp.sh .
COPY start_wp.sh start_wp.sh
RUN chmod +x user_creation_wp.sh
RUN chmod +x start_wp.sh

#Create ssl key
RUN cd /etc/nginx/ && mkdir ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out \
/etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=percevallechat/CN=bebechat"

#create wordpress users
RUN cd var/www/html && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN cd var/www/html && chmod +x wp-cli.phar && mv wp-cli.phar ../../../usr/local/bin/wp && wp cli update

#launch wordpress correctly
ENTRYPOINT bash start_wp.sh