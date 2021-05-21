#!/bin/bash

VERSION=1.4.0
PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=amd64
DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kustomize/plugin/goabout.com/v1beta1/sopssecretgenerator"
NAME="SopsSecretGenerator"

if [ ! -x "${DIR}/${NAME}" ]; then
    mkdir -p "${DIR}"
    curl --progress-bar -Lo "${DIR}/${NAME}" https://github.com/goabout/kustomize-sopssecretgenerator/releases/download/v${VERSION}/SopsSecretGenerator_${VERSION}_${PLATFORM}_${ARCH}
    chmod +x "${DIR}/${NAME}"
else
    echo "Plugin ${NAME} is already installed in your system on Path ${DIR}"
fi
