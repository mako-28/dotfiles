# zshrc
umask 022
bindkey -e
autoload -U compinit promptinit colors
compinit
colors
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b] (%a)'

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ -f ~/.dir_colors ]] ; then
  eval $(dircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
  eval $(dircolors -b /etc/DIR_COLORS)
fi

PLATHOME=$(uname)

case ${PLATHOME} in
Linux)
  alias ls='ls --color=auto'
  ;;

Darwin)
  alias ls='ls -G'
  ;;
esac

alias less='less -M'
alias grep='grep --colour=auto'
alias emacs='emacs -nw'
alias vi='vim'

PROMPT="%{$fg[green]%}%#%{$reset_color%} "
LESS="--tabs=4 --no-init"
export EDITOR=vim

case ${TERM} in
*)
  precmd() {
    # for vcs_info
    psvar=()
    LANG=en_US.UTF-8 vcs_info

    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
    PROMPT="%{%(?.$fg[cyan].$fg[red])%}%n%{$reset_color%} %% "
    RPROMPT="[%~] %1(v|%F{green}%1v%f|)"

    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%F{yellow}<@%m>:${PROMPT}"

    #echo -ne "\033]0;${USER}@${HOST%%.*}\007"
 }
  ;;
esac

# Ctrl <--> で単語移動
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# 単語区切りから'/'を除く
export WORDCHARS='*?[]~=&;!#$%^(){}<>'

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd
# 補完候補が複数ある時に、一覧表示する
setopt auto_list
# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
# コマンドのスペルチェックをする
setopt correct
# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
# share command history data
setopt share_history
# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt NO_hup
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types
# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit
# 戻り値が 0 以外の場合終了コードを表示する
setopt print_exit_value
# rm_star_silent の逆で、10 秒間反応しなくなり、頭を冷ます時間が与えられる
setopt rm_star_wait
# for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops
# 色を使う
setopt prompt_subst
# シェルのプロセスごとに履歴を共有
setopt share_history
# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
# 文字列末尾に改行コードが無い場合でも表示する
unsetopt promptcr
# コピペの時rpromptを非表示する
setopt transient_rprompt
# cd -[tab] でpushd
setopt autopushd

