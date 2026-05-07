FROM signoz/signoz-otel-collector:v0.144.2

COPY otel-collector-config.yaml /etc/otel-collector-config.yaml

ENV LOW_CARDINAL_EXCEPTION_GROUPING=false
ENV OTEL_RESOURCE_ATTRIBUTES=host.name=signoz-host,os.type=linux

EXPOSE 4317 4318 13133 1777

ENTRYPOINT ["/bin/sh", "-c", "/signoz-otel-collector migrate bootstrap --clickhouse-dsn=tcp://${CLICKHOUSE_HOST}:9000 --clickhouse-replication=false && /signoz-otel-collector migrate sync up --clickhouse-dsn=tcp://${CLICKHOUSE_HOST}:9000 --clickhouse-replication=false --timeout=5m && exec /signoz-otel-collector --config=/etc/otel-collector-config.yaml"]
