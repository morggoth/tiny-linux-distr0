.PHONY: all build clean

TAG="morggoth/tiny-distro-builder"

all: build

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