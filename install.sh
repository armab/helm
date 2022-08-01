#!/usr/bin/env bash
set -e

echo ""
echo "When including a plugin in a BitOps install, this script will be called during docker build."
echo "It should be used to install any dependencies required to actually run your plugin."
echo "BitOps uses alpine linux as its base, so you'll want to use apk commands (Alpine Package Keeper)"
echo ""

#apk info

mkdir -p /opt/download
cd /opt/download
HELM_VERSION=3.9.0

function install_helm() {
    if [[ "$HELM_VERSION" == '3.2.0' ]]; then
        wget https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz
        tar -xzvf helm-v$HELM_VERSION-linux-amd64.tar.gz
        mv linux-amd64/helm /usr/local/bin/
        bash -x scripts/helm/install_tiller.sh
    else
        wget https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz
        tar -xzvf helm-v$HELM_VERSION-linux-amd64.tar.gz
        mv linux-amd64/helm /usr/local/bin/
    fi
}
function install_helm_s3() {
    helm plugin install https://github.com/hypnoglow/helm-s3.git
}

install_helm
install_helm_s3
# this should fail
yolo

