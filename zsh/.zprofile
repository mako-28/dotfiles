# Load .zshrc if it exists for interactive login shells
if [[ -o interactive ]]; then
  if [[ -f "$HOME/.zshrc" ]]; then
    source "$HOME/.zshrc"
  fi

  [ -f /etc/profile.d/libvirt-uri.sh ] && . /etc/profile.d/libvirt-uri.sh
fi
