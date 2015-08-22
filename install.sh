#!/bin/sh


CURDIR=$(cd $(dirname ${0}) && pwd)

ln -s ${CURDIR}/.bash_profile ${HOME}/
ln -s ${CURDIR}/.bashrc ${HOME}/
ln -s ${CURDIR}/.emacs.d ${HOME}/
ln -s ${CURDIR}/.gitconfig ${HOME}/
ln -s ${CURDIR}/.ddskk ${HOME}/
