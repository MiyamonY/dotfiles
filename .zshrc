export LANG=ja_JP.UTF-8

### コマンド引数の補完
autoload -U compinit
compinit

### cd無しでカレントディレクトリの移動
setopt auto_cd

### 移動履歴を保存
setopt auto_pushd

# コマンドのスペルミスを指摘
setopt correct

### 補完候補
setopt list_packed
zstyle ':completion:*:default' menu select

# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups

# 重複するコマンドは古い法を削除する
setopt hist_ignore_all_dups

### 予測補完
# autoload predict-on
# predict-on

### emacsのキーを使用する
bindkey -e

setopt noautoremoveslash

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

### プロンプトの変更
# ${fg[...]} や $reset_color をロード
autoload -U colors; colors

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

case ${UID} in
0)
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  RPROMPT='%40<...<%~`rprompt-git-current-branch`($?)'
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  RPROMPT='%40<...<%~`rprompt-git-current-branch`($?)'
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
      PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '[%F{green}%b%f]'
zstyle ':vcs_info:*' actionformats '[%F{green}%b%f(%F{red}%a%f)]'
precmd() { vcs_info }

PROMPT='%n@%m:%~ # '
RPROMPT='${vcs_info_msg_0_}'

### 環境変数
export OCAMLPARAM=_,g=1,bin-annot=1

## lsの色(ターミナルの背景色によって色を変える)

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac

### alias
setopt complete_aliases
alias git="hub"                 # gitはhubコマンドを使用する
alias ls="ls -GF"                # カラー表示
alias gcc="gcc-4.9"             # gcc

### opam
eval `opam config env`

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### python virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi
export PATH=~/.cabal/bin:${PATH}
