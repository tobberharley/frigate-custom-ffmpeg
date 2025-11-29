FROM debian:bookworm-slim AS build-ffmpeg

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      build-essential git pkg-config yasm \
      libdrm-dev libv4l-dev libssl-dev \
      libx264-dev libx265-dev libfreetype6-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN git clone --branch dev/5.1.6/sandm_1 --depth 1 https://github.com/jc-kynesim/rpi-ffmpeg.git ffmpeg

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
    make -j$(nproc) && \
    make install

FROM ghcr.io/blakeblackshear/frigate:stable

# Install libv4l2 and friends inside the container
#RUN apt-get update && apt-get install -y --no-install-recommends libv4l-0 &&  rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    libv4l-dev \
    libjpeg-dev \
    libx264-dev \
    libx265-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build-ffmpeg /usr/local/ffmpeg /usr/bin/ffmpeg
COPY --from=build-ffmpeg /usr/local/ffprobe /usr/bin/ffprobe

# Copy in your custom ffmpeg/ffprobe
# COPY /usr/local/bin/custom-ffmpeg  /usr/local/bin/

# RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe && \
#    /usr/local/bin/ffmpeg -version || true


# 
# docker buildx build --platform linux/arm64 -f frigate.dockerfile -t torbenhinge/frigate:custom-ffmpeg-0.14.1 .
