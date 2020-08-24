#!/bin/bash
# podman run --name python-dev -dt --userns keep-id -v $PROJECT_PATH:/home/pythonsvc/:Z localhost/devtool:latest
set -ex

IMAGE=$1
OS=$2

################################################################################
#
# Base Container Buildfile
#
#################################################################################

#OS=$(awk -F= '/^ID=/ {print $2}' /etc/os-release)

if [[ ! $OS =~ (fedora) && ! $OS =~ (ubuntu) ]]; then
    echo "The supported base images are ubuntu and fedora"
    exit
fi

buildah from --name ${IMAGE} ${OS}

# Install/update os distro packages
cat os-packages/install-${OS}-packages | buildah run ${IMAGE} -- sh

# Install go
cat app-releases/install-go-linux | buildah run ${IMAGE} -- bash

# Install java jdk
cat app-releases/install-jdk-linux | buildah run ${IMAGE} -- bash


# Install dev
cat app-releases/install-dev-tools | buildah run ${IMAGE} -- bash

export GOROOT=/usr/local/go
export JDK_HOME=/opt/jdk
buildah config \
	--env JDK_HOME=$JDK_HOME \
	--env GOROOT=$GOROOT     \
	--env PATH=$PATH:${JDK_HOME}/bin:${GOROOT}/bin \
	${IMAGE}

buildah commit --squash --rm $IMAGE $IMAGE

################################################################################
# End
################################################################################