#!/bin/sh

CURDIR=$(cd $(dirname ${0}) && pwd)

if [ ! -e ${HOME}/.config ]; then
    mkdir ${HOME}/.config
fi

if [ ! -e ${HOME}/.config/fish ]; then
    mkdir ${HOME}/.config/fish
fi

if [ ! -e ${HOME}/.config/alacritty ]; then
    mkdir ${HOME}/.config/alacritty
fi

stow -R -v -d . -t ~/.config starship

ln -s ${CURDIR}/.bash_profile ${HOME}/
ln -s ${CURDIR}/.bashrc ${HOME}/
ln -s ${CURDIR}/.emacs.d ${HOME}/
ln -s ${CURDIR}/.gitconfig ${HOME}/
ln -s ${CURDIR}/.gitignore_global ${HOME}/
ln -s ${CURDIR}/.latexmkrc ${HOME}/
ln -s ${CURDIR}/.Xmodmap ${HOME}/
ln -s ${CURDIR}/.Xresources ${HOME}/
ln -s ${CURDIR}/.gtkrc-2.0 ${HOME}/
ln -s ${CURDIR}/.xinitrc ${HOME}/
ln -s ${CURDIR}/.xprofile ${HOME}/
ln -s ${CURDIR}/config.fish ${HOME}/.config/fish/
ln -s ${CURDIR}/alacritty.yml ${HOME}/.config/alacritty/
ln -s ${CURDIR}/.tmux.conf ${HOME}/
ln -s ${CURDIR}/stumpwm ${HOME}/.config/
ln -s ${CURDIR}/.ocamlinit ${HOME}/

if [ ! -e ${HOME}/.gitconfig.local ]; then
   cp ${CURDIR}/.gitconfig.local ${HOME}/
fi

echo $'\e[1;31m edit .gitconfig.local \e[m'
