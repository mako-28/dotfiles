# Load .zshrc if it exists for interactive login shells
if [[ -o interactive ]]; then
  if [[ -f "$HOME/.zshrc" ]]; then
    source "$HOME/.zshrc"
  fi
fi
