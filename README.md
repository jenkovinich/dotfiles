# dotfiles

Configures tmux, vim, and bash.

## Setup

```
git clone git@gitlab.xiphos.ca:jkv/dotfiles.git
cd dotfiles
```

## To Symlink Files

```
ln -s ~/dotfiles/.vimrc  ~/.vimrc
ln -s ~/dotfiles/.tmux.conf  ~/.tmux.conf
```

## Copy Bash File to Standard Location

```
cp ./.bashrc ~/
```

Note that the tmux configurations won't be updated until all the sessions are closed.

Use `tmux list-sessions` to determine which sessions are open, and use `tmux attach-session -t [SESSION NUMBER]` to go into that session.

# Add Multiple Git Accounts (GitHub/GitLab)

```
ssh-keygen -t rsa -C "email address"
```

Copy `cat ~/.ssh/id_rsa.pub` to SSH keys in GitHub/GitLab account.

Create a `config` files in `~/.ssh`.

Add into the config:

```
Host github.com
  HostName github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa_name

Host gitlab.xiphos.com
  HostName gitlab.xiphos.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa
```

Test connections `ssh -T git@gitlab.xiphos.com` and `ssh -T git@github.com`.

Then delete the cached keys: `ssh-add -D`

If the error message appears, enter `eval `ssh-agent -s``, and try the previous command again.

Next check if the keys were added: `ssh-add -l`.

If not, add your keys

```
ssh-add ~/.ssh/id_rsa_name
ssh-add ~/.ssh/id_rsa
```

Set git config user details in your project folder:

```
git config user.name "Jen Kovinich"
git config user.email "email address"
```

To see your config settings `git config --list`.
