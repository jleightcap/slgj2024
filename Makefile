SRCS = $(wildcard lib/*.fnl)

# NOTE: overridable with environment variables
# ```sh
# $ LOVE=./love-11.5-x86_64.AppImage make ...
# ```
FENNEL ?= fennel
LOVE ?= love

%.lua: %.fnl
	$(FENNEL) --compile $^ > $@

%.fmt: %.fnl
	fnlfmt --fix $^

all: $(SRCS:.fnl=.lua)

.PHONY: fmt
fmt: $(SRCS:.fnl=.fmt)

.PHONY: run
run: all
	$(LOVE) lib/
