#!/bin/sh

CURDIR=$(cd $(dirname ${0}) && pwd)

if [ ! -e ${HOME}/.config ]; then
    mkdir ${HOME}/.config
fi

ln -s ${CURDIR}/.bash_profile ${HOME}/
ln -s ${CURDIR}/.bashrc ${HOME}/
ln -s ${CURDIR}/.emacs.d ${HOME}/
ln -s ${CURDIR}/.gitconfig ${HOME}/
ln -s ${CURDIR}/.gitignore_global ${HOME}/
ln -s ${CURDIR}/.Brewfile ${HOME}/
ln -s ${CURDIR}/.latexmkrc ${HOME}/
ln -s ${CURDIR}/.zshrc ${HOME}/
ln -s ${CURDIR}/.Xmodmap ${HOME}/
ln -s ${CURDIR}/.keysnail.js ${HOME}/
ln -s ${CURDIR}/byobu ${HOME}/.config/

if [ ! -e ${HOME}/.gitconfig.local ]; then
   cp ${CURDIR}/.gitconfig.local ${HOME}/
fi

echo $'\e[1;31m edit .gitconfig.local \e[m'
