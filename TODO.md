# TODO
This is a list of ideas, todos and a wish list for this project.
## Generate README.md
Setup generation of `README.md` per variant.
## Setup builder user
Setup user to create the build instead of using root.
```bash
# Add user
useradd -ms /bin/bash builder

# Check if user is root
if [ "$(id -u)" == "0" ]; then
fi
```
## Static build
Firstly, determine whether or not a build with statically linked libraries would be a good idea.

The following is the result of prior attempts and exploration. 
This may be used as starting point
```bash
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
```