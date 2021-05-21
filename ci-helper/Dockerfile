FROM alpine

RUN apk update && \
    apk add ca-certificates git curl jq python3 py-pip gnupg nano && \
    rm -rf /var/cache/apk/* && \
    pip install awscli && \
    wget -O /usr/local/bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.20.2/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    KUSTOMIZE_VERSION="4.1.2" && \
    wget -O - \
    https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    | tar -C /usr/local/bin/ -xz && \
    chmod +x /usr/local/bin/kustomize && \
    VERSION=1.4.0 && \
    PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]') && \
    ARCH=amd64 && \
    DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kustomize/plugin/goabout.com/v1beta1/sopssecretgenerator" && \
    NAME="SopsSecretGenerator" && \
    mkdir -p "${DIR}" && \
    curl --progress-bar -Lo "${DIR}/${NAME}" https://github.com/goabout/kustomize-sopssecretgenerator/releases/download/v${VERSION}/SopsSecretGenerator_${VERSION}_${PLATFORM}_${ARCH} && \
    chmod +x "${DIR}/${NAME}" 

USER root