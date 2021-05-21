#!/bin/bash

check_binary_version(){

    # Usage: check_binary_version <BINARY_NAME> <VERSION> <VERSION_ATTR> <SED_EXPRESION>
    #
    # Check if binary is installed in local system in dir "${HOME}/.<BINARY_NAME>/<VERSION>/<BINARY_NAME>" and in which versions
    # Return codes:
    #   0   binary installed in needed version
    #   1   binary installed BUT its versien diffeer from needed version
    #   2   binary in NOT installed at all

    BINARY_NAME="${1}"
    VERSION="${2}"
    VERSION_ATTR="${3}"
    SED_EXPRESION="${4}"

    BINARY_DIR="${HOME}/.${BINARY_NAME}/${VERSION}/"
    BINARY_PATH="${BINARY_DIR}/${BINARY_NAME}"

    if [ -e "${BINARY_PATH}" ]; then
        # Check version of binary
        VERSION_INSTALLED=$( eval " ${BINARY_PATH} ${VERSION_ATTR}" | sed -e "${SED_EXPRESION}" | head -n 1)
        if [ "${VERSION}" != "${VERSION_INSTALLED}" ]; then
            # Version doesn't righ exit with 1
            echo "${VERSION_INSTALLED}"
            exit 1
        else
            # Binary and its version is OK
            exit 0
        fi
    else
        # Binary not in dir exit with rc 2
        exit 2
    fi

}

install_binary(){

    # Usage: install_binary <BINARY_NAME> <VERSION> <URL>
    #
    # Install binary to local system in dir "${HOME}/.<BINARY_NAME>/<VERSION>/<BINARY_NAME>"
    # Currently supported are terraform, terragrun, sops

    BINARY_NAME="${1}"
    VERSION="${2}"
    URL="${3}"

    BINARY_DIR="${HOME}/.${BINARY_NAME}/${VERSION}/"
    UNZIP=$([[ $(echo "${URL}" | grep ".*.zip$") != "" ]] && echo "true" || echo "false")
    TARGZ=$([[ $(echo "${URL}" | grep ".*.tar.gz$") != "" ]] && echo "true" || echo "false")

    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     MACHINE=linux;;
        Darwin*)    MACHINE=darwin;;
        *)          MACHINE="UNKNOWN:${unameOut}"; echo "Arch not known, exit"; exit 2;
    esac
    echo "Install ${BINARY_NAME} for ${MACHINE} version: ${VERSION}"

    RELEASE_URL=$(eval echo ${URL})

    mkdir -p "${BINARY_DIR}"
    if [ "${UNZIP}" == "true" ]; then
        TMPFILE=$(mktemp)
        curl -L --progress-bar "${RELEASE_URL}" -o "${TMPFILE}"
        unzip -qq -o -d "${BINARY_DIR}" "${TMPFILE}"
        rm "${TMPFILE}"
        chmod +x "${BINARY_DIR}/${BINARY_NAME}"
    elif [ "${TARGZ}" == "true" ]; then
        TMPFILE=$(mktemp)
        TMPDIR=$(mktemp -d)
        curl -L --progress-bar "${RELEASE_URL}" -o "${TMPFILE}"
        tar -xzf "${TMPFILE}" -C "${TMPDIR}"
        find ${TMPDIR} -name "${BINARY_NAME}" -exec cp {} "${BINARY_DIR}/" \;
        rm "${TMPFILE}"
        rm -rf "${TMPDIR}"
        chmod +x "${BINARY_DIR}/${BINARY_NAME}"
    else
        curl -L --progress-bar "${RELEASE_URL}" -o "${BINARY_DIR}/${BINARY_NAME}"
        chmod +x "${BINARY_DIR}/${BINARY_NAME}"
    fi
}
