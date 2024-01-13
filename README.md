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

## Install Plugins

```
cp -r ./pack/ ~/.vim/
```

## AutoHotKeys

This is to allow the remapping of the keys in Windows.

Currently, this is configured for use with the CAPS Lock Key to ESC.

```
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
