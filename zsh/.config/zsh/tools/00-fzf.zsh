# ~/.config/zsh/tools/fzf.zsh

# fzf コマンドが存在しない場合
if ! command -v fzf >/dev/null 2>&1; then
    bindkey '^r' history-incremental-search-backward
    return # ここでおしまい
fi

# --- fzf コマンドが存在する場合のみ、以下の設定が適用される ---

# --layout=reverse で入力プロンプトを上部に表示
export FZF_DEFAULT_OPTS="--layout=reverse --height=50%"

# fzfの初期化スクリプトを読み込む
eval "$(fzf --zsh)"

# fzfを使った履歴検索のキーバインディング (fzf --zsh が提供するウィジェット)
zle -N fzf-history-widget
bindkey '^r' fzf-history-widget

# --- Git + FZF 連携関数群 ---
# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf --ansi --reverse +m) &&
  git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --height=100% --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# git branch検索 (ユーザー名で色分け)
function select-git-branch-friendly() {
  local user_name=$(git config user.name 2>/dev/null) # 関数内で取得し、エラーを抑制
  local fmt="\
%(if:equals=$user_name)%(authorname)%(then)%(color:default)%(else)%(color:brightred)%(end)%(refname:short)|\
%(committerdate:relative)|\
%(subject)"
  selected_branch=$(
    git branch --sort=-committerdate --format=$fmt --color=always \
    | column -ts'|' \
    | fzf --ansi --exact --reverse --height=100% --preview-window=down --preview='git log --oneline --graph --decorate --color=always -50 {+1}' \
    | awk '{print $1}' \
  )
  BUFFER="${LBUFFER}${selected_branch}${RBUFFER}"
  CURSOR=$#LBUFFER+$#selected_branch
  zle redisplay
}
zle -N select-git-branch-friendly # ZLEウィジェットとして登録

# git commit検索
function select-git-commit() {
  selected_commit=$(
    git log -n1000 --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
    | fzf -m --ansi --no-sort --reverse --height=100% --preview-window=down --tiebreak=index --preview 'f() {
        set -- $(echo "$@" | grep -Eo "[a-f0-9]{7,}" | head -1);
        if [ $1 ]; then
          git show --color $1
        else
          echo "blank"
        fi
      }; f {}' \
    | grep -o "[a-f0-9]{7}" \
    | tr '\n' ' ' \
  )
  echo ${selected_commit} # 複数選択の場合などデバッグ用に残す
  BUFFER="${LBUFFER}${selected_commit}${RBUFFER}"
  CURSOR=$#LBUFFER+$#selected_commit
  zle redisplay
}
zle -N select-git-commit # ZLEウィジェットとして登録

function select-git-commit-all() {
  select-git-commit "--all"
}
zle -N select-git-commit-all # ZLEウィジェットとして登録

function gtw() {
  # git管理下チェック
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not inside a git repository." >&2
    return 1
  fi

  # worktree全体の件数を数える
  local total
  total=$(git worktree list --porcelain | grep -c '^worktree ')
  # メイン1件のみなら何もせず終了
  if [[ -z "${total}" || "${total}" -le 1 ]]; then
    return 0
  fi

  # fzfに出す一覧を作成（branchが無い=メイン/DETACHEDも拾う）
  local wt_list
  wt_list=$(git worktree list --porcelain | awk '
    /^worktree / { path=$2; branch="" }
    /^branch /   { branch=$2 }
    /^$/         { if (path!="") { print (branch==""?"(MAIN/DETACHED)":branch) "\t" path; path=""; branch="" } }
    END          { if (path!="") print (branch==""?"(MAIN/DETACHED)":branch) "\t" path }
  ')

  # 念のため空なら終了
  [[ -z "${wt_list}" ]] && return 0

  # fzfで選択（2列目のpathをプレビュー/移動に利用）
  local selection
  selection=$(echo "${wt_list}" \
    | fzf --ansi --no-sort --prompt="Select worktree> " \
          --with-nth=1,2 \
          --preview='cd -- {2} 2>/dev/null && git status -sb 2>/dev/null || echo "Not a git dir: {2}"' \
          --preview-window=down:50%)

  [[ -z "${selection}" ]] && return 0

  local dir
  dir=$(echo "${selection}" | cut -f2)

  if [[ -d "${dir}" ]]; then
    cd "${dir}" || return 1
    REPLY="Moved to $dir"
    if ! zle >/dev/null 2>&1; then
      print -r -- "$REPLY"
    fi
  else
    echo "Directory not found: ${dir}" >&2
    return 1
  fi
}

function select-git-worktree() {
  emulate -L zsh
  setopt localoptions noshwordsplit pipefail

  zle -I
  REPLY=""
  gtw
  [[ -n "$REPLY" ]] && zle -M -- "$REPLY"
  zle reset-prompt
}
zle -N select-git-worktree

