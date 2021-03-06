TAG=latest
_DOCKER_HOST := tcp://$(shell boot2docker ip):2376
_DOCKER_CERT_PATH := $(shell echo ~)/.boot2docker/certs/boot2docker-vm
_DOCKER_TLS_VERIFY := 1
#OPT := -H $(_DOCKER_HOST) --tlsverify --tlscacert="$(_DOCKER_CERT_PATH)/ca.pem" --tlscert="$(_DOCKER_CERT_PATH)/cert.pem" --tlskey="$(_DOCKER_CERT_PATH)/key.pem"
OPT :=
DOCKERC := docker $(OPT)
CID := $(shell docker $(OPT) ps -l -q )
CNAME :=
LINK :=
PORTS :=
INAME := eclm/development
CMD :=

init:
	@boot2docker shellinit
build:
	$(DOCKERC) build --tag=$(INAME) .
run:
	$(DOCKERC) run -d $(CNAME) $(PORTS) $(LINK) $(INAME):$(TAG)
bash:
	$(DOCKERC) run -ti $(PORTS) $(LINK) $(INAME):$(TAG) /bin/bash
commit:
	$(DOCKERC) commit $(CID) $(INAME):$(TAG)
stop:
	$(DOCKERC) stop $(CID)
show:
	@$(DOCKERC) ps; $(DOCKERC) logs $(CID)
log: 
	@$(DOCKERC) logs -f $(CID)
clean:
	$(DOCKERC) stop $(INAME):$(TAG);
ps:
	@$(DOCKERC) ps
all:clean,build,run
help:
	@echo docker helper
	@echo Commands:
	@echo "     build"
	@echo "     run"
	@echo "     bash"
	@echo "     commit TAG=tag"
	@echo "     stop"
	@echo "     clean"
	@echo "     ps"
	@echo "     help"
	@echo -----------------------------------------

