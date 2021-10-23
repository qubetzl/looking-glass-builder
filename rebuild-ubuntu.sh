#!/usr/bin/env bash

set -e
set -u

# GIT_REF="bc65de598722bcf4f4c8af04e3be0084a11f19fb"
GIT_REF="${1}"

# Make sure we have the most up-to-date base image
docker image pull ubuntu:20.04
# Build builder image
docker build -t looking-glass-builder-ubuntu -f ubuntu/focal/Dockerfile .
# Build Looking Glass
docker container run --rm -it --env GIT_REF="${GIT_REF}" -v $(pwd):/build looking-glass-builder-ubuntu
