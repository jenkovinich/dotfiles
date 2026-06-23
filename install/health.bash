#!/bin/bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
failures=0

ok() {
    printf 'ok: %s\n' "$1"
}

warn() {
    printf 'warn: %s\n' "$1"
}

fail() {
    printf 'fail: %s\n' "$1"
    failures=$((failures + 1))
}

check_link() {
    local source_path="$1"
    local target_path="$2"
    local required="${3:-required}"
    local expected="$repo_dir/$source_path"
    local actual

    if [ ! -L "$target_path" ]; then
        if [ "$required" = "optional" ]; then
            warn "$target_path is not a symlink to $source_path"
        else
            fail "$target_path is not a symlink to $source_path"
        fi
        return
    fi

    actual="$(readlink "$target_path")"
    if [ "$actual" = "$expected" ]; then
        ok "$target_path -> $source_path"
    elif [ "$required" = "optional" ]; then
        warn "$target_path points to $actual, expected $expected"
    else
        fail "$target_path points to $actual, expected $expected"
    fi
}

check_dir() {
    local path="$1"
    if [ -d "$repo_dir/$path" ]; then
        ok "$path exists"
    else
        fail "$path is missing"
    fi
}

check_command() {
    local command_name="$1"
    local required="${2:-required}"

    if command -v "$command_name" >/dev/null 2>&1; then
        ok "$command_name is installed"
    elif [ "$required" = "optional" ]; then
        warn "$command_name is not installed"
    else
        fail "$command_name is not installed"
    fi
}

check_link "home/.bash_profile" "$HOME/.bash_profile"
check_link "home/.bashrc" "$HOME/.bashrc"
check_link "home/.inputrc" "$HOME/.inputrc"
check_link "home/.vimrc" "$HOME/.vimrc" optional
check_link "vim/pack" "$HOME/.vim/pack" optional
check_link "config/nvim" "$HOME/.config/nvim"
check_link "tmux/oh-my-tmux/.tmux.conf" "$HOME/.tmux.conf"
check_link "tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"

check_dir "vim/pack"
check_dir "tmux/plugins/tmux-resurrect"
check_dir "tmux/plugins/tmux-continuum"

check_command git
check_command tmux
check_command nvim
check_command rg optional
check_command tree-sitter optional

if [ "$failures" -gt 0 ]; then
    printf '\n%d health check(s) failed\n' "$failures"
    exit 1
fi

printf '\nAll required health checks passed\n'
