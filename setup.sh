# create directory structure
DIRS=( "$HOME/.oh-my-zsh/custom/themes" "$HOME/.config/nvim" "$HOME/.config/neofetch" )
for dir in ${DIRS[@]}; do
    [[ ! -e $dir ]] && mkdir -pv $dir
done

# delete any pre-existing (default?) config files
OLD=( "$HOME/.oh-my-zsh/custom/themes/jack.zsh-theme" "$HOME/.config/nvim/init.vim" "$HOME/.config/neofetch/config.conf" "$HOME/.zshrc" )
for file in ${OLD[@]}; do
    [[ -f $file ]] && mv -v $file $file.old
    [[ -L $file ]] && rm -v $file
done

# link my config
ln -sv $(pwd)/jack.zsh-theme ~/.oh-my-zsh/custom/themes/jack.zsh-theme
ln -sv $(pwd)/neovim ~/.config/nvim/init.vim
ln -sv $(pwd)/neofetch ~/.config/neofetch/config.conf
ln -sv $(pwd)/zshrc ~/.zshrc
