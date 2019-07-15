#!/bin/bash

if [ -d ~/.config/nvim ]; then
	ln -fsv "$(pwd)/nvim/init.vim" ~/.config/nvim
	ln -fsv "$(pwd)/nvim/coc-settings.json" ~/.config/nvim
fi
