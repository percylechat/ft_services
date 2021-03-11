#!/bin/sh
nohup telegraf --config /etc/telegraf.conf 0</dev/random &
nohup influxd 0</dev/null &
./create_influxdb_db.sh
sleep infinity & wait