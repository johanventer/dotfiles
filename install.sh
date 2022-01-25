#!/bin/bash

if ! [ -d ~/.config/nvim ]; then
	mkdir -p ~/.config/nvim
fi

ln -fsv "$(pwd)/nvim/init.vim" ~/.config/nvim
ln -fsv "$(pwd)/zshrc" ~/.zshrc
ln -fsv "$(pwd)/tmux.conf" ~/.tmux.conf

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
