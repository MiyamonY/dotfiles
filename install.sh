#!/bin/sh


CURDIR=$(cd $(dirname ${0}) && pwd)

ln -s ${CURDIR}/.emacs.d ${HOME}/
ln -s ${CURDIR}/.gitconfig ${HOME}/
