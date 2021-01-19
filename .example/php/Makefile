DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PROJECT_VERSION:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/caddy
CONTAINER:=caddy-$(PROJECT_VERSION)

.PHONY: *

build:
	@docker-compose \
		--file $(DIR)/docker-compose.yml \
		--project-name $(DOCKER_IMAGE):$(PROJECT_VERSION) \
		build
up:
	@docker-compose up -d --build

down:
	@docker-compose down
