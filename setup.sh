#!/usr/bin/env bash

DIR=$(dirname "$0")
if [[ $DIR == '.' ]] ; then
    DIR=$(pwd)
fi

VERBOSE=''
if [[ $1 == '-v' ]] ; then
    VERBOSE='-v'
fi

declare -A DOTS
DOTS=(  ["shellrc"]="$HOME/.shellrc" \
        ["aliases"]="$HOME/.aliases" \
        ["nvim"]="$HOME/.config/nvim" \
        ["vimrc"]="$HOME/.vimrc" \
        ["bashrc"]="$HOME/.bashrc" \
        ["zshrc"]="$HOME/.zshrc" \
        ["zsh_theme"]="$HOME/.oh-my-zsh/custom/themes/jack.zsh-theme" \
        ["gitconfig"]="$HOME/.gitconfig" \
        ["tmux"]="$HOME/.config/tmux/tmux.conf" \
        ["alacritty"]="$HOME/.config/alacritty.toml" \
        ["i3"]="$HOME/.config/i3/config" )

for d in ${!DOTS[@]}; do
    # create folders if they don't exist
    [[ ! -e $(dirname "${DOTS[$d]}") ]] && mkdir -p $VERBOSE $(dirname ${DOTS[$d]})
    # delete old files/residual symlinks
    [[ -L ${DOTS[$d]} ]] && rm $VERBOSE ${DOTS[$d]}
    [[ -f ${DOTS[$d]} ]] && mv $VERBOSE ${DOTS[$d]} ${DOTS[$d]}.old
    # symlink new config
    ln -s $VERBOSE $DIR/$d ${DOTS[$d]}
done

[[ ! -e "$HOME/.local/bin" ]] && mkdir -p $VERBOSE "$HOME/.local/bin"
for SCRIPT in $DIR/scripts/*; do
    BASENAME=$(basename "$SCRIPT")
    chmod $VERBOSE +x $DIR/scripts/$BASENAME
    # replace with script
    [[ -L $HOME/.local/bin/$BASENAME ]] && rm $VERBOSE $HOME/.local/bin/$BASENAME
    ln -s $VERBOSE $DIR/scripts/$BASENAME $HOME/.local/bin/$BASENAME
done

echo finished

