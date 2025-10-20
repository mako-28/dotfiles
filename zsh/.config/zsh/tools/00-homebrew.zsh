# 共通のHomebrewインストールパス候補を定義
HOMEBREW_CANDIDATE_PREFIXES=(
  "/opt/homebrew"          # mac
  "/home/linuxbrew/.linuxbrew" # linux
)

FOUND_BREW_EXECUTABLE=""
for prefix in "${HOMEBREW_CANDIDATE_PREFIXES[@]}"; do
  # 各プレフィックス内の bin/brew 実行ファイルが存在するかチェック
  if [ -x "${prefix}/bin/brew" ]; then
    FOUND_BREW_EXECUTABLE="${prefix}/bin/brew"
    break # 見つかったらループを終了
  fi
done

# brew 実行ファイルが見つかった場合のみ shellenv を実行
if [ -n "${FOUND_BREW_EXECUTABLE}" ]; then
  eval "$("${FOUND_BREW_EXECUTABLE}" shellenv)"
fi
