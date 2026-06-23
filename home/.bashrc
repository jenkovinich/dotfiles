# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines, lines starting with space, or older duplicates in history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=100000

sync_bash_history() {
    history -a
    history -n
}

case ";${PROMPT_COMMAND:-};" in
    *";sync_bash_history;"*) ;;
    *) PROMPT_COMMAND="sync_bash_history${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# add git branch if its present to PS1
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[01;35m\]$(parse_git_branch) \[\033[00m\]\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch) \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias clear='clear -x'
alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export EDITOR="${EDITOR:-nvim}"
export GIT_EDITOR=nvim
export MANPAGER='nvim +Man!'
export DIFFPROG="$EDITOR -d"

# Colorize man pages viewed through less.
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

path_append() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="${PATH:+$PATH:}$1" ;;
    esac
}

path_append "$HOME/.local/bin"
export PATH

ssh_agent_is_available() {
    [ -n "${SSH_AUTH_SOCK:-}" ] || return 1

    ssh-add -l >/dev/null 2>&1
    local ssh_add_status=$?
    [ "$ssh_add_status" -eq 0 ] || [ "$ssh_add_status" -eq 1 ]
}

ssh_key_is_loaded() {
    local key="$1"
    local fingerprint

    command -v ssh-keygen >/dev/null 2>&1 || return 1
    fingerprint="$(ssh-keygen -lf "$key" 2>/dev/null | awk '{print $2}')"
    [ -n "$fingerprint" ] || return 1

    ssh-add -l 2>/dev/null | awk '{print $2}' | grep -Fxq "$fingerprint"
}

ssh_add_default_keys() {
    local key

    for key in "$HOME/.ssh/id_ed25519" "$HOME/.ssh/id_rsa"; do
        [ -r "$key" ] || continue
        ssh_key_is_loaded "$key" && continue
        ssh-add "$key" >/dev/null 2>&1
    done
}

setup_ssh_agent() {
    local agent_file="$HOME/.ssh/ssh-agent"

    command -v ssh-agent >/dev/null 2>&1 || return
    command -v ssh-add >/dev/null 2>&1 || return
    [ -d "$HOME/.ssh" ] || return

    if ! ssh_agent_is_available && [ -r "$agent_file" ]; then
        . "$agent_file" >/dev/null 2>&1 || true
    fi

    if ! ssh_agent_is_available; then
        ssh-agent -s > "$agent_file"
        chmod 600 "$agent_file"
        . "$agent_file" >/dev/null 2>&1
    fi

    ssh_agent_is_available && ssh_add_default_keys
}

setup_ssh_agent
