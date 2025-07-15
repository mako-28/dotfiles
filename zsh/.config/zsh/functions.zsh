# make ssh_auth_sock for tmux/screen
function attach_ssh_auth_sock() {
  if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
    unlink "$HOME/.ssh/agent_sock" 2>/dev/null
    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
  fi
}

# vscodeから起動されてorphanedになったjavaを止める
function kill-java() {
  pkill -P 1 -f "java .*/\.vscode"
  pkill -P 1 -f "java .* \.GradleDaemon"
  ps -ef | grep java | grep -v grep
}
