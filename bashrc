export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PS1=" \e[0;36m\W\e[m \e[1;30m\$\e[m "

if command -v nvim &> /dev/null ; then
	export EDITOR='nvim'
elif command -v vim &> /dev/null ; then
	export EDITOR='vim'
elif command -v nano &> /dev/null ; then
	export EDITOR='nano'
fi

if command -v doas &> /dev/null ; then
	alias sudo='doas'
fi

alias ls='ls --color=auto'
alias ll='ls -lha'
alias l='ls -lhA'
alias c='cd ..'

alias v=$EDITOR
alias lg='lazygit'

if [ -f '~/git/google-cloud-sdk/path.zsh.inc' ]; then . '~/git/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '~/git/google-cloud-sdk/completion.zsh.inc' ]; then . '~/git/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(~/.rbenv/bin/rbenv init - zsh 2> /dev/null)"

