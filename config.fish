### install fisher
if test ! -e $HOME/.config/fish/functions/fisher.fish
  echo "fisher not found. Install fisher."
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  fisher omf/emacs
  fisher nesl247/fish-theme-dracula
  fisher decors/fish-ghq
end

### setting for golang and ghq
set -x SHELL (which fish)
set -x GOPATH $HOME
set -x PATH $PATH $GOPATH/bin

### install fzf
if test ! -e $HOME/.fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  ~/.fzf/install --bin
end

### alias
if test ! -e $HOME/.Trash
  mkdir $HOME/.Trash
end

### function for awesome test
function awesome-test
  Xephyr +xinerama :1 -ac -br -noreset -screen 1152x720 -screen 1152x720 &
  env DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua
end

# sync history
function sync_history --on-event fish_preexec
 history --save
 history merge
end

# anyenv
if test ! -e $HOME/.anyenv
  git clone https://github.com/riywo/anyenv ~/.anyenv
end

if test -e $HOME/.anyenv
  set -x PATH $HOME/.anyenv/bin $PATH
  status --is-interactive; and source (anyenv init -|psub)
end

# alias
alias rm='mv --backup=numbered --target-directory=$HOME/.Trash'
alias git='hub'
alias open='xdg-open'
