# キーバインディング
bindkey -e # Emacs風キーバインディング

# 言語とロケール
export LANG="ja_JP.UTF-8"

# cdr (ディレクトリ履歴移動) 設定
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
autoload -Uz colors && colors
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both
zstyle ":completion:*:commands" rehash 1

# 補完設定
autoload -Uz compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 小文字でも大文字ディレクトリを補完

# 履歴設定
export HISTFILE=~/.zsh_history
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
