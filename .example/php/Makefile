DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
ROOT:=$(strip $(abspath $(DIR)/../..))
PROJECT_NAME:=$(strip $(shell basename $(ROOT)))
PROJECT_VERSION:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/$(PROJECT_NAME)
CONTAINER:=$(PROJECT_NAME)-$(PROJECT_VERSION)


build:
	@docker-compose \
		--file $(DIR)/docker-compose.yml \
		--project-name $(DOCKER_IMAGE):$(PROJECT_VERSION) \
		build

run: build
	@docker-compose up -d --build

down:
	@docker-compose down
