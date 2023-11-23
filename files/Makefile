.ONESHELL:
.SHELLFLAGS += -e

KERNEL_VERSION="6.6.2"
BUSYBOX_VERSION="1.36.1"
KERNEL_MAJOR_VERSION=$$(echo ${KERNEL_VERSION} | cut --delimiter="." --fields=1)
NPROC=$$(nproc --all)

busybox:
	curl https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2 | tar -C ${BUILD_DIR}/src/ xjf -
	$(MAKE) -C ${BUILD_DIR}/src/busybox-${BUSYBOX_VERSION} -j${NPROC} defconfig
	$(MAKE) -C ${BUILD_DIR}/src/busybox-${BUSYBOX_VERSION} -j${NPROC} LDFLAGS=-static
	cp ${BUILD_DIR}/src/busybox-${BUSYBOX_VERSION}/busybox ${BUILD_DIR}/initrd/bin/
	for app in $$(${BUILD_DIR}/initrd/bin/busybox --list); do ln -s /bin/busybox ${BUILD_DIR}/initrd/bin/${app}; done
	find ${BUILD_DIR}/initrd | cpio -o -H newc > ${BUILD_DIR}/linux/initrd-busybox-${BUSYBOX_VERSION}.img

kernel:
	curl https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_MAJOR_VERSION}.x/linux-${KERNEL_VERSION}.tar.xz | tar -C ${BUILD_DIR}/src/ xJf -
	cd ${BUILD_DIR}/src/linux-${KERNEL_VERSION}
	$(MAKE) -C ${BUILD_DIR}/src/linux-${KERNEL_VERSION} -j${NPROC} defconfig
	$(MAKE) -C ${BUILD_DIR}/src/linux-${KERNEL_VERSION} -j${NPROC}
	cp ${BUILD_DIR}/src/linux-${KERNEL_VERSION}/arch/x86_64/boot/bzImage ${BUILD_DIR}/linux/vmlinuz-${KERNEL_VERSION}
