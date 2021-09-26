#!/usr/bin/env bash

set -e
set -u

url="https://looking-glass.io/ci/host/source?id=stable"

#commit_hash="2160dee23abc8c0d09d7c6e742dab49ddbcb61fd"
#url="https://github.com/gnif/LookingGlass/archive/${commit_hash}.tar.gz"


mkdir /looking-glass
cd /looking-glass

curl -SsL -o looking-glass.tar.gz "${url}"
tar --strip-components=1 -xvf looking-glass.tar.gz

mkdir /looking-glass/client/build
cd /looking-glass/client/build

# Actually build Looking Glass
cmake ../
make

# Copy the built binary to /build volume
cp ./looking-glass-client /build/
