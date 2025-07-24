# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# SOFTWARES{{{
# autojump
# [[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
[[ -s .guix-profile/etc/profile.d/autojump.sh ]] && source .guix-profile/etc/profile.d/autojump.sh

# }}}

# ALIAS{{{
# overwrite
alias ls="eza"
# alias ssh="kitty +kitten ssh"
# alias poweroff="systemctl hibernate"
# file associations
alias -s md="typora"
alias -s pdf="zathura"
alias -s mp3="mpv"
alias -s pptx="libreoffice"
alias -s docx="libreoffice"
alias -s xslx="libreoffice"
# acronym
alias aur="yay"
alias swaycfg="vim ~/.config/sway/config"
alias ml="/home/cc/Applications/matlab/bin/matlab -desktop & disown"
alias vmstart="xfreerdp /v:192.168.122.246:3389 /w:2560 /h:1440 /bpp:32 +clipboard +fonts /gdi:hw /rfx /rfx-mode:video /sound:sys:pulse +menu-anims +window-drag"
alias vmstart_1080="xfreerdp /v:192.168.122.246:3389 /w:1920 /h:1080 /bpp:32 +clipboard +fonts /gdi:hw /rfx /rfx-mode:video /sound:sys:pulse +menu-anims +window-drag"
alias vim="nvim"
alias ch="charcoal query"
# }}}

# FUNCTIONS{{{
# toggle laptop keyboard
# function kb_switch() {
#   swaymsg input 2821:6582:Asus_Keyboard events toggle enabled disabled
# }

# function touchpad_switch() {
#   swaymsg input 1267:12515:DELL0922:00_04F3:30E3_Touchpad events toggle enabled disabled
# }

# for xorg
# function kb_switch() {
#   setopt shwordsplit
#   # kb_name='AT Translated Set 2 keyboard' # give keyboard name
#   kb_ids=$(xinput list --long | grep 'Asus Keyboard.*keyboard' | cut -b 5- | awk {'print $4;'} | cut -b 4-)
#   kb_ids="${kb_ids//$'\n'/ }"
#   saveIFS="$IFS"
#   IFS=' '
#   kb_ids=(${kb_ids})
#   IFS="$saveIFS"
#   for id in ${kb_ids[@]};
#   do
#     if xinput list $id | grep -i --quiet disable; then
#       xinput enable $id
#       echo keyboard on
#     else
#       xinput disable $id
#       echo keyboard off
#     fi
#   done
# }

# function touchpad_switch() {
#   id=$(xinput list --long | grep 'Touchpad' | awk '{print $6}' | cut -c4-)
#   if xinput list $id | grep -i --quiet disable; then
#     xinput enable $id
#     echo touchpad on
#   else
#     xinput disable $id
#     echo touchpad off
#   fi
# }

function kb_switch() {
  ~/dotfiles/.config/hypr/scripts/switch_keyboard.sh
}

function touchpad_switch() {
  ~/dotfiles/.config/hypr/scripts/switch_touchpad.sh
}



# TERMINAL BEHAVIOR{{{
# ENV specification for certain environment
if [[ -n $TERM_ENV ]];
then
  if [[ $TERM_ENV == vscode ]];
  then
    export EDITOR=code
  else
    export TERM_PROGRAM=$TERM_ENV
  fi
fi

# tmux auto attach
# need env $TERM_PROGRAM
if [[ -n $(env | grep ALACRITTY) ]];
then
  export TERM_ENV=$TERM
  if [[ -z $(tmux ls | grep $TERM) ]];
  then
    tmux new -s $TERM
  else
    tmux attach -t $TERM
  fi
fi

TERMS_ALLOWED=(alacritty vscode xterm-kitty)
if [[ -n $TERM ]] && [[ -n $(echo $TERMS_ALLOWED | grep $TERM) ]] && ! [[ -v TMUX ]] && ! [[ -v VIM ]];
then
  export TERM_ENV=$TERM
  if [[ -z $(tmux ls | grep $TERM) ]];
  then
    tmux new -s $TERM
  else
    tmux attach -t $TERM
  fi
  clear
  echo $fg_bold[green] ">" $fg_bold[red]"Exit?"
  read ans_exit
  [[ $ans_exit = 'n' ]] || exit 0
fi
# }}}

