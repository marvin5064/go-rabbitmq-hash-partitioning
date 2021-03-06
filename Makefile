
SHELL := /bin/bash

.PHONY: producer consumer
default: all
all: build

run: build
	@echo " -- starting consumer 1"
	@./example/consumer/consumer -tag c1 &
	@echo " -- starting producer"
	@./example/producer/producer &
	@sleep 3
	@echo " -- starting consumer 2"
	@./example/consumer/consumer -tag c2 &
	@sleep 3
	@echo " -- starting consumer 3"
	@./example/consumer/consumer -tag c3 &
	@sleep 3
	@echo " -- shutting down example"
	@killall producer
	@killall consumer

build: producer consumer

producer:
	$(MAKE) -C ./example/$@

consumer:
	$(MAKE) -C ./example/$@

rabbitmq:
	docker run -d \
		-p 127.0.0.1:5672:5672 \
		-p 127.0.0.1:15672:15672 \
		--name rabbitmq-management rabbitmq:management-alpine

