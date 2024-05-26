SRCS = $(wildcard src/*.fnl)

FENNEL ?= fennel
LOVE ?= love

all: out/conf.lua out/engine.lua out/main.lua out/parse.lua out/style.lua

out/%.lua: src/%.fnl
	$(FENNEL) --compile $^ > $@

%.fmt: %.fnl
	fnlfmt --fix $^

dist: soko-bin.love

soko-bin.love: all
	cd out/ && zip -r ../$@ .

.PHONY: fmt
fmt: $(SRCS:.fnl=.fmt)

.PHONY: run
run: all
	$(LOVE) out/

.PHONY: clean
clean:
	rm out/*.lua
	rm soko-bin.love
