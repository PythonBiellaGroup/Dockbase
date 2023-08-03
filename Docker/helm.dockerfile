FROM ubuntu:20.04 AS builder

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl ca-certificates

WORKDIR /tmp
RUN curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
RUN curl -Lo helm.tar.gz "https://get.helm.sh/helm-v3.12.1-linux-amd64.tar.gz" && tar -xf helm.tar.gz && cp linux-amd64/helm /usr/local/bin/helm
RUN chmod +x /tmp/kubectl /tmp/linux-amd64/helm

FROM ubuntu:20.04
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl ca-certificates gettext-base \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/kubectl /usr/local/bin/kubectl
COPY --from=builder /tmp/linux-amd64/helm /usr/local/bin/helm
