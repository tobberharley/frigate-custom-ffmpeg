# Custom Frigate Docker Image with FFmpeg Override (Pi5 & Ubuntu, HEVC Stateful v4)

This repository provides a **custom Dockerfile** to build a Frigate image that overrides the shipped FFmpeg with a **HEVC stateful v4 build**, for both:

- **Raspberry Pi 5 OS (64-bit)**
- **Ubuntu ARM64 / x86_64** (for testing or other ARM64 boards)

> Since the HEVC stateful driver for Pi5 isn’t in the mainline kernel yet, the custom FFmpeg includes patches and V4L2 driver support.

---

## Features

- Custom FFmpeg v4 with HEVC stateful decoding
- Works on Raspberry Pi 5 & Ubuntu ARM64
- Hardware acceleration with V4L2
- Dockerized for reproducible builds
- Reduced CPU load for multiple HEVC streams

---

## Requirements

- Docker & Docker Buildx
- `git`, `curl` (for build environment)
- Frigate configuration ready

---

## Build Instructions

### 1. Clone this repository

```bash
git clone https://github.com/tobberharley/frigate-custom-ffmpeg.git
cd frigate-custom-ffmpeg
