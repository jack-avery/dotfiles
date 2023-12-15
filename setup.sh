#!/usr/bin/env bash

declare -A DOTS
DOTS=(  ["zsh_theme"]="$HOME/.oh-my-zsh/custom/themes/jack.zsh-theme" \
        ["nvim"]="$HOME/.config/nvim/init.vim" \
        ["neofetch"]="$HOME/.config/neofetch/config.conf" \
        ["zshrc"]="$HOME/.zshrc" )

for d in ${!DOTS[@]}; do
    # create folders if they don't exist
    [[ ! -e ${DOTS[$d]} ]] && mkdir -pv 
    # delete old files/residual symlinks
    [[ -f ${DOTS[$d]} ]] && mv -v $d $d.old
    [[ -L ${DOTS[$d]} ]] && rm -v $d
    # symlink new config
    ln -sv $(pwd)/$d ${DOTS[$d]}
done
