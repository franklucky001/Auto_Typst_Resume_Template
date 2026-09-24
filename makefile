.DEFAULT_GOAL := all

TYPST ?= typst
TYPST_FLAGS ?=

all: zh en

zh:
	$(TYPST) compile --root . --font-path fonts $(TYPST_FLAGS) src/chinese.typ 个人简历.pdf

en:
	$(TYPST) compile --root . --font-path fonts $(TYPST_FLAGS) src/english.typ Resume.pdf

build: all

check:
	TYPST="$(TYPST)" sh tests/check.sh

clean:
	rm -f -- 个人简历.pdf Resume.pdf

.PHONY: all zh en build check clean
