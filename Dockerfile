# Base on official Frigate image (adjust tag to match your Frigate version)
FROM ghcr.io/blakeblackshear/frigate:latest

# Just as documentation: this is an arm64 build on a Pi 5
# Frigate images are already multi-arch, so this will resolve to arm64v8.

# Copy in our custom ffmpeg + ffprobe
# They will overwrite whatever is inside the base image.
COPY custom-ffmpeg/bin/ffmpeg /usr/local/bin/ffmpeg
COPY custom-ffmpeg/bin/ffprobe /usr/local/bin/ffprobe

# Make sure they are executable
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe
