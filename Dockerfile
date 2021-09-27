FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++

RUN echo "deb http://deb.debian.org/debian buster-backports main" > /etc/apt/sources.list.d/debian-backports.list
RUN apt-get update && \
    apt-get install -y -t buster-backports libgles-dev && \
    apt-get install -y \
    git \
    vim \
    less \
    curl \
    cmake \
    gcc \
    g++ \
    make \
    gawk \
    fonts-freefont-ttf \
    libfontconfig1-dev \
    libgmp-dev \
    libspice-protocol-dev \
    nettle-dev \
    pkg-config \
    binutils-dev \
    libgl-dev \
    libx11-dev \
    libxss-dev \
    libxi-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxpresent-dev \
    libwayland-dev \
    wayland-protocols \
    libxkbcommon-dev

RUN mkdir /build
VOLUME /build

COPY build.sh /

CMD ["/build.sh"]

# RUN useradd -ms /bin/bash test
