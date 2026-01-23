git-worktree-wrapper() {
  local option=${1:-}
  local selected=$(git wt | tail -n +2 | fzf | awk '{print $(NF-1)}')
  
  if [ -n "${selected:-}" ]; then
    git wt ${option} "${selected}"

    if zle >/dev/null 2>&1; then
      # pure の git 更新を “いま” 起動する（precmd を待たない）
      (( $+functions[prompt_pure_async_tasks] )) && prompt_pure_async_tasks
      zle .reset-prompt
      zle -R
    fi
  fi
}
zle -N git-worktree-wrapper
alias gwt="git-worktree-wrapper"
