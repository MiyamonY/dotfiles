### コマンド引数の補完
autoload -U compinit
compinit

### cd無しでカレントディレクトリの移動
setopt auto_cd

### 移動履歴を保存
setopt auto_pushd

### 補完候補を短かく表示
setopt list_packed

### 予測補完
autoload predict-on
predict-on

### emacsのキーを使用する
bindkey -e

### プロンプトの変更
autoload colors
colors
case ${UID} in
0)
  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac


### 環境変数
export OCAMLPARAM=_,g=1,bin-annot=1

## lsの色(ターミナルの背景色によって色を変える)
case "${TERM}" in
kterm*|xterm*)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    # zshの補完のカラー表示
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

### alias
setopt complete_aliases
alias git="hub"                 # gitはhubコマンドを使用する
alias ls="ls -G"                # カラー表示
alias gcc="gcc-4.9"             # gcc

### opam
. /Users/y.miyamoto/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### python virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi
