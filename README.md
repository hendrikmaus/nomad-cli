# nomad-cli
Docker image with [Nomad](https://github.com/hashicorp/nomad) inside of it to be used as CLI tool.

*This image is **unofficial** and not intended to run Nomad agents; it is supposed to be a utility container for deployment pipelines.*

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

> The `latest` tag should always be nomad stable; please open an issue if I missed to update.

## Build

### Automatic Daily Build
GitHub Actions runs every day at 1730 hours.

### Manual Build

```bash
# linux_amd64 checksum
./build.sh -version 1.1.4 -sha256 735790c3664f89dfcc3cadfec8c421d812b00516425ca5aa186b58b82c6f3e1f
```

> You can find all releases and checksums at https://releases.hashicorp.com/nomad/

## Contribution

I am more than happy to accept any help in further automating and improving this.
