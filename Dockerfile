FROM debian:buster
# FROM ubuntu:focal
# ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    binutils-dev \
    cmake \
    fonts-freefont-ttf \
    libfontconfig1-dev \
    libsdl2-dev \
    libsdl2-ttf-dev \
    libspice-protocol-dev \
    libx11-dev \
    nettle-dev \
    wayland-protocols \
    curl

RUN curl -SsL -o looking-glass.tar.gz https://looking-glass.io/ci/host/source?id=stable && \
    tar -xvf looking-glass.tar.gz && \
    mv looking-glass-*/ looking-glass/ && \
    mkdir looking-glass/client/build && \
    mkdir /build

VOLUME /build
WORKDIR /looking-glass/client/build

# RUN useradd -ms /bin/bash test

RUN echo '#!/bin/sh\n\
cmake ../\n\
make\n\
cp ./looking-glass-client /build/\n'\
> build.sh && chmod +x build.sh

CMD ["./build.sh"]
