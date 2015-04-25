# Installs extensions and compiles things that need compiling.
#
# Origin: github.com/markstory/vim-files
#

help:
	@echo "install - install + compile native things."
	@echo "update  - Download update for all plugins."

install: submodules

submodules:
	git submodule init
	git submodule update

update:
	git submodule foreach git checkout master
	git submodule foreach git pull origin master
