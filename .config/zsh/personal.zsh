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
alias aur="paru"
alias swaycfg="vim ~/.config/sway/config"
alias ml="/home/cc/Applications/matlab/bin/matlab -desktop & disown"
alias vmstart="xfreerdp /v:192.168.122.246:3389 /w:2560 /h:1440 /bpp:32 +clipboard +fonts /gdi:hw /rfx /rfx-mode:video /sound:sys:pulse +menu-anims +window-drag"
alias vmstart_1080="xfreerdp /v:192.168.122.246:3389 /w:1920 /h:1080 /bpp:32 +clipboard +fonts /gdi:hw /rfx /rfx-mode:video /sound:sys:pulse +menu-anims +window-drag"
alias vim="nvim"
alias ch="charcoal query"
# }}}

# FUNCTIONS{{{
oc() {
    local base_name=$(basename "$PWD")
    local path_hash=$(echo "$PWD" | md5sum | cut -c1-4)
    local session_name="${base_name}-${path_hash}"
    
    # Find available port
    local port=4096
    while [ $port -lt 5096 ]; do
        if ! lsof -i :$port >/dev/null 2>&1; then
            break
        fi
        port=$((port + 1))
    done
    
    export OPENCODE_PORT=$port
    
    if [ -n "$TMUX" ]; then
        opencode --port $port "$@"
    else
        local oc_cmd="OPENCODE_PORT=$port opencode --port $port $*; exec $SHELL"
        if tmux has-session -t "$session_name" 2>/dev/null; then
            tmux new-window -t "$session_name" -c "$PWD" "$oc_cmd"
            tmux attach-session -t "$session_name"
        else
            tmux new-session -s "$session_name" -c "$PWD" "$oc_cmd"
        fi
    fi
}

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

aoe-add() {
    # 1. Determine the current directory name for the group
    local group_name=$(basename "$PWD")

    # 2. Get the branch/task name from the first argument
    local target="$1"

    # 3. Check if an argument was actually provided
    if [ -z "$target" ]; then
        echo "Usage: aoe-add <branch-name>"
        return 1
    fi

    # 4. Execute the command
    # .                -> current directory
    # -c opencode      -> constant
    # -g $group_name   -> derived from folder
    # -t $target       -> from argument
    # -w $target       -> from argument
    # -b               -> constant
    aoe add . -c opencode -g "$group_name" -t "$target" -w "$target" -b
}

tmux
