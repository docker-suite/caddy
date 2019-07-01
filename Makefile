DIR:=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))
PROJECT_NAME:=$(strip $(shell basename $(DIR)))
DOCKER_IMAGE=dsuite/$(PROJECT_NAME)


build: build-0.10 build-0.11 build-1.0

test: test-0.10 test-0.11 test-1.0

push: push-0.10 push-0.11 push-1.0

build-0.10:
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-0.10 \
		--tag $(DOCKER_IMAGE):0.10 \
		$(DIR)/Dockerfiles

build-0.11:
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-0.11 \
		--tag $(DOCKER_IMAGE):0.11 \
		$(DIR)/Dockerfiles

build-1.0:
	@docker build \
		--build-arg http_proxy=${http_proxy} \
		--build-arg https_proxy=${https_proxy} \
		--file $(DIR)/Dockerfiles/Dockerfile-1.0 \
		--tag $(DOCKER_IMAGE):1.0 \
		$(DIR)/Dockerfiles


test-0.10: build-0.10
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e CADDY=0.10 --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):0.10

test-0.11: build-0.11
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e CADDY=0.11 --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):0.11

test-1.0: build-1.0
	@docker run --rm -t \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-v $(DIR)/tests:/goss \
		-v /tmp:/tmp \
		-v /var/run/docker.sock:/var/run/docker.sock \
		dsuite/goss:latest \
		dgoss run -e CADDY=1.0 --entrypoint=/goss/entrypoint.sh $(DOCKER_IMAGE):1.0

push-0.10: build-0.10
	@docker push $(DOCKER_IMAGE):0.10

push-0.11: build-0.11
	@docker push $(DOCKER_IMAGE):0.11

push-1.0: build-1.0
	@docker push $(DOCKER_IMAGE):1.0


shell-0.10: build-0.10
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		$(DOCKER_IMAGE):0.10 \
		bash

shell-0.11: build-0.11
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		$(DOCKER_IMAGE):0.11 \
		bash

shell-1.0: build-1.0
	@docker run -it --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		$(DOCKER_IMAGE):1.0 \
		bash

remove:
	@if [ $(shell docker images -f "dangling=true" -q | wc -l) -gt 0 ]; then \
		docker rmi -f $(shell docker images -f "dangling=true" -q); \
	fi
	@docker images | grep $(DOCKER_IMAGE) | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} docker rmi $(DOCKER_IMAGE):{}

readme:
	@docker run -t --rm \
		-e http_proxy=${http_proxy} \
		-e https_proxy=${https_proxy} \
		-e DEBUG_LEVEL=DEBUG \
		-e DOCKER_USERNAME=${DOCKER_USERNAME} \
		-e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
		-e DOCKER_IMAGE=${DOCKER_IMAGE} \
		-v $(DIR):/data \
		dsuite/hub-updater
