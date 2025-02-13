ESC   := $(shell printf "\033")
CYAN  := $(ESC)[36m
GREEN := $(ESC)[32m
RED   := $(ESC)[31m
RESET := $(ESC)[0m

.DEFAULT_GOAL	:= help

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	while IFS=":" read -r target rest; do \
	    desc=$$(echo "$$rest" | sed -E 's/.*## (.*)/\1/'); \
	    status=""; \
	    color="\033[33m"; \
	    if grep -E -q "^$$target-test:" $(MAKEFILE_LIST); then \
	        if $(MAKE) -s $$target-test > /dev/null 2>&1; then \
	            status="set"; \
	            color="$(GREEN)"; \
	        else \
	            status="not set"; \
	            color="$(RED)"; \
	        fi; \
	    fi; \
		printf "$(CYAN)%-30s$(RESET) %-40s %s%s$(RESET)\n" "$$target" "$$desc" "$$color" "$$status"; \
	done
	
git: ## Set git config
	@test ! -f ${HOME}/.gitconfig || rm -f ${HOME}/.gitconfig
	@test ! -f ${HOME}/.gitignore || rm -f ${HOME}/.gitignore
	ln -sf ${PWD}/.gitconfig ${HOME}/.config/git/config
	ln -sf ${PWD}/.gitignore ${HOME}/.config/git/ignore

git-test:
	test ! -f ${HOME}/.gitconfig || exit 1
	test ! -f ${HOME}/.gitignore || exit 1
	test -L ${HOME}/.config/git/config && diff -q ${PWD}/.gitconfig ${HOME}/.config/git/config > /dev/null || exit 1
	test -L ${HOME}/.config/git/ignore && diff -q ${PWD}/.gitignore ${HOME}/.config/git/ignore > /dev/null && exit 0 || exit 1

bash: ## Set bash config
	@test -e ${HOME}/.profile && rm -r ${HOME}/.profile
	@test -e ${HOME}/.bashrc && rm -r ${HOME}/.bashrc
	@test -e ${HOME}/.profile.d && rm -r ${HOME}/.bashrc.d
	@test -e ${HOME}/.bashrc.d && rm -r ${HOME}/.bashrc.d

	cp ${PWD}/.paths ${HOME}/.paths
	ln -sf ${PWD}/.profile ${HOME}/.profile
	ln -sf ${PWD}/.profile.d ${HOME}/.profile.d
	ln -sf ${PWD}/.bashrc ${HOME}/.bashrc
	ln -sf ${PWD}/.bashrc.d ${HOME}/.bashrc.d
	ln -sf ${PWD}/.inputrc ${HOME}/.inputrc
	
bash-test:
	test -f ${HOME}/.paths || exit 1
	test -L ${HOME}/.profile && diff -q ${PWD}/.profile ${HOME}/.profile > /dev/null || exit 1
	test -L ${HOME}/.profile.d && diff -qr ${PWD}/.profile.d ${HOME}/.profile.d > /dev/null || exit 1
	test -L ${HOME}/.bashrc && diff -q ${PWD}/.bashrc ${HOME}/.bashrc > /dev/null || exit 1
	test -L ${HOME}/.bashrc.d && diff -qr ${PWD}/.bashrc.d ${HOME}/.bashrc.d > /dev/null || exit 1

neovim: ## Set neovim config
	mkdir -p ${HOME}/.config/nvim
	ln -sf ${PWD}/init.lua ${HOME}/.config/nvim/init.lua
	
	@if [ ! -f "${HOME}/.local/share/nvim/site/autoload/plug.vim" ]; then \
		curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi	

neovim-test:
	test -f ${HOME}/.local/share/nvim/site/autoload/plug.vim || exit 1
	test -L ${HOME}/.config/nvim/init.lua && diff -q ${PWD}/init.lua ${HOME}/.config/nvim/init.lua > /dev/null || exit 1

ghostty: ## Set ghostty terminal config
	mkdir -p ${HOME}/.config/ghostty
	ln -sf ${PWD}/ghostty.config ${HOME}/.config/ghostty/config

ghostty-test:
	test -L ${HOME}/.config/ghostty/config && diff -q ${PWD}/ghostty.config ${HOME}/.config/ghostty/config > /dev/null || exit 1

zed: ## Set zed editor config
	mkdir -p ${HOME}/.config/zed
	ln -sf ${PWD}/zed.keymap ${HOME}/.config/zed/keymap.json
	ln -sf ${PWD}/zed.settings ${HOME}/.config/zed/settings.json

zed-test:
	test -L ${HOME}/.config/zed/keymap.json && diff -q ${PWD}/zed.keymap ${HOME}/.config/zed/keymap.json > /dev/null || exit 1
	test -L ${HOME}/.config/zed/settings.json && diff -q ${PWD}/zed.settings ${HOME}/.config/zed/settings.json > /dev/null || exit 1

zellij: ## Set zellij terminal multiplexer config
	mkdir -p ${HOME}/.config/zellij
	ln -sf ${PWD}/zellij.config ${HOME}/.config/zellij/config.kdl

zellij-test:
	test -L ${HOME}/.config/zellij/config.kdl && diff -q ${PWD}/zellij.config ${HOME}/.config/zellij/config.kdl > /dev/null || exit 1

