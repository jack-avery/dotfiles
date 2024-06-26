#!/usr/bin/env bash

declare -A DOTS
DOTS=(  ["aliases"]="$HOME/.aliases" \
	["nvim"]="$HOME/.config/nvim" \
        ["bashrc"]="$HOME/.bashrc" \
	["zshrc"]="$HOME/.zshrc" \
	["zsh_theme"]="$HOME/.oh-my-zsh/custom/themes/jack.zsh-theme" \
        ["gitconfig"]="$HOME/.gitconfig" \
        ["tmux"]="$HOME/.config/tmux/tmux.conf" \
	["alacritty"]="$HOME/.config/alacritty.toml" )

for d in ${!DOTS[@]}; do
    # create folders if they don't exist
    [[ ! -e $(dirname "${DOTS[$d]}") ]] && mkdir -pv $(dirname ${DOTS[$d]})
    # delete old files/residual symlinks
    [[ -L ${DOTS[$d]} ]] && rm -v ${DOTS[$d]}
    [[ -f ${DOTS[$d]} ]] && mv -v ${DOTS[$d]} ${DOTS[$d]}.old
    # symlink new config
    ln -sv $(pwd)/$d ${DOTS[$d]}
done
echo finished
