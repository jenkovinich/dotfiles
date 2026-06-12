#!/bin/bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install_neovim=false

for arg in "$@"; do
    case "$arg" in
        --install-neovim)
            install_neovim=true
            ;;
        -h|--help)
            echo "Usage: $0 [--install-neovim]"
            exit 0
            ;;
        *)
            echo "Unknown option: $arg" >&2
            exit 2
            ;;
    esac
done

link_path() {
    local source_path="$1"
    local target_path="$2"

    if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "Skipping $target_path; it exists and is not a symlink"
        return 0
    fi

    ln -sfnT "$source_path" "$target_path"
}

install_neovim_from_tarball() {
    local archive="/tmp/nvim-linux-x86_64.tar.gz"
    local install_dir="/opt/nvim-linux-x86_64"
    local nvim_link="/usr/local/bin/nvim"

    if ! command -v curl > /dev/null 2>&1; then
        echo "curl is required to install Neovim from the official tarball" >&2
        return 1
    fi

    echo "Installing Neovim from the official tarball"
    curl -fL --retry 3 \
        https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
        -o "$archive"
    sudo rm -rf "$install_dir"
    sudo tar -C /opt -xzf "$archive"

    if [ -e "$nvim_link" ] && [ ! -L "$nvim_link" ]; then
        echo "Skipping $nvim_link; it exists and is not a symlink"
    else
        sudo ln -sfn "$install_dir/bin/nvim" "$nvim_link"
    fi

    "$install_dir/bin/nvim" --version | sed -n '1p'
}

## General Installs
#git submodule update --init --recursive
#sudo apt update
#sudo apt upgrade -y
#sudo apt install git tig tree curl ripgrep -y

if [ "$install_neovim" = true ]; then
    install_neovim_from_tarball
fi

## Needed for vim-prettier
#sudo apt install nodejs npm -y
#sudo npm install n -g
#sudo n stable
#hash -r
#sudo npm install -g prettier

## Needed for taglist.vim
#sudo apt install exuberant-ctags -y

## BASH
link_path "$repo_dir/.bashrc" "$HOME/.bashrc"

## VIM
link_path "$repo_dir/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.vim"
link_path "$repo_dir/pack" "$HOME/.vim/pack"

## NEOVIM
mkdir -p "$HOME/.config"
link_path "$repo_dir/.config/nvim" "$HOME/.config/nvim"

## TMUX
link_path "$repo_dir/.tmux/.tmux.conf" "$HOME/.tmux.conf"
link_path "$repo_dir/.tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"

## DONE
echo All Configured
