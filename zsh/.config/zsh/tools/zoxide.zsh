# zoxide コマンドが存在する場合のみ初期化する
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi
