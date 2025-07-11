#!/usr/bin/env bash

# list of configuration files/folders and where they link to
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
        ["alacritty"]="$HOME/.config/alacritty" \
        ["kitty"]="$HOME/.config/kitty/kitty.conf" \
        ["i3"]="$HOME/.config/i3/config" \
        ["i3status"]="$HOME/.config/i3status/config" \
        ["nanorc"]="$HOME/.nanorc" )

declare -a FONTS
FONTS=( "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip" )

parse_args() {
    while [[ "$1" ]]; do
        case $1 in
            "-v") verbose='-v' ;;
            "--verbose") verbose='-v' ;;
            "--only") inverse=true ;;
            "--unsetup") unsetup=true ;;
            "dots") do_dots=true ;;
            "scripts") do_scripts=true ;;
            "omz") do_omz=true ;;
            "fonts") do_fonts=true ;;
        esac

        shift
    done
}

setup_dots() {
    echo setting up dots...

    # link configuration
    for d in "${!DOTS[@]}"; do
        # create folders if they don't exist
        [[ ! -e $(dirname "${DOTS[$d]}") ]] && mkdir -p $verbose "$(dirname "${DOTS[$d]}")"
        # backup old files/delete residual symlinks
        [[ -L ${DOTS[$d]} ]] && rm $verbose "${DOTS[$d]}"
        [[ -f ${DOTS[$d]} ]] && mv $verbose "${DOTS[$d]}" "${DOTS[$d]}".old
        # symlink new config
        ln -s $verbose "$DIR"/dots/"$d" "${DOTS[$d]}"
    done
}

unsetup_dots() {
    echo unsetting up dots...

    # link configuration
    for d in "${!DOTS[@]}"; do
        [[ -L ${DOTS[$d]} ]] && rm $verbose "${DOTS[$d]}"
    done
}

setup_scripts() {
    echo setting up scripts...

    # link scripts
    [[ ! -e "$HOME/.local/bin" ]] && mkdir -p $verbose "$HOME/.local/bin"
    for SCRIPT in "$DIR"/scripts/*; do
        BASENAME=$(basename "$SCRIPT")
        chmod $verbose +x "$DIR"/scripts/"$BASENAME"
        # backup old files/delete residual symlinks
        [[ -L $HOME/.local/bin/$BASENAME ]] && rm $verbose "$HOME"/.local/bin/"$BASENAME"
        [[ -f $HOME/.local/bin/$BASENAME ]] && mv $verbose "$HOME"/.local/bin/"$BASENAME" "$HOME"/.local/bin/"$BASENAME".old
        # symlink script
        ln -s $verbose "$DIR"/scripts/"$BASENAME" "$HOME"/.local/bin/"$BASENAME"
    done
}

unsetup_scripts() {
    echo unsetting up scripts...

    for SCRIPT in "$DIR"/scripts/*; do
        BASENAME=$(basename "$SCRIPT")
        [[ -L $HOME/.local/bin/$BASENAME ]] && rm $verbose "$HOME"/.local/bin/"$BASENAME"
    done
}

setup_omz() {
    echo setting up ohmyzsh...

    [[ -e "$HOME/.oh-my-zsh" ]] && rm -rf $verbose "$HOME/.oh-my-zsh"
    CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

setup_fonts() {
    echo setting up fonts...

    [[ ! -e "$HOME/.local/share/fonts" ]] && mkdir -p $verbose "$HOME/.local/share/fonts"
    for font in "${FONTS[@]}" ; do
        curl -o "$HOME/.local/share/fonts/font.zip" -L "$font"
        unzip -o -d "$HOME/.local/share/fonts" "$HOME/.local/share/fonts/font.zip"
        rm $verbose "$HOME/.local/share/fonts/font.zip"
    done
}

main() {
    # make sure we're using the correct directory
    DIR=$(dirname "$0")
    if [[ $DIR == '.' ]] ; then
        DIR=$(pwd)
    fi

    parse_args "$@"

    if [ "$inverse" = true ] ; then
        [ "$do_omz" = true ] && setup_omz
        [ "$do_dots" = true ] && setup_dots
        [ "$do_scripts" = true ] && setup_scripts
        [ "$do_fonts" = true ] && setup_fonts

        finish
    fi

    if [ "$unsetup" = true ] ; then
        unsetup_dots
        unsetup_scripts

        echo ignoring OMZ and Fonts as they are not symlinked

        finish
    fi

    setup_omz
    setup_dots
    setup_scripts
    setup_fonts

    finish
}

finish() {
    echo finished
    exit 0
}

main "$@"
