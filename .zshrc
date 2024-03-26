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
#eval "$(lua ~/.zsh/plugins/z.lua/z.lua  --init zsh)"
eval "$(zoxide init zsh)"

## [alias]
alias ls='ls --color=auto'

alias l='ls'
alias up='cd ..'
alias zb='cd "$(git rev-parse --show-toplevel)"'
alias k='kubectl'
alias p='proxychains'
alias h='history'

alias g='git'
alias s='git status'

alias egrep='grep -E'

PROXY_URL=http://172.25.144.1:7890
# [alias] proxy 
alias p="export https_proxy=$PROXY_URL && http_proxy=$PROXY_URL"
alias np='unset https_proxy && unset http_proxy'
# [alias] vpn script
alias vpn="sudo bash /home/$USER/openvpn/vpn"
# [alias] data analysis python env
alias datapy="source /home/$USER/.local/pythonEnvs/datapy/bin/activate"
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

## [env]
export EDITOR=nvim
export BROWSER=google-chrome-stable
# python pip
export PATH=$PATH:/home/$USER/.local/bin/:/home/$USER/scripts/:/home/$USER/repos/cheri-exercises/tools/
export LANG=en_US.UTF-8
# [env] faas-cli
export OPENFAAS_URL="http://178.128.126.221:31112"
export CHERI_SDK=/home/$USER/cheri/output/sdk
#export TERM="xterm"


# [alias] cheri binutils
alias cherimode="export PATH=$CHERI_SDK/bin:$PATH"

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

