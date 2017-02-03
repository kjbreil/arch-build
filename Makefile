NS = kjbreil
VERSION ?= $(shell date +'%Y.%m.%d')

REPO = arch-build
NAME = arch-build
INSTANCE = default

PKGS=pacman
ROOTFS=/arch-root

.PHONY: image push push_latest shell run start stop rm release

image:
	docker build --no-cache -t $(NS)/$(REPO) -t $(NS)/$(REPO) -t $(NS)/$(REPO):$(VERSION) .

push:
	docker push $(NS)/$(REPO):$(VERSION)
	docker push $(NS)/$(REPO):latest

heim:
	docker tag $(NS)/$(REPO):$(VERSION) heimdall.norgenet.net:5000/$(REPO):$(VERSION)
	docker tag $(NS)/$(REPO):$(VERSION) heimdall.norgenet.net:5000/$(REPO)
	docker push heimdall.norgenet.net:5000/$(REPO):$(VERSION)
	docker push heimdall.norgenet.net:5000/$(REPO)

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

default: image

release: image push

inside:
	mkdir -p $(ROOTFS)
	pacstrap -c -d -G $(ROOTFS) $(PKGS)
	rm -f root.tar.xz root.tar
	tar --numeric-owner --xattrs --acls -C "$(ROOTFS)" -c . | xz -f -vvv -9 -e --lzma2=dict=128MiB > root.tar.xz