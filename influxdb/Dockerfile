FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget influxdb openssl
RUN apk add telegraf

COPY create_influxdb_db.sh .
COPY telegraf.conf /etc/
COPY start_influxdb.sh start_influxdb.sh

RUN chmod +x create_influxdb_db.sh
RUN chmod +x start_influxdb.sh

#Create ssl key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/nginx.key.pem -out \
/etc/ssl/nginx.crt.pem -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=percevallechat/CN=bebechat"

ENTRYPOINT bash start_influxdb.sh