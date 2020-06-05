#! /bin/bash
source ~/.bashrc

export PATH="$PATH:/Applications/microchip/xc8/v1.35/bin"

# OPAM configuration
. /Users/ymiyamoto/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
export XML_CATALOG_FILES=/usr/local/etc/xml/catalog

export PATH="$PATH:/Applications/microchip/xc8/v1.37/bin"

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
