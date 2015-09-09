#! /bin/sh

### for brew cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"

# brew
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

export HOMEBREW_BREWFILE=~/.Brewfile

# PS1
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\ \ $ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

### alias
if [ "$(uname)" = 'Darwin' ]; then
    export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
fi

### for python
## virtualenvwrapper for python
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

PIP_DOWNLOAD_CACHE=~/.pip_cache
if [ -e ${WORKON_HOME} ]; then
    cp -f ~/projects/dotfiles/python/postmkvirtualenv ${WORKON_HOME}/
fi

### for pic micon
export PATH="$PATH:/Applications/microchip/xc8/v1.35/bin"
