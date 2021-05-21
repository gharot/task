#!/bin/bash

CURRDIR=$(dirname $0)
source ${CURRDIR}/../tools.env
source ${CURRDIR}/shared/functions.sh

# Check if tools are instlled
for tool in ${TOOLS}
do
    version="${tool^^}_VERSION"
    version_attr="${tool^^}_VERSION_ATTR"
    sed_expresion="${tool^^}_SED_EXPR"
    release_url="${tool^^}_RELEASE_URL"

    check=$(check_binary_version "${tool}" "${!version}" "${!version_attr}" "${!sed_expresion}")
    rc=${?}
    #echo "RC: ${rc}"
    if [ "${rc}" -ne 0 ]; then
        install_binary "${tool}" "${!version}" "${!release_url}"
    fi
    echo "Tool ${tool} installed in version: ${!version}"
done

# Install plugins
bash ${CURRDIR}/install-sopssecretgenerator.sh

# Copy .direnvrc to HOME dir
if [ ! -e "${HOME}/.direnvrc" ]; then
    cp ${CURRDIR}/../.direnvrc ${HOME}/.direnvrc
fi

# Add HOOK to shel zsh or bash
BASE_SHELL=$(basename "${SHELL}")
echo "Shell: ${BASE_SHELL}"
if [ ${BASE_SHELL} == "bash" ]; then
    # for BASH
    exist=$(grep -r -q "_direnv_hook" ~/.bashrc)
    rc=${?}
    if [ rc != 0  ]; then
        echo "$(direnv hook bash)" >> ~/.bashrc
    fi
elif [ ${BASE_SHELL} == "zsh" ]; then
    # for ZSH
    exist=$(grep -r -q "_direnv_hook" ~/.zshrc)
    rc=${?}
    if [ rc != 0  ]; then
        echo "$(direnv hook zsh)"  >> ~/.zshrc
    fi
fi

# Allow git hooks
git config core.hooksPath .git-hooks

# Allow .direnv to use
direnv allow
