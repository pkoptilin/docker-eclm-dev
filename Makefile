TAG=latest
_DOCKER_HOST := tcp://$(shell boot2docker ip):2376
_DOCKER_CERT_PATH := $(shell echo ~)/.boot2docker/certs/boot2docker-vm
_DOCKER_TLS_VERIFY := 1
CID := $(shell export DOCKER_TLS_VERIFY=$(_DOCKER_TLS_VERIFY);export DOCKER_HOST=$(_DOCKER_HOST);export DOCKER_CERT_PATH=$(_DOCKER_CERT_PATH);docker ps -l -q)
OPT := -H $(_DOCKER_HOST) --tlsverify --tlscacert="$(_DOCKER_CERT_PATH)/ca.pem" --tlscert="$(_DOCKER_CERT_PATH)/cert.pem" --tlskey="$(_DOCKER_CERT_PATH)/key.pem"
DOCKERC := @docker $(OPT)
INAME := eclm/development
CMD :=

build:
	$(DOCKERC) build --tag=$(INAME) .
run:
	$(DOCKERC) run -ti $(INAME):$(TAG)
debug:
	$(DOCKERC)
bash:
	$(DOCKERC) run -ti $(INAME):$(TAG) /bin/bash
commit:
	$(DOCKERC) commit $(CID) $(INAME):$(TAG)
stop:
	$(DOCKERC) stop $(CID)
show:
	$(DOCKERC) ps;\
	$(DOCKERC) logs $(CID)
log: 
	$(DOCKERC) logs -f $(CID)
clean:
	$(DOCKERC) stop $(INAME):$(TAG);
ps:
	$(DOCKERC) ps
help:
	@echo wildfly admin console: user:admin pass: Admin#70365
	@echo when deploy war, runtime name must be 'eclm.war'

all:clean,build,run

