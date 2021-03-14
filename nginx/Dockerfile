FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget nginx openssl curl

RUN mkdir srcs
COPY nginx.conf /srcs/nginx.conf

#Create ssl key
RUN cd /etc/nginx/ && mkdir ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out \
/etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=percevallechat/CN=bebechat"

COPY start_nginx.sh start_nginx.sh
RUN chmod +x start_nginx.sh

ENTRYPOINT bash start_nginx.sh