FROM debian:bookworm-slim AS build-ffmpeg

ARG FFMPEG_BRANCH

RUN test -n "$FFMPEG_BRANCH"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      build-essential git pkg-config nasm yasm \
      libdrm-dev libv4l-dev libssl-dev libudev-dev \
      libx264-dev libx265-dev libfreetype6-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN git clone \
      --branch "$FFMPEG_BRANCH" \
      --depth 1 \
      https://github.com/jc-kynesim/rpi-ffmpeg.git ffmpeg && \
    cp ffmpeg/RELEASE ffmpeg/VERSION

WORKDIR /build/ffmpeg

RUN ./configure \
      --prefix=/usr/local \
      --enable-gpl \
      --enable-libdrm \
      --enable-libv4l2 \
      --enable-v4l2-request \
      --enable-libx264 \
      --enable-libx265 \
      --enable-libfreetype \
      --disable-debug && \
    make -j"$(nproc)" && \
    make install

FROM ghcr.io/blakeblackshear/frigate:stable-rocm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      libv4l-dev \
      libudev-dev \
      libjpeg-dev \
      libx264-dev \
      libx265-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build-ffmpeg /usr/local/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=build-ffmpeg /usr/local/bin/ffprobe /usr/bin/ffprobe
