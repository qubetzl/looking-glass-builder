#!/usr/bin/env bash

set -e
set -u

build_from_lg_site=false

mkdir /looking-glass
if [[ "${build_from_lg_site}" == "true" ]]; then
    cd /looking-glass/
    curl -SsL -o looking-glass.tar.gz "https://looking-glass.io/ci/host/source?id=stable"
    tar --strip-components=1 -xvf looking-glass.tar.gz
else
    ref="bc65de598722bcf4f4c8af04e3be0084a11f19fb"
    git clone https://github.com/gnif/LookingGlass.git /looking-glass/
    cd /looking-glass/
    git checkout "${ref}"
    git submodule update --init --recursive
fi

mkdir /looking-glass/client/build
cd /looking-glass/client/build

# Trying to setup looking glass to be statically linked.
# Shared libs path: /usr/lib/x86_64-linux-gnu/
# for debugging
# /usr/bin/ld -lwayland-client --verbose
# 
# cmake \
#     -DBUILD_SHARED_LIBS=OFF \
#     -DCMAKE_EXE_LINKER_FLAGS="-static" \
#     -DENABLE_BACKTRACE=yes \
#     -DENABLE_X11=yes \
#     -DENABLE_WAYLAND=yes \
#     -DCMAKE_BUILD_TYPE=Release \
#     -DCMAKE_LINKER:FILEPATH=/usr/bin/ld \
#     -DENABLE_LIBDECOR=no \
#     ..

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
