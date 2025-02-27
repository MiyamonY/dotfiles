### install fisher
if test ! -e $HOME/.config/fish/functions/fisher.fish
  echo "fisher not found. Install fisher."
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  fisher install decors/fish-ghq
end

### install starship
if test -e /usr/local/bin/starship
  starship init fish | source
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

# reload fish config
function reload
  exec fish
end

# right prompt
function fish_right_prompt
  date "+%y/%m/%d %T.%3N"
end

# sync history
function sync_history --on-event fish_preexec
 history --save
 history merge
end

# alias
alias rm='mv --backup=numbered --target-directory=$HOME/.Trash'
alias git='hub'
alias open='xdg-open'
alias pc='git push -u origin HEAD; and gh pr create -w'
alias pm='gh pr merge --merge -d'

# opam configuration
source /home/ymiyamoto/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# mise
if test ! ~/.local/bin/mise
  ~/.local/bin/mise activate fish | source
end
# mise end
