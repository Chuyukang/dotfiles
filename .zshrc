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

# short command
alias a='git add'
alias c='git commit'
alias s='git status'
alias k='kubectl'
alias p='proxychains'

alias h='history'

# for python pip
export PATH=$PATH:/home/$USER/.local/bin/

# for kubectl auto completion
# [[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)
# for minikube auto completion
# [[ /usr/bin/minikube ]] && source <(minikube completion zsh)
# for helm auto completion
# [[ /usr/bin/helm ]] && source <(helm completion zsh)

# for proxy
alias proxyOn='export https_proxy=http://127.0.0.1:7890 && http_proxy=http://127.0.0.1:7890'
alias proxyOff='unset https_proxy && unset http_proxy'


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mcli

