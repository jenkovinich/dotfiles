# dotfiles

Configures tmux, vim, and bash.

## Cloning Repositories 

```
git clone git@gitlab.xiphos.ca:jkv/dotfiles.git
cd dotfiles
```

## Symlink Files

```
ln -s ~/dotfiles/.vimrc  ~/.vimrc
ln -s ~/dotfiles/.tmux.conf  ~/.tmux.conf
```

## Copy Bash File to Standard Location

```
cp ./.bashrc ~/
```

Note that the tmux configurations won't be updated until all the sessions are closed.

Use `tmux ls` to determine which sessions are open, and use `tmux a -t [SESSION NUMBER/NAME]` to go into that session.

## MacBook Only

In the .tmux.conf file, include this. Otherwise if you're in Linux or Windows, remove it because it will cause the tmux session to open and close immediately.

```
set-option -g default-shell /usr/local/bin/bash
```

## Add Multiple Git Accounts (GitHub/GitLab)

```
ssh-keygen -t rsa -C "email address"
```

Copy `cat ~/.ssh/id_rsa.pub` to SSH keys in GitHub/GitLab account.

Do the previous commands twice for the two different accounts. Make sure to name the `id_rsa` file differently to distinguish the files.

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

Test connections with `ssh -T git@gitlab.xiphos.com` and `ssh -T git@github.com`.

If all goes well, clone the repo you wish to have.

Set local git config user details in your project folder.

```
git config user.name "Jen Kovinich"
git config user.email "email address"
```

To set global git config user details, use the following. Note that local user details overrides the global ones.

```
git config --global user.name "Jen Kovinich"
git config --global user.email "email address"
```

To see your config settings `git config --list`.

## Resources for MacOS

* https://medium.com/@charlesdobson/how-to-customize-your-macos-terminal-7cce5823006e
* https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
* https://github.com/nathanbuchar/atom-one-dark-terminal
* https://www.cyberciti.biz/faq/change-default-shell-to-bash-on-macos-catalina/
* https://stackoverflow.com/questions/7780030/how-to-fix-terminal-not-loading-bashrc-on-os-x-lion
