# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chu/.zshrc'

# for home end key
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

autoload -Uz compinit
compinit
# End of lines added by compinstall

# starship promot
# eval "$(starship init zsh)"
# PROMPT="%n@%m:%d$"

autoload -Uz promptinit
promptinit
prompt redhat
# End of lines added by prompt theme

# User specify
alias ls='ls --color=auto'
# PS1="[\u@\h \W]\$ "
# PS1="\W \$ "

alias l='ls'
alias up='cd ..'
alias a='git add'
alias c='git commit'
alias s='git status'
alias k='kubectl'
alias p='proxychains'
alias h='history'

alias egrep='grep -E'

# [alias] proxy 
alias proxyOn='export https_proxy=http://127.0.0.1:7890 && http_proxy=http://127.0.0.1:7890'
alias proxyOff='unset https_proxy && unset http_proxy'
# [alias] vpn script
alias vpn="sudo bash /home/chu/openvpn/vpn"
# [alias] data analysis python env
alias datapy='source /home/chu/.local/pythonEnvs/Data/bin/activate'

## [env]
# python pip
export PATH=$PATH:/home/$USER/.local/bin/
export LANG=en_US.UTF-8

autoload -U +X bashcompinit && bashcompinit
## [complete]

