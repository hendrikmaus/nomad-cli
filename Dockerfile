FROM docker:latest 

ENV GLIBC_VERSION "2.32-r0"

RUN set -x \
 # per https://github.com/hashicorp/nomad/issues/5535#issuecomment-651888183
 && export -n LD_BIND_NOW \
 # per https://github.com/sgerrand/alpine-pkg-glibc/issues/51#issuecomment-302530493
 && apk del libc6-compat \
 && apk --update add --no-cache --virtual tzdata dpkg curl ca-certificates gnupg libcap openssl dumb-init \
 && curl -Ls https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk > /tmp/glibc-${GLIBC_VERSION}.apk \
 && apk add --allow-untrusted --no-cache /tmp/glibc-${GLIBC_VERSION}.apk \
 && rm -rf /tmp/glibc-${GLIBC_VERSION}.apk /var/cache/apk/* \
 && apk del gnupg openssl

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
 && rm /tmp/nomad.zip \
 && nomad version
