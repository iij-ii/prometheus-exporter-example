FROM prom/prometheus

ADD dist-newstyle/build/x86_64-linux/ghc-8.6.5/prometheus-exporter-0.1.0.0/x/prometheus-exporter/build/prometheus-exporter/prometheus-exporter /bin

ADD ./prometheus.yml /etc/prometheus/prometheus.yml

ADD ./run-both.sh /bin/

ENTRYPOINT ["sh", "/bin/run-both.sh"]
