NAME = $(shell basename `pwd | sed -e 's|docker-||g'`)
TAG = $(shell date +%m%d)
IMG = libcrack/$(NAME)
PORT = 8000


help:
	echo "Usage: make <build|run|help>"

build:
	docker build -t $(IMG):$(TAG) .

run:
	docker run -d -p $(PORT):$(PORT) --name $(NAME) $(TAG)

.PHONY: help build run
.SILENT: help
