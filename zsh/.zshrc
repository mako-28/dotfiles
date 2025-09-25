# 起動時間測定用
#zmodload zsh/zprof

# 共通設定
source ~/.config/zsh/rc.zsh
source ~/.config/zsh/variables.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/functions.zsh

# --- 各ツールの設定を ~/.config/zsh/tools/ から一括で読み込む ---
for tool_config in ~/.config/zsh/tools/*.zsh; do
  if [ -f "$tool_config" ]; then
    source "$tool_config"
  fi
done

# --- 各PC固有の設定を ~/.config/local/zsh/ から読み込む ---
# このファイルはリポジトリには含めず、各PCでシンボリックリンクを張るか直接作成
if [ -d ~/.config/local/zsh ]; then
  for local_config in ~/.config/local/zsh/*.zsh; do
    if [ -f "${local_config}" ]; then
      source "${local_config}"
    fi
  done
fi

# keybind
source ~/.config/zsh/keybinds.zsh

# 起動時間測定用
#zprof
