FROM docker:latest 

MAINTAINER Hendrik Maus <hendrik.maus@trivago.com>

RUN apk update \
 && apk add gcompat

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
