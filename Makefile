.PHONY: all clean build run

TAG="morggoth/tiny-distro-builder"

all: build run

clean:
	docker image rm ${TAG}
	rm -rf linux

build:
	docker build . \
	  --build-arg KERNEL_VERSION="6.6.2" \
	  --build-arg BUSYBOX_VERSION="1.36.1" \
	  --tag ${TAG}
	docker run \
	  --rm \
	  -it \
	  -v $${PWD}/linux:/build/linux \
	  ${TAG}

run:
	/usr/libexec/qemu-kvm -kernel ./linux/vmlinuz-6.6.2 -initrd initrd-busybox-1.36.1.img -nographic -append 'console=ttyS0'