.ONESHELL:
.SHELLFLAGS += -e

KERNEL_VERSION="6.6.2"
BUSYBOX_VERSION="1.36.1"
KERNEL_MAJOR_VERSION=$$(echo ${KERNEL_VERSION} | cut --delimiter="." --fields=1)
NPROC=$$(nproc --all)

download-src:
	cd ${BUILD_DIR}/src/
	curl https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_MAJOR_VERSION}.x/linux-${KERNEL_VERSION}.tar.xz | tar xfJ -
	curl https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2 | tar xfj -

busybox:
	cd ${BUILD_DIR}/src/busybox-${BUSYBOX_VERSION}
	$(MAKE) -j${NPROC} defconfig
	$(MAKE) -j${NPROC} LDFLAGS=-static
	cp busybox ${BUILD_DIR}/initrd/bin
	cd ${BUILD_DIR}/initrd/bin
	for prog in $$(./busybox --list); do ln -s /bin/busybox $$prog; done
	cd ${BUILD_DIR}/initrd
	find . | cpio -o -H newc > ${BUILD_DIR}/linux/initrd-busybox-${BUSYBOX_VERSION}.img

linux:
	cd linux-${KERNEL_VERSION}
	$(MAKE) defconfig
	$(MAKE) -j${NPROC}
	cp arch/x86_64/boot/bzImage ${BUILD_DIR}/linux/vmlinuz-${KERNEL_VERSION}
