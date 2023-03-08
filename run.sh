#!/bin/bash
docker volume create grafana-storage
docker run -d -p 3000:3000 \
  --name=grafana \
  -e "GF_AUTH_SIGV4_AUTH_ENABLED=true" \
  -v $(pwd)/datasources/:/etc/grafana/provisioning/datasources/ \
  -v $(pwd)/dashboard.yaml:/etc/grafana/provisioning/dashboards/dashboard.yaml \
  -v $(pwd)/dashboards/:/var/lib/grafana/dashboards/ \
  -v grafana-storage:/var/lib/grafana \
  grafana/grafana-oss

# this will work on macOS
sleep 1
#open http://localhost:3000
open http://localhost:3000/d/GvbFsqKVk/coiled-cluster-metrics-basic
