#!/usr/bin/bash
cname=ros-gui
if [[ -n $(command -v docker) ]];then
  docker run -itd \
           -e DISPLAY \
           --gpus all \
           --user=`id -u`:`id -g` \
           -v /tmp/.X11-unix/:/tmp/.X11-unix/  \
           -v /usr/bin/prime-run:/usr/bin/prime-run \
           -v ~/dotfiles:/home/docker/dotfiles \
           -v /mnt/share/Programming/:/mnt/share/Programming \
           --privileged \
           --network host \
           --name $cname ros-docker-gui:noetic-desktop-full
  
  docker cp $0 ros-gui:setup.sh
  # add xauth
  token=$(xauth list)
  docker exec -u0 $cname bash -c "/setup.sh $token"
else #inside docker
  user=docker
  apt-get update
  apt-get install -y stow neovim tmux python3-pip ranger clangd python3-rosdep
  chsh -s /usr/bin/zsh $user
  cd /home/$user/dotfiles
  sudo -u $user stow .
  # install vim plugin
  sudo -u $user sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  # add xauth
  xauth add $1
fi
