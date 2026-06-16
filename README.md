# dotfiles

Configures tmux, Vim, Neovim, and bash.

## Cloning Repositories

```
git clone --recursive <repo-url> dotfiles
cd dotfiles
```

## Install Dotfiles

```
./setup.bash
```

Note that the tmux configurations won't be updated until all the sessions are
closed.

Use `tmux ls` to determine which sessions are open, and use `tmux a -t [SESSION
NUMBER/NAME]` to go into that session.

### Vim

The classic Vim config lives in `.vimrc` and remains available as a fallback.

### Neovim

The Neovim config lives in `.config/nvim` and is written in Lua from scratch. It
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
- Mason-managed LSP servers for Python, Markdown, and Robot Framework
- Obsidian-style Markdown support through markdown-oxide
- Treesitter parser management and highlighting through nvim-treesitter
- Snacks.nvim utilities for fuzzy finding, large files, quick file loading, input, and notifications
- lazy.nvim plugin management with specs under `.config/nvim/lua/plugins`

The setup script links:

- `.config/nvim` to `~/.config/nvim`
- `.vimrc` to `~/.vimrc`
- `pack` to `~/.vim/pack`

If an existing target path is a real directory or file, the setup script skips it
rather than overwriting it. Move the existing path aside if you want dotfiles to
own it.

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

Treesitter parser installation requires the `tree-sitter` CLI on `PATH`. If it
is missing, the plugin still installs but parser installation is skipped.

Neovim uses `,` as its leader key. Current custom Neovim key bindings:

- `<C-p>` opens the Snacks smart picker for fuzzy file finding

Future Neovim improvements may include a statusline and git signs.

### Vim And Neovim Plugins

The following plugins should be installed.

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

### TMUX Plugins

- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect.git): resurrects tmux sessions

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
