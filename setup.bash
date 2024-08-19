#!/bin/bash

sudo apt install xsel -y

cp ./.bashrc ~/
ln -s $PWD/.vimrc ~/.vimrc
mkdir ~/.vim/
cp -r $PWD/pack/ ~/.vim/
ln -s -f $PWD/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f $PWD/.tmux/.tmux.conf.local ~/.tmux.conf.local

source ~/.bashrc

echo Done Setup
