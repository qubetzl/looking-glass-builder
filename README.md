# Quickstart

Run `rebuild.sh` script in order to build/rebuild the latest stable version.

# Volume
Volume /build/ in order to get the binary e.g.
```
-v $(pwd):/build
```

# Runtime dependencies
For Debian Buster!
## Stable repos
```
fonts-freefont-ttf
libfontconfig1
libgmp10
nettle-bin
binutils
libx11-6
libxss1
libxi6
libxinerama1
libxcb-cursor0
libxpresent1
libxkbcommon0
```
```
sudo apt install fonts-freefont-ttf libfontconfig1 libgmp10 nettle-bin binutils libx11-6 libxss1 libxi6 libxinerama1 libxcb-cursor0 libxpresent1 libxkbcommon0
```

### Wayland
```
libwayland-bin
wayland-protocols
```


## From buster-backports
```
libgles1
(automatically downloads libgl1)
```