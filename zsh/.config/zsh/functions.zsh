# make ssh_auth_sock for tmux/screen/zellij
function attach_ssh_auth_sock() {
  # SSH経由の場合のみ実行
  if [[ -n "${SSH_CLIENT}" ]] || [[ -n "${SSH_CONNECTION}" ]] || [[ -n "${SSH_TTY}" ]]; then
    if [ ! -z "${SSH_AUTH_SOCK}" -a "${SSH_AUTH_SOCK}" != "${HOME}/.ssh/agent_sock" ] ; then
      # SSH_AUTH_SOCKの有効性チェック
      if [ ! -S "${SSH_AUTH_SOCK}" ]; then
        echo "Error: SSH_AUTH_SOCK points to invalid socket: ${SSH_AUTH_SOCK}" >&2
        return 1
      fi
      
      # 既存リンク削除
      unlink "${HOME}/.ssh/agent_sock" 2>/dev/null
      
      # シンボリックリンク作成
      if ln -s "${SSH_AUTH_SOCK}" "${HOME}/.ssh/agent_sock"; then
        export SSH_AUTH_SOCK="${HOME}/.ssh/agent_sock"
        echo "SSH agent socket updated"
      else
        echo "Error: Failed to create SSH agent socket link" >&2
        return 1
      fi
    fi
  fi
}

# vscodeから起動されてorphanedになったjavaを止める
function kill-java() {
  pkill -P 1 -f "java .*/\.vscode"
  pkill -P 1 -f "java .* \.GradleDaemon"
  ps -ef | grep java | grep -v grep
}
