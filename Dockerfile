FROM docker:latest 

MAINTAINER Hendrik Maus <hendrik.maus@trivago.com>

ENV GLIBC_VERSION "2.34-r0"
ENV GOSU_VERSION "1.14"
ENV DUMP_INIT_VERSION "1.2.5"

RUN set -x && \
    apk --update add --no-cache --virtual .gosu-deps tzdata dpkg curl ca-certificates gnupg libcap openssl && \
    apk del libc6-compat && \
    curl -Ls https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk > /tmp/glibc-${GLIBC_VERSION}.apk && \
    apk add --allow-untrusted --no-cache /tmp/glibc-${GLIBC_VERSION}.apk && \
    rm -rf /tmp/glibc-${GLIBC_VERSION}.apk /var/cache/apk/* && \
    wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMP_INIT_VERSION}/dumb-init_${DUMP_INIT_VERSION}_x86_64 && \
    chmod +x /usr/local/bin/dumb-init

ARG arg_nomad_version
ARG arg_nomad_sha256
ENV NOMAD_VERSION $arg_nomad_version
ENV NOMAD_SHA256 $arg_nomad_sha256

ADD https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip /tmp/nomad.zip
RUN echo "${NOMAD_SHA256}  /tmp/nomad.zip" > /tmp/nomad.sha256 \
    && sha256sum -c /tmp/nomad.sha256 \
    && cd /bin \
    && unzip /tmp/nomad.zip \
    && chmod +x /bin/nomad \
    && rm /tmp/nomad.zip
