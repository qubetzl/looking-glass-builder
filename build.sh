#!/usr/bin/env bash

set -e
set -u

echo "Building GIT_REF: ${GIT_REF}"

git clone https://github.com/gnif/LookingGlass.git /looking-glass/
cd /looking-glass/
git checkout "${GIT_REF}"
git submodule update --init --recursive

abbreviated_ref="$(git rev-parse --short HEAD)"

mkdir /looking-glass/client/build
cd /looking-glass/client/build

# Actually build Looking Glass
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_LINKER:FILEPATH=/usr/bin/ld \
    -DENABLE_BACKTRACE=yes \
    -DENABLE_X11=yes \
    -DENABLE_WAYLAND=yes \
    -DENABLE_LIBDECOR=no \
    -DENABLE_PIPEWIRE=no \
    ..
make -j$(nproc)

looking_glass_version="$(cat /looking-glass/client/build/VERSION)"

# Generated version for the built binary with
# looking glass version and abbreviated commit id
built_version="${looking_glass_version}-${abbreviated_ref}"
# Copy the built binary with version to /build volume
dest_file="/build/looking-glass-client-${built_version}"
cp ./looking-glass-client "${dest_file}"
chown 1000:1000 "${dest_file}"
