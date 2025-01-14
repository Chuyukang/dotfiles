# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/chu/.zshrc'

# home end key
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char


# User specify
## [completion]
# config from: https://thevaluable.dev/zsh-completion-guide-examples/
source $HOME/.zsh/completion.zsh

## [prompt]
# PS1="[\u@\h \W]\$ "
# PS1="\W \$ "
# starship promot
eval "$(starship init zsh)"
# PROMPT="%n@%m:%d$"

## [plugins]
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source ~/.zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
eval "$(zoxide init zsh)"

# [env] import env setting per host
source ~/.zsh_env_vars

## [alias]
alias ls='ls --color=auto'

alias l='ls'
alias up='cd ..'
alias zb='cd "$(git rev-parse --show-toplevel)"'
alias k='kubectl'
alias h='history'

alias g='git'
alias s='git status'

alias egrep='grep -E'

# [alias] proxy 
alias p="export https_proxy=$PROXY_URL && http_proxy=$PROXY_URL"
alias np='unset https_proxy && unset http_proxy'
# [alias] data analysis python env
alias datapy="source /home/$USER/.local/pythonEnvs/datapy/bin/activate"
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# [alias] share file in this host
# NOTE: default bind 0.0.0.0, should use internal ip address
alias fs="python3 -m http.server"
# [alias] get file from outside
alias lf="nc -lp 8180 >"

## [env]
export EDITOR=nvim
export BROWSER=google-chrome-stable
# python pip
export PATH=$PATH:/home/$USER/.local/bin/:/home/$USER/scripts/:/home/$USER/repos/cheri-exercises/tools/
export LANG=en_US.UTF-8


## [complete]
# for kubectl auto completion
# [[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)
# for minikube auto completion
# [[ /usr/bin/minikube ]] && source <(minikube completion zsh)
# for helm auto completion
# [[ /usr/bin/helm ]] && source <(helm completion zsh)

# complete vcpkg
#source /opt/vcpkg/scripts/vcpkg_completion.zsh

# pnpm
export PNPM_HOME="/home/$USER/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export VCPKG_ROOT=$HOME/.local/share/vcpkg
