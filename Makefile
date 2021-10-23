.PHONY: all upgrade compile dev

all:
	$(MAKE) upgrade
	$(MAKE) compile

upgrade:
	@./rebar3 upgrade

compile:
	@./rebar3 xref


dev: compile
	@./rebar3 as dev release
	./_build/dev/rel/cowboy_ws/bin/cowboy_ws console

