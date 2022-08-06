# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# SOFTWARES{{{
# autojump
# [[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
[[ -s .guix-profile/etc/profile.d/autojump.sh ]] && source .guix-profile/etc/profile.d/autojump.sh
# }}}

# ALIAS{{{
# overwrite
alias ls="exa"
alias poweroff="systemctl hibernate"
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
alias ch="char-coal query"
# }}}

# FUNCTIONS{{{
# toggle laptop keyboard
# function kb_switch() {
#   swaymsg input 1:1:AT_Translated_Set_2_keyboard events toggle enabled disabled
# }

# function touchpad_switch() {
#   swaymsg input 1267:12515:DELL0922:00_04F3:30E3_Touchpad events toggle enabled disabled
# }

# for xorg
function kb_switch() {
  # kb_name='AT Translated Set 2 keyboard' # give keyboard name
  kb_name=15 # give keyboard name

  if xinput list $kb_name | grep -i --quiet disable; then
    xinput enable $kb_name
    echo keyboard on
  else
    xinput disable $kb_name
    echo keyboard off
  fi
}

function fktail() {
  ~/.config/zsh/fktail.py
}

  # select laptop performance mode
  # function perform() {
  #   if [[ $1 == '-p' ]] ;
  #   then
  #     sudo smbios-thermal-ctl --set-thermal-mode=Performance
  #   elif [[ $1 == '-b' ]] ;
  #   then
  #     sudo smbios-thermal-ctl --set-thermal-mode=Balanced
  #   else
  #     echo "Invalid Argument"
  #     echo "Supported arguments:"
  #     echo "-p: Performance"
  #     echo "-b: Balanced"
  #   fi
  # }
  # }}}

# TERMINAL BEHAVIOR{{{
# ENV specification for certain environment
if [[ -n $TERM_ENV ]];
then
  if [[ $TERM_ENV == vscode ]];
  then
    export EDITOR=code-insiders
  else
    export TERM_PROGRAM=$TERM_ENV
  fi
fi

# tmux auto attach
# need env $TERM_PROGRAM
TERMS_ALLOWED=(alacritty vscode)
if [[ -n $TERM_PROGRAM ]] && [[ -n $(echo $TERMS_ALLOWED | grep $TERM_PROGRAM) ]] && ! [[ -v TMUX ]] && ! [[ -v VIM ]];
then
  export TERM_ENV=$TERM_PROGRAM
  if [[ -z $(tmux ls | grep $TERM_PROGRAM) ]];
  then
    tmux new -s $TERM_PROGRAM
  else
    tmux attach -t $TERM_PROGRAM
  fi
  clear
  echo $fg_bold[green] ">" $fg_bold[red]"Exit?"
  read ans_exit
  [[ $ans_exit = 'n' ]] || exit 0
fi
# }}}
