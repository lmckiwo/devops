#/bin/bash

PUBLIC_FEDORA_CONTAINER=docker.io/pellepedro/fedora-dev:latest

printf "\033[32m\xE2\x9c\x93 Running Fedora Development Container \033[0m\n"
sudo podman run -it --rm --privileged \
    -v ${HOME}/.netrc:/home/devops/.netrc:z \
    -v ${HOME}/.ssh:/home/devops/.ssh:z \
    -v ${HOME}/.gitconfig:/home/devops/.gitconfig:z \
    -v ${HOME}:/home/devops/host:rw \
    -v ${HOME}/go/pkg/mod:/home/devops/go/pkg/mod:z \
    ${PUBLIC_FEDORA_CONTAINER} -name fdev
