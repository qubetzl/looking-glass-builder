#!/usr/bin/env bash

set -e
set -u

echo "Building GIT_REF: ${GIT_REF}"

git clone https://github.com/gnif/LookingGlass.git /looking-glass/
cd /looking-glass/
git checkout "${GIT_REF}"
git submodule update --init --recursive

mkdir /looking-glass/client/build
cd /looking-glass/client/build

# Actually build Looking Glass
cmake \
    -DENABLE_BACKTRACE=yes \
    -DENABLE_X11=yes \
    -DENABLE_WAYLAND=yes \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_LINKER:FILEPATH=/usr/bin/ld \
    -DENABLE_LIBDECOR=no \
    ..
make -j$(nproc)

chown 1000:1000 looking-glass-client

# Copy the built binary with version to /build volume
version="$(cat /looking-glass/client/build/VERSION)"
cp ./looking-glass-client "/build/looking-glass-client-${version}"
