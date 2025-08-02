PREFIX = /usr
MANDIR = $(PREFIX)/share/man

all:
	@printf "Run 'make install' to install mfetch.\n"

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(MANDIR)/man1
	@mkdir -p $(DESTDIR)$(PREFIX)/share
	@mkdir -p $(DESTDIR)$(PREFIX)/share/mfetch
	@mkdir -p $(DESTDIR)$(PREFIX)/share/mfetch/baz_plugin
	@cp -p mfetch $(DESTDIR)$(PREFIX)/bin/mfetch
	@cp -p mfetch.1 $(DESTDIR)$(MANDIR)/man1/mfetch.1
	@cp -p baz.env $(DESTDIR)$(PREFIX)/share/mfetch/baz_plugin/baz.env
	@cp -pr hooks $(DESTDIR)$(PREFIX)/share/mfetch/baz_plugin/hooks
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/mfetch
	@cd $(DESTDIR)$(PREFIX)/bin && ln -sf mfetch neofetch

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/mfetch
	@rm -rf $(DESTDIR)$(PREFIX)/bin/neofetch
	@rm -rf $(DESTDIR)$(MANDIR)/man1/mfetch.1*
	@rm -rf $(DESTDIR)$(PREFIX)/share/mfetch
