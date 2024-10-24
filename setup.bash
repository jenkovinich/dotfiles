#!/bin/bash

sudo apt install xsel -y
sudo apt install build-essential cmake vim-nox python3-dev -y
sudo apt install mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm -y

rm -rf ~/.vim/
cp ./.bashrc ~/
ln -s -f $PWD/.vimrc ~/.vimrc
mkdir ~/.vim/
cp -r $PWD/pack/ ~/.vim/
ln -s -f $PWD/.tmux/.tmux.conf ~/.tmux.conf
ln -s -f $PWD/.tmux/.tmux.conf.local ~/.tmux.conf.local

pushd ~/.vim/pack/YouCompleteMe/start/YouCompleteMe
./install.py --all
popd

echo Done Setup

source ~/.bashrc
