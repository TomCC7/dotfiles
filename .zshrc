# .zshrc
# sh -c "$(curl -fsSL https://git.io/zinit-install)"
# zmodload zsh/zprof # test start time

## PERSONAL SETTINGS ##
# ros
#source /opt/ros/noetic/setup.zsh
# orb slam
#export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/mnt/share/Programming/Projects/slam/refs/ORB_SLAM3/Examples/ROS
alias catkin_clean="rm -r build && rm -r devel"

## BASIC SETTINGS ##
# history
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=290000
SAVEHIST=$HISTSIZE

# Caption sensitive off
# ref: https://zhuanlan.zhihu.com/p/183966575
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

HISTTIMEFORMAT="[%F %T] "
setopt extended_history       # record timestamp of command in HISTFILE
setopt appendhistory
setopt INC_APPEND_HISTORY # append immediately
setopt EXTENDED_HISTORY # add timestamp

# Theme
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

## ZINIT ##
# init
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# loading git
zinit ice depth=1; zinit snippet OMZL::git.zsh
zinit ice depth=1; zinit snippet OMZP::git

# theme
# Settings to make themes behave normally
# ref: https://github.com/zdharma/zinit/issues/146
setopt promptsubst
autoload colors
colors

zinit snippet OMZL::prompt_info_functions.zsh
# zinit ice depth=1; zinit light hohmannr/bubblified
# powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# plugins
zinit wait lucid for \
  atinit"zicompinit; zicdreplay"  \
  blockf  \
  zsh-users/zsh-completions \
  softmoth/zsh-vim-mode  \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-autosuggestions \
  unixorn/fzf-zsh-plugin \
  OMZP::colored-man-pages \
  OMZP::cp \
  OMZP::extract \
  as"completion" \
  OMZP::docker/_docker
  # hohmannr/bubblified  \
  # sobolevn/zsh-wakatime   \

# VARS
export VISUAL=nvim 
export EDITOR=nvim
## ALIAS ##

# acronym
alias zshcfg="vim ~/.zshrc"
alias ll="ls -lh"
alias r="ranger"
alias svim="sudo -E nvim"
alias cconfig="cmake -B ./build"
alias cbuild="cmake --build ./build"
alias e="emacsclient --create-frame -nw"

## Functions ##
# add vpn
# function vpn() {
#   export VPN_HOST_IP=127.0.0.1
#   HTTP_PROXY_PORT=8889
#   HTTP_PROXY=http://$VPN_HOST_IP:$HTTP_PROXY_PORT
#   if [[ $1 = "off" ]];
#   then
#     unset http_proxy
#     unset https_proxy
#     unset all_proxy
#     unset GIT_SSH_COMMAND
#     git config --global --unset http.https://github.com.proxy
#     git config --global --unset core.gitproxy
#     echo vpn off
#   else
#     export http_proxy=$HTTP_PROXY
#     export https_proxy=$HTTP_PROXY
#     export all_proxy=$HTTP_PROXY
#     # only for 'github.com'
#     git config --global http.https://github.com.proxy $HTTP_PROXY
#     # use 'connect' with HTTP_PROXY environment
#     export GIT_SSH_COMMAND="ssh -o ProxyCommand=\"nc -X connect -x $VPN_HOST_IP:$HTTP_PROXY_PORT %h %p\""
#     git config --global core.gitproxy "/usr/bin/gitproxy for github.com"
#     if [[ $1 != -q ]]; then
#       # echo
#       echo vpn started!
#     fi
#   fi
# }

# mount iso file
function mount_iso() {
  sudo mkdir /mnt/$2
  sudo mount -o loop $1 /mnt/$2
}

function mnt_media() {
  mkdir -p /mnt/media/$2
  sudo mount $1 /mnt/media/$2 -o uid=1000,gid=1000,umask=0000 
}

function keep() {
  while true;do
    clear
    $@
    sleep 1
  done
}

# {{ EMACS FUNCTIONS
function vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
# }}

# personalized config
if [[ $HOST = cccomputer ]] && [[ $USER = cc ]];
then
  source ~/.config/zsh/personal.zsh
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
source /etc/profile
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
### End of Zinit's installer chunk

zinit snippet OMZT::ys
source ~/.zprofile

