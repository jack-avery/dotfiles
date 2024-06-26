export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PS1='$? \e[0;34m\u\e[m@\e[0;34m\h\e[m:\e[0;36m\e[0;33m\W\e[m \$ '

if command -v nvim &> /dev/null ; then
	export EDITOR='nvim'
elif command -v vim &> /dev/null ; then
	export EDITOR='vim'
elif command -v nano &> /dev/null ; then
	export EDITOR='nano'
fi

source .aliases

if [ -f '~/git/google-cloud-sdk/path.zsh.inc' ]; then . '~/git/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '~/git/google-cloud-sdk/completion.zsh.inc' ]; then . '~/git/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(~/.rbenv/bin/rbenv init - zsh 2> /dev/null)"

