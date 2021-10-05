#!/usr/bin/env bash

set -e
set -u

# Make sure we have the most up-to-date base image
docker image pull debian:buster
# Build builder image
docker build -t looking-glass-builder -f debian/buster/Dockerfile .
# Build Looking Glass
docker container run --rm -it -v $(pwd):/build looking-glass-builder
