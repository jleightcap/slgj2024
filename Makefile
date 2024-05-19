SRCS = $(wildcard lib/*.fnl)

FENNEL ?= fennel
LOVE ?= love

%.lua: %.fnl
	$(FENNEL) --compile $^ > $@

all: $(SRCS:.fnl=.lua)

.PHONY: run
run: all
	$(LOVE) lib/
