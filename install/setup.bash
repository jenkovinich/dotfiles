#!/bin/bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
install_setup_tools_requested=false
install_classic_vim=false

for arg in "$@"; do
    case "$arg" in
        --install)
            install_setup_tools_requested=true
            ;;
        --install-vim)
            install_classic_vim=true
            ;;
        -h|--help)
            echo "Usage: $0 [--install] [--install-vim]"
            echo "  --install      Install git, tig, tree, bash-completion, python-is-python3, and Neovim."
            echo "  --install-vim  Link classic Vim config and install Vim-only dependencies."
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

require_apt_get() {
    if ! command -v apt-get > /dev/null 2>&1; then
        echo "apt-get is required for this install option" >&2
        return 1
    fi
}

install_setup_tools() {
    require_apt_get
    sudo apt-get update
    sudo apt-get install git tig tree bash-completion curl python-is-python3 -y
    install_neovim_from_tarball
}

install_classic_vim_support() {
    require_apt_get
    sudo apt-get update
    sudo apt-get install vim nodejs npm -y
    if ! sudo apt-get install exuberant-ctags -y; then
        sudo apt-get install universal-ctags -y
    fi

    if ! command -v prettier > /dev/null 2>&1; then
        sudo npm install -g prettier
    fi
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

if [ "$install_setup_tools_requested" = true ]; then
    install_setup_tools
fi

if [ "$install_classic_vim" = true ]; then
    install_classic_vim_support
fi

## BASH
link_path "$repo_dir/home/.bash_profile" "$HOME/.bash_profile"
link_path "$repo_dir/home/.bashrc" "$HOME/.bashrc"
link_path "$repo_dir/home/.inputrc" "$HOME/.inputrc"

## NEOVIM
mkdir -p "$HOME/.config"
link_path "$repo_dir/config/nvim" "$HOME/.config/nvim"

## CLASSIC VIM (optional fallback)
if [ "$install_classic_vim" = true ]; then
    link_path "$repo_dir/home/.vimrc" "$HOME/.vimrc"
    mkdir -p "$HOME/.vim"
    link_path "$repo_dir/vim/pack" "$HOME/.vim/pack"
fi

## TMUX
link_path "$repo_dir/tmux/oh-my-tmux/.tmux.conf" "$HOME/.tmux.conf"
link_path "$repo_dir/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"

## DONE
echo All Configured
