FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

ENV AUTOINDEX=on

RUN apk update && apk upgrade && apk add --no-cache bash wget openrc vsftpd openssl db-doc db db-utils

# create ssl key
RUN mkdir /etc/vsftpd/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/vsftpd/ssl/vsftpd.key -out \
/etc/vsftpd/ssl/vsftpd.crt -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=percevallechat/CN=bebechat"
RUN chown root:root /etc/vsftpd/ssl/vsftpd.crt && chmod 600 /etc/vsftpd/ssl/vsftpd.crt
RUN chown root:root /etc/vsftpd/ssl/vsftpd.key && chmod 600 /etc/vsftpd/ssl/vsftpd.key

RUN mkdir -p /srv/ftp && mkdir -p /etc/vsftpd/vsftpd_user_conf && mkdir -p var/run/vsftpd

COPY percevallechat.conf etc/vsftpd/vsftpd_user_conf
COPY vsftpd.conf etc/vsftpd/vsftpd.conf
COPY chroot.list /etc/vsftpd/
COPY vsftpd.user_list /etc/
RUN touch etc/pam.d/vsftpd
COPY start_vsftpd.sh start_vsftpd.sh

RUN chmod +x start_vsftpd.sh
RUN chmod 600 etc/vsftpd.user_list

RUN adduser percevallechat -D && echo -e "password\npassword" | passwd percevallechat

ENTRYPOINT bash start_vsftpd.sh