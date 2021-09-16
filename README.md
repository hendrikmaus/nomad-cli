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

## Dockerhub
You can find the images on Dockerhub https://hub.docker.com/r/hendrikmaus/nomad-cli/

> The `latest` tag should always be nomad stable; please open an issue if I missed to update (see travis build for details, it logs what is considered stable)

## Build

### Automatic Daily Build
GitHub Actions runs every day at 1730 hours.

### Manual Build

```bash
# linux_amd64 checksum
./build.sh -version 0.6.3 -sha256 908ee049bda380dc931be2c8dc905e41b58e59f68715dce896d69417381b1f4e
```

> You can find all releases and checksums at https://releases.hashicorp.com/nomad/

## Contribution

I am more than happy to accept any help in further automating and improving this.
