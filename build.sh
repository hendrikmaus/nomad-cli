#!/usr/bin/env bash

for arg in "$@" ; do
    case "$arg" in
      -version)
        nomad_version=$2
        shift
        ;;
      -sha256)
        nomad_sha256=$3
        shift
        ;;
     esac
done

if [[ -z $nomad_version ]]; then
    echo "Please provide version using -version"
    echo "E.g. 0.6.3 for downloading https://releases.hashicorp.com/nomad/0.6.3/"
    echo "All releases can be found on https://releases.hashicorp.com/nomad/"
    exit 1
fi

if [[ -z $nomad_sha256 ]]; then
    echo "Please provide SHA256 checksum for linux amd64 using -sha256"
    echo "E.g. 908ee049bda380dc931be2c8dc905e41b58e59f68715dce896d69417381b1f4e for 0.6.3"
    echo "Checksum file can be found alongside the releases, e.g. https://releases.hashicorp.com/nomad/0.6.3/"
    exit 1
fi

docker build \
    --build-arg arg_nomad_version=$nomad_version \
    --build-arg arg_nomad_sha256=$nomad_sha256 \
    --progress plain \
    -t hendrikmaus/nomad-cli:$nomad_version \
    .
