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
		if [[ -d ~/$$file ]] ; then \
			rm -rf ~/$$file ; \
		fi ; \
		ln -sf "$(CURDIR)/dots/$$file" ~/$$file ; \
	done

symlink:
	for file in `ls -A $(CURDIR)/dots`; do \
		if [[ -d ~/$$file ]] ; then \
			if [[ -L ~/$$file ]] ; then \
				rm -i ~/$$file ; \
				if [[ ! -e ~/$$file ]] ; then \
					ln -si "$(CURDIR)/dots/$$file" ~/$$file ; \
				fi ; \
			else \
				echo "Directory ~/$$file exists, please remove it."; \
				exit; \
			fi ; \
		else \
			ln -si "$(CURDIR)/dots/$$file" ~/$$file ; \
		fi ; \
	done

test:
	for file in `ls -A $(CURDIR)/dots`; do \
		echo "ln -si" "$(CURDIR)/dots/$$file" "~/$$file" ; \
	done
