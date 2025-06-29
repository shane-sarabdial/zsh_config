#!/usr/bin/env zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################


export DOTFILES="$HOME/.dotfiles"
export WORKSPACE="$HOME/workspace"

[ -f "$DOTFILES/install_config" ] && source "$DOTFILES/install_config"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=100000                   # Maximum events for internal history
export SAVEHIST=100000                   # Maximum events in history fileexport PATH=$PATH:$HOME/.local/opt/go/bin

#go
export PATH=$PATH:$HOME/.local/opt/go/bin

#bootdev cli
export PATH=$PATH:$HOME/go/bin

#Editor
export EDITOR=/usr/bin/nvim

#github command line
export PATH=$HOME/.local/bin:$PATH
