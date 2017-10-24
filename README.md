# nomad-cli
Docker image with [Nomad](https://github.com/hashicorp/nomad) inside of it to be used as CLI tool.

## Usage

```bash
docker run \
    -v ${PWD}/service.nomad:/service.nomad \
    hendrikmaus/nomad-cli \
    nomad run \
    -address=http://your-nomad:4646 \
    service.nomad
```

## Build

```bash
# linux_amd64 checksum
./build.sh -version 0.6.3 -sha256 908ee049bda380dc931be2c8dc905e41b58e59f68715dce896d69417381b1f4e
```

> You can find all releases and checksums at https://releases.hashicorp.com/nomad/
