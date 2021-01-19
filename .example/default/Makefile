DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PROJECT_VERSION:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/caddy
CONTAINER:=caddy-$(PROJECT_VERSION)

.DEFAULT_GOAL := all
.PHONY: *

all: build run

build:
	# Create folder to share with caddy
	@mkdir -p $(DIR)/rootfs/var/www
	# Download a testpage to use with caddy
	@docker run --rm \
		-v $(DIR)/rootfs/var/www:/data \
		dsuite/alpine-data sh -c "curl -O https://raw.githubusercontent.com/cbracco/html5-test-page/master/index.html"
	# Build caddy image
	@docker build \
		--file $(DIR)/Dockerfile \
		--tag $(DOCKER_IMAGE):$(PROJECT_VERSION) \
		$(DIR)

run:
	@docker run -it --rm \
		-e DEBUG_LEVEL=DEBUG \
		-p 8080:80 \
    	--name $(CONTAINER) \
		$(DOCKER_IMAGE):$(PROJECT_VERSION) \
		$(ARGS)
