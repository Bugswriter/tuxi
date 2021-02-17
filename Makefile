.POSIX:

PREFIX = ~/.local

all: install

tuxi:

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp tuxi ${DESTDIR}${PREFIX}/bin/tuxi

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/tuxi

.PHONY: all install uninstall
