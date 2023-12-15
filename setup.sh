# create directory structure
DIRS=( "$HOME/.oh-my-zsh/custom/themes" "$HOME/.config/nvim" "$HOME/.config/neofetch" )
for dir in ${DIRS[@]}; do
    [[ ! -e $dir ]] && mkdir -pv $dir
done

declare -A DOTS
DOTS=(  ["zsh_theme"]="$HOME/.oh-my-zsh/custom/themes/jack.zsh-theme" \
        ["nvim"]="$HOME/.config/nvim/init.vim" \
        ["neofetch"]="$HOME/.config/neofetch/config.conf" \
        ["zshrc"]="$HOME/.zshrc" )
for d in ${!DOTS[@]}; do
    # delete old files/residual symlinks
    [[ -f ${DOTS[$d]} ]] && mv -v $d $d.old
    [[ -L ${DOTS[$d]} ]] && rm -v $d
    # symlink new config
    ln -sv $(pwd)/$d ${DOTS[$d]}
done
