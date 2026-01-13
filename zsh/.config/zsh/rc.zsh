# XDG Directory
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

# キーバインディング
bindkey -e # Emacs風キーバインディング

# 言語とロケール
export LANG="ja_JP.UTF-8"

# 補完設定
autoload -Uz compinit
compinit -u -d "${XDG_CACHE_HOME}/zsh"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 小文字でも大文字ディレクトリを補完

# 履歴設定
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export HISTSIZE=10000
export SAVEHIST=100000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

# Zsh オプション
setopt no_flow_control # Ctrl+S, Ctrl+Q によるフローコントロールを無効化

# 汎用的なキーバインディング (Home/Endキー)
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
