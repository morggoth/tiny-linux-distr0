.ONESHELL:
.SHELLFLAGS += -e
.PHONY: all clean initrd kernel

KERNEL_MAJOR_VERSION=$$(echo ${KERNEL_VERSION} | cut --delimiter="." --fields=1)
NPROC=$$(nproc --all)
SRC_DIR=$${BUILD_DIR}/src
INITRD_DIR=$${BUILD_DIR}/initrd

ifeq ($(shell arch), x86_64)
  ARCH="x86_64"
else ifeq ($(shell arch), aarch64)
  ARCH="arm64"
endif

all: initrd kernel

clean:
	rm -rf src linux initrd/bin
	mkdir -p src linux initrd/bin

initrd:
	curl https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2 | tar -C ${SRC_DIR} -xjf -
	$(MAKE) -C ${SRC_DIR}/busybox-${BUSYBOX_VERSION} -j${NPROC} defconfig
	$(MAKE) -C ${SRC_DIR}/busybox-${BUSYBOX_VERSION} -j${NPROC} LDFLAGS=-static
	cp ${SRC_DIR}/busybox-${BUSYBOX_VERSION}/busybox ${INITRD_DIR}/bin/
	for app in $$(${INITRD_DIR}/bin/busybox --list); do ln -s /bin/busybox ${INITRD_DIR}/bin/$${app}; done
	find ${INITRD_DIR} | cpio -o -H newc > ${BUILD_DIR}/linux/initrd-busybox-${BUSYBOX_VERSION}.img

kernel:
	curl https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_MAJOR_VERSION}.x/linux-${KERNEL_VERSION}.tar.xz | tar -C ${SRC_DIR}/ -xJf -
	cd ${SRC_DIR}/linux-${KERNEL_VERSION}
	$(MAKE) -C ${SRC_DIR}/linux-${KERNEL_VERSION} -j${NPROC} defconfig
	$(MAKE) -C ${SRC_DIR}/linux-${KERNEL_VERSION} -j${NPROC}
	cp ${SRC_DIR}/linux-${KERNEL_VERSION}/arch/${ARCH}/boot/bzImage ${BUILD_DIR}/linux/vmlinuz-${KERNEL_VERSION}
