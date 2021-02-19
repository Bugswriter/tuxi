.POSIX:

PREFIX = /usr/local

all: install

tuxi:

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp tuxi ${DESTDIR}${PREFIX}/bin/tuxi
	cp tuxi.1 ${DESTDIR}${PREFIX}/man/man1
	gzip ${DESTDIR}${PREFIX}/man/man1/tuxi.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/tuxi

.PHONY: all install uninstall
