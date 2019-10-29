#!/bin/sh

/bin/prometheus-exporter &

# The arguments to prometheus is according to https://github.com/prometheus/prometheus/blob/e0443e6fa38d6f309b4d91e53233b7c1f705d3ac/Dockerfile

/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --web.console.libraries=/usr/share/prometheus/console_libraries \
  --web.console.templates=/usr/share/prometheus/consoles
