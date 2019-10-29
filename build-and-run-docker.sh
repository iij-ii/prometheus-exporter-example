#!/bin/bash

set -eu

cabal --with-ghc=`stack exec which ghc` build --enable-executable-static

docker build -t iijii/prometheus-exporter .

docker run --name prometheus-exporter -p 9090:9090 -p 8080:8080 iijii/prometheus-exporter
