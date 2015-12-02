TAG = archlinux-spiderfoot
NAME = spiderfoot

all:
	echo "Usage: make <build|run>"

build:
	docker build -t $(TAG) .

run:
	docker run -d -p 8000:8000 --name $(NAME) $(TAG)

.PHONY: all build run
.SILENT: all build run
