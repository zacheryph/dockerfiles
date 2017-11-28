.PHONY: all link update test shellcheck

all: update link

COMPOSE_VERSION := 1.17.1

# Update run commands from external sources
update:
	@echo "== updating external run configurations"
	@mkdir -p docker-compose
	@curl -L --fail --silent -o docker-compose/run https://github.com/docker/compose/releases/download/$(COMPOSE_VERSION)/run.sh
	@chmod +x docker-compose/run

link:
	@exec ./port.sh install

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

test: shellcheck

shellcheck:
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		--entrypoint ./test.sh \
		zacheryph/shellcheck
