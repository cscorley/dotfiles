# Installs extensions and compiles things that need compiling.
#
# Origin: github.com/markstory/vim-files
#

help:
	@echo "install - install + compile native things."
	@echo "update  - Download update for all plugins."

install: symlink submodules

submodules:
	git submodule init
	git submodule update

update:
	git submodule foreach git pull origin master 

symlinkforce:
	for file in `ls -A $(CURDIR)/dots`; do \
		ln -sf "$(CURDIR)/dots/$$file" ~/$$file ; \
	done

symlink:
	for file in `ls -A $(CURDIR)/dots`; do \
		ln -si "$(CURDIR)/dots/$$file" ~/$$file ; \
	done

test:
	for file in `ls -A $(CURDIR)/dots`; do \
		echo "ln -si" "$(CURDIR)/dots/$$file" "~/$$file" ; \
	done
