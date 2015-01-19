BSDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

NAME = log-forwarder
IMAGE = lotreal/logstash-forwarder

define docker_run_flags
--link log-lumberjack:log-lumberjack \
--volumes-from log-lumberjack \
--volume /var/log:/var/log \
--volume ${BSDIR}/etc/forwarder.json:/etc/logstash/forwarder.json
endef


.PHONY: test
test:
	docker run --rm -it $(docker_run_flags) $(IMAGE) bash

.PHONY: build
build:
	docker build --tag $(IMAGE) .

.PHONY: run
run:
	docker run --rm --name $(NAME) $(docker_run_flags) $(IMAGE)

.PHONY: shell
shell:
	docker exec -it $(NAME) bash
