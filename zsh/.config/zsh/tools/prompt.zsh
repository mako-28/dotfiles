# prompt設定
# pureをsheldonで有効にしている時
if (( $+functions[prompt_pure_setup] )); then
  zstyle :prompt:pure:path color blue
  zstyle :prompt:pure:git:branch color magenta
  zstyle :prompt:pure:git:action color magenta
  zstyle :prompt:pure:git:arrow color magenta

  ## change the color for both `prompt:success` and `prompt:error`
  zstyle ':prompt:pure:prompt:error' color red
  zstyle ':prompt:pure:prompt:success' color cyan
fi
