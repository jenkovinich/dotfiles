# dotfiles

Configures tmux and vim.

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
