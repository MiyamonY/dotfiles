#!/bin/sh

CURDIR=$(cd $(dirname ${0}) && pwd)

ln -s ${CURDIR}/.bash_profile ${HOME}/
ln -s ${CURDIR}/.bashrc ${HOME}/
ln -s ${CURDIR}/.emacs.d ${HOME}/
ln -s ${CURDIR}/.gitconfig ${HOME}/
ln -s ${CURDIR}/.gitignore_global ${HOME}/
ln -s ${CURDIR}/.ddskk ${HOME}/
ln -s ${CURDIR}/.Brewfile ${HOME}/
ln -s ${CURDIR}/.latexmk ${HOME}/
ln -s ${CURDIR}/.zshrc ${HOME}/

if [ ! -e ${HOME}/.gitconfig ]; then
   cp ${CURDIR}/.gitconfig.local ${HOME}/
fi

echo $'\e[1;31m edit .gitconfig.local \e[m'
