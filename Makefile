TARGETS=.targets
WEB=docker-compose run web


# Interface


## Setup
.PHONY: _build
_build: $(TARGETS)/build

.PHONY: _setup
_setup: $(TARGETS)/setup

.PHONY: reset
reset:
	$(WEB) mix ecto.reset


## App lifecycle
.PHONY: _start start
_start:
	docker-compose up
start: | _build _setup migrate _start


## Misc
.PHONY: console
console:
	$(WEB) iex -S mix

.PHONY: routes
routes:
	$(WEB) mix phoenix.routes

.PHONY: test
test:
	$(WEB) mix test

.PHONY: bash
bash:
	$(WEB) bash

.PHONY: deps
deps:
	$(WEB) mix deps.clean --unused --unlock
	$(WEB) mix do deps.get, deps.compile

.PHONY: migrate
migrate: $(TARGETS)/migrate

.PHONY: seed
seed:
	$(WEB) mix run priv/repo/seeds.exs


# Tasks


$(TARGETS)/build: mix.exs mix.lock Dockerfile
	docker-compose build
	touch $@

$(TARGETS)/setup: mix.exs mix.lock package.json
	$(WEB) mix do deps.get, ecto.setup
	$(WEB) npm install
	touch $@

$(TARGETS)/migrate: $(wildcard priv/repo/migrations/*)
	$(WEB) mix ecto.migrate
	touch $@
