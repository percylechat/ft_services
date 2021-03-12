#!/bin/sh
rm etc/grafana.ini
rm etc/conf.d/grafana
cp grafana etc/conf.d/
cp grafana.ini usr/share/grafana/conf
nohup /usr/sbin/grafana-server --config=/usr/share/grafana/conf/grafana.ini --homepath=/usr/share/grafana 0</dev/null
sleep infinity & wait