#!/usr/bin/env bash

set -e
set -u

# Make sure we have the most up-to-date base image
docker image pull ubuntu:20.04
# Build builder image
docker build -t looking-glass-builder-ubuntu -f Dockerfile.ubuntu .
# Build Looking Glass
docker container run --rm -it -v $(pwd):/build looking-glass-builder-ubuntu
