if test ! -e $HOME/.config/fish/functions/fisher.fish
  echo "fisher not found. Install fisher."
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
end

set -x GOPATH $HOME
set -x PATH $PATH $GOPATH/bin

alias open=xdg-open
alias rm='mv --backup=numbered --target-directory=$HOME/.Trash'
status --is-login; and status --is-interactive; and exec byobu-launcher
