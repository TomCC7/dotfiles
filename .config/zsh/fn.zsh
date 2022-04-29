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

# usage: find_up pattern
# recursively find in parent dir until found
function find_up() {
  while [[ $PWD != "/" ]] ; do
    res=$(find "$PWD"/ -maxdepth 1 "$@")
    if [[ -z $res ]]; then
      cd ..
    else
      echo $res
      return
    fi
  done
}

function rosource() {
  source $(find_up -name "devel")/setup.zsh
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
