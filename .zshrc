# .zshrc
# sh -c "$(curl -fsSL https://git.io/zinit-install)"
# zmodload zsh/zprof # test start time
ZSH_CONFIG_DIR=~/.config/zsh

source $ZSH_CONFIG_DIR/fn.zsh
## PERSONAL SETTINGS ##
# ros
[[ -f /opt/ros/noetic/setup.zsh ]] && source /opt/ros/noetic/setup.zsh
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
alias r="source ranger"
alias svim="sudo -E nvim"
alias cconfig="cmake -B ./build"
alias cbuild="cmake --build ./build"
alias e="emacsclient --create-frame -nw"

# }}

# personalized config
if [[ $HOST = cccomputer ]] && [[ $USER = cc ]];
then
  source $ZSH_CONFIG_DIR/personal.zsh
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit snippet OMZT::ys
