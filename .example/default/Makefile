DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PROJECT_VERSION:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/caddy
CONTAINER:=caddy-$(PROJECT_VERSION)

.DEFAULT_GOAL := run
.PHONY: *

build:
	# Create folder to share with caddy
	@mkdir -p $(DIR)/rootfs/var/www
	# Download a testpage to use with caddy
	@docker run --rm \
		-v $(DIR)/rootfs/var/www:/data \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		dsuite/alpine-data sh -c "curl -O https://raw.githubusercontent.com/cbracco/html5-test-page/master/index.html"
	# Build caddy image
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--build-arg no_proxy=${no_proxy} \
		--file $(DIR)/Dockerfile \
		--tag $(DOCKER_IMAGE):$(PROJECT_VERSION) \
		$(DIR)

run:
	@$(MAKE) build
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e no_proxy=${no_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-p 2015:2015 \
    	--name $(CONTAINER) \
		$(DOCKER_IMAGE):$(PROJECT_VERSION) \
		$(ARGS)
