# sheldon コマンドが存在する場合のみ初期化する
if command -v sheldon >/dev/null 2>&1; then
    eval "$(sheldon source)"
fi
