#!/bin/bash

cp ./.bashrc ~/
ln -s ~/dotfiles/.vimrc ~/.vimrc
mkdir ~/.vim/
cp -r ~/dotfiles/pack/ ~/.vim/
ln -s -f ~/dotfiles/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/dotfiles/.tmux/.tmux.conf.local ~/.tmux.conf.local

source ~/.bashrc

echo Done Setup
