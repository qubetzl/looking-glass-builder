FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

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

RUN mkdir /build
VOLUME /build

COPY build.sh /

CMD ["/build.sh"]

# RUN useradd -ms /bin/bash test
