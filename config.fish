### install fisher
if test ! -e $HOME/.config/fish/functions/fisher.fish
  echo "fisher not found. Install fisher."
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
end

### change keymap
xmodmap ~/.Xmodmap

### setting for golang and ghq
set -x GOPATH $HOME
set -x PATH $PATH $GOPATH/bin

### setting for byobu
set -x BYOBU_CONFIG_DIR ~/.config/byobu
if test -e /usr/bin/byobu-launcher
  status --is-interactive; and env _byobu_sourced=1 /usr/bin/byobu-launcher
end

### alias
if test ! -e $HOME/.Trash
  mkdir $HOME/.Trash
end
alias rm='mv --backup=numbered --target-directory=$HOME/.Trash'

function awesome-test
  Xephyr :1 -ac -br -noreset -screen 1152x720 &
  env DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua
end
