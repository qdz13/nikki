PREFIX = /usr/local
ZSHCOMPPREFIX = ${PREFIX}/share/zsh/site-functions
RM = rm -f

all:
	@echo 'Run "make install" to install nikki.'

install:
	mkdir -p ${DESTDIR}${PREFIX}/bin
	install -Dm755 nikki ${DESTDIR}${PREFIX}/bin/nikki
	mkdir -p ${DESTDIR}${ZSHCOMPPREFIX}
	install -Dm644 completions/zsh/_nikki ${DESTDIR}${ZSHCOMPPREFIX}/_nikki

uninstall:
	${RM} ${DESTDIR}${PREFIX}/bin/nikki ${DESTDIR}${ZSHCOMPPREFIX}/_nikki

.PHONY: all install uninstall
