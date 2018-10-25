FROM golang:1.11

RUN set -x \
 && apt-get update \
 && apt-get install -y --no-install-recommends libsystemd-dev \
 && rm -Rf /var/lib/apt/lists/*

WORKDIR /source

CMD ["go", "build", "-o", "/target/journald-cloudwatch-logs-linux-amd64", "."]
