KERNEL_VERSION="6.6.2"
BUSYBOX_VERSION="1.36.1"
KERNEL_MAJOR_VERSION=$$(echo ${KERNEL_VERSION} | cut --delimiter="." --fields=1)
NPROC=$$(nproc --all)

download-src:
	curl https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_MAJOR_VERSION}.x/linux-${KERNEL_VERSION}.tar.xz | tar xfJ -
	curl https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2 | tar xfj -

busybox:
	cd busybox-${BUSYBOX_VERSION} && make -j${NPROC} defconfig && make -j${NPROC} LDFLAGS=-static

linux:
	cd linux-${KERNEL_VERSION} && make defconfig && make -j${NPROC}
