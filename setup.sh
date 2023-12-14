DIRS=( "$HOME/.oh-my-zsh/custom/themes" "$HOME/.config/nvim" "$HOME/.config/neofetch" )
for dir in ${DIRS[@]} do
    [[ ! -e $dir ]] && mkdir -pv $dir
done

ln -sv $(pwd)/jack.zsh-theme ~/.oh-my-zsh/custom/themes/jack.zsh-theme
ln -sv $(pwd)/neovim ~/.config/nvim/init.vim
ln -sv $(pwd)/neofetch ~/.config/neofetch/config.conf
ln -sv $(pwd)/zshrc ~/.zshrc
