#!/bin/bash

## General Installs
#sudo apt update
#sudo apt upgrade -y
#sudo apt install xsel tig git curl -y

## Needed for taglist.vim
#sudo apt install exuberant-ctags

## Needed for YouCompleteMe
#sudo apt install build-essential cmake vim-nox python3-dev -y
#sudo apt install nodejs openjdk-17-jdk openjdk-17-jre npm -y

## BASH
cp ./.bashrc ~/

## VIM
sudo rm -rf ~/.vim/
ln -s -f $PWD/.vimrc ~/.vimrc
mkdir ~/.vim/
cp -r $PWD/pack/ ~/.vim/

## TMUX
ln -s -f $PWD/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f $PWD/.tmux/.tmux.conf.local ~/.tmux.conf.local

## YouCompleteMe
pushd ~/.vim/pack/YouCompleteMe/start/YouCompleteMe
python3 install.py --clangd-completer --ts-completer --rust-completer --java-completer
popd

echo All Configured
