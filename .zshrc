#!/bin/sh

zmodload zsh/zprof

# history
export ZDOTDIR=$HOME/.config/zsh
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZDOTDIR/.zsh_history"
setopt appendhistory
setopt sharehistory
setopt incappendhistory

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping 
unsetopt BEEP

# completions
zmodload zsh/complist
zstyle ':completion:*' menu select matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit 
_comp_options+=(globdots)		# Include hidden files.

# show suggestions by pressing up/down key after what you already typed
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[OB'  down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

compinit

# Environment variables set everywhere
export EDITOR="nvim"
export BROWSER="brave"
