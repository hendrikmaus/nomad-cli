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

