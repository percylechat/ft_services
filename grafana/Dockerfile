
FROM alpine:latest

VOLUME ["/sys/fs/cgroup"]

RUN apk update && apk upgrade && apk add --no-cache bash openrc wget curl
RUN apk add grafana

# RUN rm etc/grafana.ini
# RUN rm etc/conf.d/grafana


COPY data.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY ftps.json /usr/share/grafana/conf/provisioning/dashboards/
COPY grafana.json /usr/share/grafana/conf/provisioning/dashboards/
COPY influxdb.json /usr/share/grafana/conf/provisioning/dashboards/
COPY mysql.json /usr/share/grafana/conf/provisioning/dashboards/
COPY nginx.json /usr/share/grafana/conf/provisioning/dashboards/
COPY php_my_admin.json /usr/share/grafana/conf/provisioning/dashboards/
COPY wordpress.json /usr/share/grafana/conf/provisioning/dashboards/

COPY grafana.ini grafana.ini
COPY grafana grafana
COPY start_grafana.sh start_grafana.sh

RUN chmod +x start_grafana.sh

ENTRYPOINT bash start_grafana.sh