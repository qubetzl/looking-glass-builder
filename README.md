# Quickstart

```
docker build -t looking-glass-builder .
docker container run --rm -it -v $(pwd):/build looking-glass-builder
```

# Volume
Volume /build/ in order to get the binary e.g.
```
-v $(pwd):/build
```