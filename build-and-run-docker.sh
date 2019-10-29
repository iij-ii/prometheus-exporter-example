#!/bin/bash

set -eu

docker build -t iijii/prometheus-exporter .

docker run --name prometheus-exporter -p 9090:9090 -p 8080:8080 iijii/prometheus-exporter
