# dotfiles

Configures tmux, Vim, Neovim, and bash.

## Cloning Repositories

```
git clone --recursive <repo-url> dotfiles
cd dotfiles
```

## Repository Layout

- `home/`: dotfiles linked into `$HOME`
- `config/nvim/`: Neovim Lua config linked to `~/.config/nvim`
- `vim/pack/`: classic Vim package submodules linked to `~/.vim/pack`
- `tmux/oh-my-tmux/`: vendored Oh My Tmux base config
- `tmux/plugins/`: tmux plugin submodules
- `install/`: installer and health-check scripts

## Install Dotfiles

```
./install/setup.bash
```

Optional installs:

```
./install/setup.bash --install      # install git, tig, tree, tmux, ripgrep, bash-completion, python-is-python3, and Neovim
./install/setup.bash --install-vim  # link classic Vim and install Vim-only dependencies
```

Health check:

```
./install/health.bash
```

The setup script links by default:

- `home/.bash_profile` to `~/.bash_profile`
- `home/.bashrc` to `~/.bashrc`
- `home/.inputrc` to `~/.inputrc`
- `config/nvim` to `~/.config/nvim`
- `tmux/oh-my-tmux/.tmux.conf` to `~/.tmux.conf`
- `tmux/.tmux.conf.local` to `~/.tmux.conf.local`

If an existing target path is a real directory or file, the setup script skips it
rather than overwriting it. Move the existing path aside if you want dotfiles to
own it.

### Bash

The Bash config lives in `home/.bashrc`, and Readline settings live in `home/.inputrc`.

It provides:

- larger synchronized history across terminals
- prefix history search with Up and Down
- tab-cycled completion through Readline
- bash-completion integration when the package is installed
- `~/.local/bin` on `PATH` without duplicate entries
- idempotent `ssh-agent` startup for existing `id_ed25519` and `id_rsa` keys

### Vim

The classic Vim config lives in `home/.vimrc` and remains available as a fallback.
It is not linked by default; run `./install/setup.bash --install-vim` if you want setup
to manage `~/.vimrc`, `~/.vim/pack`, and the Vim-only plugin dependencies.

The classic Vim plugins are vendored as submodules under `vim/pack`:

- [ctrlp](https://github.com/ctrlpvim/ctrlp.vim): full path fuzzy file finder
- [lightline](https://github.com/itchyny/lightline.vim): nicer looking status bar
- [nerdtree](https://github.com/preservim/nerdtree): show file structure in a tree beside a page
- [papercolor-theme](https://github.com/NLKNguyen/papercolor-theme): pretty color theme
- [python-syntax](https://github.com/vim-python/python-syntax): python syntax highlighting
- [robotframework-vim](https://github.com/mfukar/robotframework-vim): robot syntax highlighting and filetype recognition
- [taglist.vim](https://github.com/yegappan/taglist): show overview of structure of code files
- [vim-gitbranch](https://github.com/itchyny/vim-gitbranch): show the git branch in lightline status bar
- [vim-prettier](https://github.com/prettier/vim-prettier): auto formatter for js, ts, css, json, markdown
- [vim-gitgutter](https://github.com/airblade/vim-gitgutter): shows the git changes in the column
- [vim-commentary](https://tpope.io/vim/commentary.git): allows simpler code commenting

### Neovim

The Neovim config lives in `config/nvim` and is written in Lua from scratch. It
uses lazy.nvim as the plugin manager and does not depend on the legacy Vim
package submodules.

It provides:

- editor defaults, search behaviour, splits, undo, statusline, and line numbers
- indentation and comment rules for common filetypes
- Robot Framework filetype detection for `*.robot`
- built-in file explorer through `:Explore`
- quickfix-based file listing through `:ProjectFiles`
- ripgrep search through `:ProjectGrep` when `rg` is installed
- built-in diagnostics
- git signs, hunk actions, and branch-aware statusline
- Mason-managed LSP servers for Python, Markdown, and Robot Framework
- Obsidian-style Markdown support through markdown-oxide
- Treesitter parser management and highlighting through nvim-treesitter
- Snacks.nvim utilities for fuzzy finding, large files, quick file loading, input, and notifications
- lazy.nvim plugin management with specs under `config/nvim/lua/plugins`

Mason-managed language servers:

- Python: `basedpyright` and `ruff`
- Markdown: `markdown_oxide`
- Robot Framework: `robotcode`

Neovim plugins:

- `lazy.nvim`
- `mason.nvim`
- `mason-lspconfig.nvim`
- `nvim-lspconfig`
- `nvim-treesitter`
- `snacks.nvim`
- `gitsigns.nvim`

Neovim commands:

- `:Explore`: open the built-in file explorer
- `:ProjectFiles`: open project files in the quickfix list
- `:ProjectGrep`: search project text with ripgrep and open matches in quickfix
- `:Format`: format the current buffer with an attached LSP formatter

Treesitter parser installation requires the `tree-sitter` CLI on `PATH`. If it
is missing, the plugin still installs but parser installation is skipped.

Neovim uses `,` as its leader key. Current custom Neovim key bindings:

- `<C-p>`: open the Snacks smart picker for fuzzy file finding
- `gd`: go to LSP definition
- `gD`: go to LSP declaration
- `gi`: go to LSP implementation
- `gr`: list LSP references
- `K`: show LSP hover
- `<leader>rn`: rename symbol
- `<leader>ca`: run code action in normal or visual mode
- `[d`: jump to the previous diagnostic
- `]d`: jump to the next diagnostic
- `<leader>e`: show diagnostic details
- `<leader>q`: send diagnostics to the location list
- `<leader>f`: format the current buffer through `:Format`
- `]h`: jump to the next git hunk
- `[h`: jump to the previous git hunk
- `<leader>hs`: stage the current git hunk, or the visual selection
- `<leader>hr`: reset the current git hunk, or the visual selection
- `<leader>hS`: stage the current buffer
- `<leader>hR`: reset the current buffer
- `<leader>hu`: undo the last staged hunk
- `<leader>hp`: preview the current git hunk
- `<leader>hb`: show blame for the current line

### Tmux

Tmux uses mouse mode, vi-style copy mode, a 50,000-line scrollback history, and
session restore through the vendored plugins under `tmux/plugins/`.

The tmux configuration will not be updated in existing sessions until all tmux
sessions are closed. Use `tmux ls` to determine which sessions are open, and use
`tmux a -t [SESSION NUMBER/NAME]` to attach to one.

- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect.git): resurrects tmux sessions
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum.git): continuously saves tmux sessions and restores them when a new tmux server starts

## Remap Keys

On Windows, download the Microsoft PowerToys from the Microsoft Store and then
set the CAPS LOCK button to ESC.

Otherwise, you can download the AutoHotKey program to do the same thing.

## Git Credential Store

This should work for multiple accounts i.e., GitLab and GitHub. However, if you
have multiple github accounts, then it won't work and you should use ssh as
mentioned below.

```
git config credential.helper store
git pull  # in the repository you want the credentials stored for
```

## Add Multiple Git Accounts (GitHub/GitLab)

```
ssh-keygen -t rsa -C "you@example.com"
```

Copy `cat ~/.ssh/id_rsa.pub` to SSH keys in GitHub/GitLab account.

Do the previous commands twice for the two different accounts. Make sure to name
the `id_rsa` file differently to distinguish the files.

Create a `config` file in `~/.ssh`. Add the following into the config file.

```
Host github.com
  HostName github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa_github

Host gitlab.example.com
  HostName gitlab.example.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa
```

Enter ``eval `ssh-agent -s` `` to avoid authentication errors.

Then delete the cached keys with `ssh-add -D`.

Next check if the keys were added with `ssh-add -l`.

If not, add your keys

```
ssh-add ~/.ssh/id_rsa_github
ssh-add ~/.ssh/id_rsa
```

Test connections with `ssh -T git@gitlab.example.com` and `ssh -T
git@github.com`.

If all goes well, clone the repo you wish to have.

Set local git config user details in your project folder.

```
git config user.name "Your Name"
git config user.email "you@example.com"
```

To set global git config user details, use the following. Note that local user
details overrides the global ones.

```
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

To see your config settings `git config --list`.
