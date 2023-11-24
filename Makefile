build:
	docker build . \
	  --build-arg KERNEL_VERSION="6.6.2" \
	  --build-arg BUSYBOX_VERSION="1.36.1" \
	  --tag tiny-distro-builder