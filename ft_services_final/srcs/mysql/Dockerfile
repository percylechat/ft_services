FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget
RUN apk add --no-cache mysql mariadb mariadb-backup mariadb-bench mariadb-client mariadb-common mariadb-dev mariadb-doc mariadb-embedded mariadb-embedded-dev mariadb-mytop mariadb-openrc mariadb-plugin-rocksdb mariadb-server-utils mariadb-static mariadb-test mysql-bench mysql-client

COPY my.cnf /etc/my.cnf
COPY create_mysql_db.sh .
COPY start_mysql.sh .

RUN chmod u+rwx /etc/my.cnf.d
RUN chmod +x create_mysql_db.sh
RUN chmod +x start_mysql.sh

ENTRYPOINT bash start_mysql.sh