#
# Docker image for the Raspberry Pi UEFI SD image creator
#
# Copyright (c) 2018 Philippe Mathieu-Daudé
#
# SPDX-License-Identifier: GPL-2.0-or-later
#
FROM debian:stretch-slim

MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yy eatmydata

RUN dpkg --add-architecture armel && \
    dpkg --add-architecture armhf && \
    dpkg --add-architecture aarch64

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive eatmydata \
    apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        bison \
        build-essential \
        ca-certificates \
        device-tree-compiler \
        dosfstools \
        flex \
        gcc \
        gcc-arm-linux-gnueabi \
        gcc-arm-linux-gnueabihf \
        gcc-aarch64-linux-gnu \
        git \
        liblzma-dev \
        kpartx \
        make \
        python \
        u-boot-tools \
        util-linux \
        xz-utils

ENV CROSS_COMPILE_ARMV6=arm-linux-gnueabi- \
    CROSS_COMPILE_ARMV7=arm-linux-gnueabihf- \
    CROSS_COMPILE_AARCH64=aarch64-linux-gnu-

CMD ./create_image.sh sd.raw
