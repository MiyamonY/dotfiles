#! /bin/bash
source ~/.bashrc

# OPAM configuration
. /Users/ymiyamoto/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export PATH="${HOME}/.anyenv/envs/nodenv/shims:${HOME}/bin:$PATH"
