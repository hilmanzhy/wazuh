#! /bin/bash

set -ex

JOBS=$1
DEBUG=$2
ZIP_NAME=$3
TRUST_VERIFICATION=$4
CA_NAME=$5

# Compile the verprotect agent for Windows
FLAGS="-j ${JOBS} IMAGE_TRUST_CHECKS=${TRUST_VERIFICATION} CA_NAME=\"${CA_NAME}\" "

if [[ "${DEBUG}" = "yes" ]]; then
    FLAGS+="DEBUG=1 "
fi

if [ -z "${BRANCH}"]; then
    mkdir /verprotect-local-src
    cp -r /local-src/* /verprotect-local-src
else
    URL_REPO=https://github.com/wazuh/wazuh/archive/${BRANCH}.zip

    # Download the verprotect repository
    wget -O verprotect.zip ${URL_REPO} && unzip verprotect.zip
fi

bash -c "make -C /verprotect-*/src deps TARGET=winagent ${FLAGS}"
bash -c "make -C /verprotect-*/src TARGET=winagent ${FLAGS}"

rm -rf /verprotect-*/src/external

zip -r /shared/${ZIP_NAME} /verprotect-*
