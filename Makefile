.POSIX:

PREFIX = ~/.local

all: install

tuxi:

install: language
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp tuxi ${DESTDIR}${PREFIX}/bin/tuxi

language:
	sed -i 's/^LANGUAGE=""/LANGUAGE="${LANGUAGE}"/' tuxi

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/tuxi

.PHONY: all install uninstall
