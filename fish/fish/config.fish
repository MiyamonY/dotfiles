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

function fish_user_key_bindings
  bind \cn create_tmux_session
end

function gc --description "Generate a commit message with AI and commit"
    set -l commit_title (claude -p "Look at the staged git changes and create a summarizing git commit title. Only respond with the title and no affirmation." | string trim)

    if test -n "$commit_title"
        git commit -m "$commit_title" $argv
    else
        echo "AIによるコミットメッセージの生成に失敗しました。"
        echo "通常のgit commitを実行してください。"
    end
end
