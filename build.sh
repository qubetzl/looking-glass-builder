#!/usr/bin/env bash

set -e
set -u

curl -SsL -o looking-glass.tar.gz https://looking-glass.io/ci/host/source?id=stable
tar -xvf looking-glass.tar.gz
mv looking-glass-*/ looking-glass/
mkdir /looking-glass/client/build
cd /looking-glass/client/build

# Actually build Looking Glass
cmake ../
make

# Copy the built binary to /build volume
cp ./looking-glass-client /build/
