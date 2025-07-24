# .zshrc
# sh -c "$(curl -fsSL https://git.io/zinit-install)"
# zmodload zsh/zprof # test start time
ZSH_CONFIG_DIR=~/.config/zsh

## PERSONAL SETTINGS ##
# ros
for release in "noetic" "melodic" "rolling" "humble"
do
  if [[ -f "/opt/ros/$release/setup.zsh" ]];
  then
    source /opt/ros/$release/setup.zsh
    ulimit -Sn 4096 && ulimit -Hn 4096
  fi
done
[[ -f /opt/ros/foxy/setup.zsh ]] && source /opt/ros/foxy/setup.zsh && export ROS_DOMAIN_ID=7
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
zinit ice depth=1; zinit light romkatv/powerlevel10k
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
  skywind3000/z.lua \
  OMZP::cp \
  OMZP::extract \
  chisui/zsh-nix-shell \
  # as"completion" \
  # hohmannr/bubblified  \
  # sobolevn/zsh-wakatime   \

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# VARS
export VISUAL=nvim 
export EDITOR=nvim
## ALIAS ##

# acronym
alias zshcfg="vim ~/.zshrc"
alias ll="ls -lh"
alias r="source ranger"
alias svim="sudo -E nvim"
alias cconfig="cmake -B ./build"
alias cbuild="cmake --build ./build"
alias e="emacsclient --create-frame -nw"
alias omni-python=/home/cc/.local/share/ov/pkg/isaac-sim-4.2.0/python.sh

# }}

# personalized config
if [[ $HOST = cccomputer ||  $HOST = astra-rog  ]] && [[ $USER = cc ]];
then
  source $ZSH_CONFIG_DIR/personal.zsh
  [[ -f $ZSH_CONFIG_DIR/private.zsh ]] && source $ZSH_CONFIG_DIR/private.zsh
  # wakatime plugin
  # zinit wait lucid for sobolevn/wakatime-zsh-plugin
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit snippet OMZT::ys

## FUNCTIONS {{
# swaymsg
swaymsg(){
        export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(pgrep -x sway).sock
        command swaymsg "$@"
    }

# add vpn
function vpn() {
  export VPN_HOST_IP=127.0.0.1
  HTTP_PROXY_PORT=7893
  SOCKS_PROXY_PORT=7893
  SOCKS_PROXY=socks5h://$VPN_HOST_IP:$SOCKS_PROXY_PORT
  HTTP_PROXY=http://$VPN_HOST_IP:$HTTP_PROXY_PORT
  if [[ $1 = "off" ]];
  then
    unset http_proxy
    unset https_proxy
    unset all_proxy
    unset GIT_SSH_COMMAND
    git config --global --unset http.https://github.com.proxy
    git config --global --unset core.gitproxy
    echo vpn off
  else
    export http_proxy=$HTTP_PROXY
    export https_proxy=$HTTP_PROXY
    export all_proxy=$HTTP_PROXY
    # only for 'github.com'
    git config --global http.https://github.com.proxy $SOCKS_PROXY
    # use 'connect' with HTTP_PROXY environment
    # export GIT_SSH_COMMAND="ssh -o ProxyCommand=\"nc -X connect -x $VPN_HOST_IP:$HTTP_PROXY_PORT %h %p\""
    # git config --global core.gitproxy "/usr/bin/gitproxy for github.com"
    if [[ $1 != -q ]]; then
      # echo
      echo vpn started!
    fi
  fi
}

# mount iso file
function mount_iso() {
  sudo mkdir /mnt/$2
  sudo mount -o loop $1 /mnt/$2
}

function mnt_media() {
  mkdir -p /mnt/media/$2
  sudo mount $1 /mnt/media/$2 -o uid=1000,gid=1000,umask=0000 
}

# usage: find_up pattern
# recursively find in parent dir until found
function find_up() {
  ORIG=$PWD
  while [[ $PWD != "/" ]] ; do
    res=$(find "$PWD"/ -maxdepth 1 "$@")
    if [[ -z $res ]]; then
      cd ..
    else
      echo $res
      return
    fi
  done
  cd $ORIG
}

function rs() {
  source $(find_up -regex ".*/\(devel\|install\)$")/setup.zsh
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
## }}

export PATH="$HOME/.poetry/bin:$HOME/.local/bin:$PATH"

# >>> conda initialize >>>
function enable_conda()
{
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cc/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cc/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/cc/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cc/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/cc/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/cc/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
}

export PATH="/opt/drake/bin${PATH:+:${PATH}}"
export PYTHONPATH="/opt/drake/lib/python$(python3 -c 'import sys; print("{0}.{1}".format(*sys.version_info))')/site-packages${PYTHONPATH:+:${PYTHONPATH}}"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/cc/.dart-cli-completion/zsh-config.zsh ]] && . /home/cc/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

if [ -z "$DIRENV_ENABLED" ]; then
  eval "$(direnv hook zsh)"
fi
