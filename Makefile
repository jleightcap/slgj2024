SRCS = $(wildcard src/*.fnl)

FENNEL ?= fennel
LOVE ?= love

%.lua: %.fnl
	$(FENNEL) --compile $^ > $@

%.fmt: %.fnl
	fnlfmt --fix $^

all: $(SRCS:.fnl=.lua)

dist: soko-bin.zip

soko-bin.zip: all
	zip -r $@ src/

.PHONY: fmt
fmt: $(SRCS:.fnl=.fmt)

.PHONY: run
run: all
	$(LOVE) src/
