export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 7

ZSH_THEME="jack"
# ZSH_THEME_RANDOM_CANDIDATES=(  )
# CASE_SENSITIVE="false"
# HYPHEN_INSENSITIVE="false"
# DISABLE_MAGIC_FUNCTIONS="false"
# DISABLE_LS_COLORS="false"
# DISABLE_AUTO_TITLE="false"
# ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="false"
# HIST_STAMPS="mm/dd/yyyy"
# ZSH_CUSTOM=

plugins=(git)
source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias vim="nvim"

echo
neofetch