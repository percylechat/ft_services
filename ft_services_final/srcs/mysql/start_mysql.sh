#!/bin/sh
/usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql"
nohup mysqld -u root 0</dev/null &
./create_mysql_db.sh
sleep infinity & wait