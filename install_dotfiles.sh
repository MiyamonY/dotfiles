#!/bin/sh

if [ ! -f /usr/bin/stow ]; then
   sudo pacman -U https://archive.archlinux.org/packages/s/stow/stow-2.2.2-5-any.pkg.tar.xz
fi

stow -R -v -d . -t ~/.config starship stumpwm fish tmux
stow -R -v -d . -t ~ bash bash git xmodmap xwindow utop

ln -s $(pwd)/.emacs.d ${HOME}/

echo $'\e[1;31m edit .gitconfig.local \e[m'
