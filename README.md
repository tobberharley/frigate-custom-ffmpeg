# Custom Frigate Docker Image with FFmpeg Override (Raspberry Pi 5, HEVC Stateful v4)

This repository contains a **custom Dockerfile** to build a **Frigate** image for the **Raspberry Pi 5**, overriding the default FFmpeg with a **custom HEVC stateful version 4**.  

This setup ensures optimal hardware acceleration and reduced CPU usage for HEVC streams.

---

## Features

- Custom FFmpeg (HEVC stateful v4)
- Optimized for Raspberry Pi 5
- Uses Docker for clean, reproducible builds
- Full Frigate functionality with custom video processing

---

## Requirements

- Raspberry Pi 5 (64-bit recommended)
- Docker & Docker Buildx installed
- Frigate config.yml ready

---

## Build Instructions

1. **Clone this repository**

```bash
git clone https://github.com/torbenhinge/frigate-custom-ffmpeg.git
cd frigate-custom-ffmpeg
