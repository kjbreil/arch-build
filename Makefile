NS = kjbreil
VERSION ?= $(shell date +'%Y.%m.%d')

REPO = arch-build
NAME = arch-build
INSTANCE = default

PKGS=pacman
ROOTFS=/arch-root

.PHONY: image push push_latest shell run start stop rm release

default: no-cache release

image:
	docker build -t $(NS)/$(REPO) -t $(NS)/$(REPO):$(VERSION) .

no-cache:
	docker build --no-cache -t $(NS)/$(REPO) -t $(NS)/$(REPO):$(VERSION) .

push:
	docker push $(NS)/$(REPO):$(VERSION)
	docker push $(NS)/$(REPO):latest

shell:
	docker run --rm --name $(NAME)-$(INSTANCE) -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION) /bin/bash

run:
	docker run --rm --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

start:
	docker run -d --name $(NAME)-$(INSTANCE) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

stop:
	docker stop $(NAME)-$(INSTANCE)

rm:
	docker rm $(NAME)-$(INSTANCE)

release: image push
