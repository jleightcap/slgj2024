SRC = lib/main.fnl

FENNEL ?= fennel
LOVE ?= love

%.lua: %.fnl
	$(FENNEL) --compile $^ > $@

all: $(SRC:.fnl=.lua)

.PHONY: run
run: all
	$(LOVE) lib/
