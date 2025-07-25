#!/usr/bin/env zsh

#zmodload zsh/zprof

fpath=($DOTFILES/zsh/plugins $fpath)

setopt NO_BEEP

# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.


# +------------+
# | COMPLETION |
# +------------+

source $DOTFILES/zsh/completion.zsh


# +--------+
# | PROMPT |
# +--------+

fpath=($DOTFILES/zsh/prompt $fpath)
source $DOTFILES/zsh/prompt/prompt_purification_setup


# +---------+
# | ALIASES |
# +---------+

 source $DOTFILES/aliases/aliases

# +-----------+
# | VI KEYMAP |
# +-----------+

# Vi mode
bindkey -v
export KEYTIMEOUT=1

#Change cursor
source "$DOTFILES/zsh/plugins/cursor_mode"

#Add Vi text-objects for brackets and quotes
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Emulation of vim-surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround

# Increment a number
autoload -Uz incarg
zle -N incarg
bindkey -M vicmd '^a' incarg

# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+
typeset -Ag ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
  comment    'fg=#FFB300' # comments
  command    'fg=#0288D1,bold' # commands (executable names)
  builtin    'fg=#2E7D32' # builtins (cd, echo, etc)
  alias      'fg=#B18E3E' # aliases
  string     'fg=#FFFFFF' # strings (inside quotes)
  number     'fg=blue' # numbers
  unknown    'fg=red,bold' # errors (unknown commands)
  path       'fg=#FFFFFF'
)
source $DOTFILES/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#zprof