# miseがあったらそれを有効にする
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
else
  # miseがいなくてasdfがインストールされている時
  if command -v asdf >/dev/null 2>&1; then
    eval "$(asdf init zsh)"
    [ -f "${HOME}/.asdf/plugins/java/set-java-home.zsh" ] && source "${HOME}/.asdf/plugins/java/set-java-home.zsh"
  fi
fi
