DOTFILES = \
	   tmux.conf \
	   vimrc

install:
	@for f in ${DOTFILES}; do \
		echo Installing $$f to ${HOME}"; \
		ln -sf ${PWD}/$$f ${HOME}/.$$f; \
	done
