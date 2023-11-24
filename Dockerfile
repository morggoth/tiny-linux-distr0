FROM ubuntu:22.04

SHELL [ "/bin/bash", "-c" ]

ARG KERNEL_VERSION="6.6.0"
ARG BUSYBOX_VERSION="1.36.0"

ENV KERNEL_VERSION=${KERNEL_VERSION}
ENV BUSYBOX_VERSION=${BUSYBOX_VERSION}
ENV BUILD_DIR="/build"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && \
    apt install --yes \
      make \
      build-essential \
      bc \
      bison \
      flex \
      libssl-dev \
      libelf-dev \
      curl \
      cpio \
      && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

WORKDIR ${BUILD_DIR}

RUN mkdir -p src linux initrd/{bin,dev,proc,sys}

COPY --chmod=777 files/init initrd/
COPY files/Makefile ./