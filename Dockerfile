FROM ubuntu:22.04

# RUN  apt install --yes make build-essential bc bison flex libssl-dev libelf-dev wget cpio fdisk extlinux dosfstools qemu-system-x86

SHELL [ "/bin/bash", "-c" ]

ARG KERNEL_VERSION="6.6.2"
ARG BUSYBOX_VERSION="1.36.1"

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

    #   fdisk \
    #   extlinux \
    #   dosfstools \

WORKDIR ${BUILD_DIR}

RUN mkdir -p src linux/{bin,dev,proc,sys} initrd

COPY --chmod=777 files/init initrd/
COPY files/Makefile ./
