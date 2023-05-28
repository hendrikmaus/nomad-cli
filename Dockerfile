FROM alpine:latest AS builder

RUN apk add --no-cache bash go go-bindata-assetfs linux-headers make

ENV GOFLAGS="-trimpath -mod=readonly -modcacherw" \
    GIT_COMMIT="8af7088" \
    GOCACHE="/go-cache" \
    GOTMPDIR="/"

RUN mkdir -p /go-cache /go/bin
WORKDIR /go/src/github.com/hashicorp/nomad
COPY nomad-1.5.6.tar.gz .
RUN tar -xf nomad-1.5.6.tar.gz --strip-components=1
RUN go build -v -o /go/bin/nomad -ldflags "-X github.com/hashicorp/nomad/version.GitCommit='1.5.6'" -tags "ui release"
RUN mkdir -p /etc/nomad.d /var/lib/nomad
RUN chown -R root:root /var/lib/nomad

ENTRYPOINT ["/go/bin/nomad"]

FROM alpine:latest
COPY --from=builder /go/bin/nomad /bin/nomad

