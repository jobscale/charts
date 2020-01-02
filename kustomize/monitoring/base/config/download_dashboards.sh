#!/usr/bin/env sh
set -euf
curl -skf \
--connect-timeout 60 \
--max-time 60 \
-H "Accept: application/json" \
-H "Content-Type: application/json;charset=UTF-8" \
  https://grafana.com/api/dashboards/10000/revisions/1/download| sed 's|\"datasource\":[^,]*|\"datasource\": \"Prometheus\"|g'\
> /var/lib/grafana/dashboards/default/cluster-stats.json
curl -skf \
--connect-timeout 60 \
--max-time 60 \
-H "Accept: application/json" \
-H "Content-Type: application/json;charset=UTF-8" \
  https://grafana.com/api/dashboards/8588/revisions/1/download| sed 's|\"datasource\":[^,]*|\"datasource\": \"Prometheus\"|g'\
> /var/lib/grafana/dashboards/default/deployment-stats.json
curl -skf \
--connect-timeout 60 \
--max-time 60 \
-H "Accept: application/json" \
-H "Content-Type: application/json;charset=UTF-8" \
  https://grafana.com/api/dashboards/6417/revisions/1/download| sed 's|\"datasource\":[^,]*|\"datasource\": \"Prometheus\"|g'\
> /var/lib/grafana/dashboards/default/k8s-monitoring.json
curl -skf \
--connect-timeout 60 \
--max-time 60 \
-H "Accept: application/json" \
-H "Content-Type: application/json;charset=UTF-8" \
  https://grafana.com/api/dashboards/2/revisions/2/download| sed 's|\"datasource\":[^,]*|\"datasource\": \"Prometheus\"|g'\
> /var/lib/grafana/dashboards/default/prometheus-stats.json
