FROM alpine:latest AS builder

ARG NOMAD_TAG_NAME
ARG NOMAD_REVISION

RUN apk add --no-cache bash go go-bindata-assetfs linux-headers make

ENV GOFLAGS="-trimpath -mod=readonly -modcacherw" \
    GOCACHE="/go-cache" \
    GOTMPDIR="/"

RUN mkdir -p /go-cache /go/bin
WORKDIR /go/src/github.com/hashicorp/nomad
COPY nomad-${NOMAD_TAG_NAME}.tar.gz .
RUN tar -xf nomad-${NOMAD_TAG_NAME}.tar.gz --strip-components=1
RUN go build -v -o /go/bin/nomad -ldflags "-X github.com/hashicorp/nomad/version.GitCommit='${NOMAD_REVISION}'" -tags "ui release"

FROM alpine:latest
COPY --from=builder /go/bin/nomad /bin/nomad

