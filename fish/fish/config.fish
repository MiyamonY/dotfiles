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

# pnpm
set -gx PNPM_HOME "/home/ymiyamoto/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

function create_tmux_session --description 'create tmux session for current directory'
  tmux new -s $(basename $(pwd)) -d  -c $(pwd)
  echo "session created"
end


function select_tmux_session --description 'select tmux session by fzf'
  if not tmux has-session 2>/dev/null
    echo "No tmux sessions found."
    return 1
  end

  set -l target_session (tmux ls -F '#S' | fzf --reverse --prompt="Select Tmux Session> " --preview="tmux list-windows -t {}")

  if test -z "$target_session"
    commandline -f repaint
    return
  end

  if set -q TMUX
    tmux switch-client -t "$target_session"
  else
    tmux attach-session -t "$target_session"
  end
end

function fish_user_key_bindings
  bind \cn create_tmux_session
  bind \ck select_tmux_session
end
