# dotfiles

Configures tmux, vim, and bash.

## Cloning Repositories

```
git clone --recursive git@github.com:jenkovinich/dotfiles.git
git clone --recursive https://github.com/jenkovinich/dotfiles.git
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

### Vim Plugins

The follow plugins should be installed.

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
ssh-keygen -t rsa -C "email address"
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

Host gitlab.xiphos.com
  HostName gitlab.xiphos.com
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

Test connections with `ssh -T git@gitlab.xiphos.com` and `ssh -T
git@github.com`.

If all goes well, clone the repo you wish to have.

Set local git config user details in your project folder.

```
git config user.name "Jen Kovinich"
git config user.email "email address"
```

To set global git config user details, use the following. Note that local user
details overrides the global ones.

```
git config --global user.name "Jen Kovinich"
git config --global user.email "email address"
```

To see your config settings `git config --list`.
