" vi: set ft=vim :
"" vimrcのリロードは :so %

set nocompatible
set incsearch
set hlsearch
set smartcase                       " 検索文字列に大文字が含まれている場合は区別して検索する
set backspace=indent,eol,start
set autoindent                      " ペースト時は:a!の後にペーストするとインデントしない
set history=50
set ruler
set showcmd
set showmode
set showmatch
set nowrap
set list
set listchars=trail:-,tab:>-
set display=uhex
set cursorline
set expandtab
set tabstop=4                       " >>, << でインデントレベルを変えられるよ
set softtabstop=0                   "Tabが押されたときはtabstopと同じだけのスペースを挿入
set shiftwidth=4
syntax enable
set ttymouse=xterm2
set ambiwidth=double                " ○とか↑とかの幅。
set nu
set wildignorecase                  " 大文字小文字を無視してcdなどする
set directory=~/tmp/vimswaps/           " location of swapfiles
set timeout timeoutlen=1000 ttimeoutlen=75  " Escの反応を速く

" --- 環境変数を追加する
if has('win32') || has('win64')
    let $PATH = expand($PATH) . ';C:/Program Files/Python27'
endif

" --- 全角スペースの表示 ---
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" --- 文字コード関連の設定 ---
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8

" 文字コードの自動判別
if !exists('did_encoding_settings') && has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213 ?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Make fileencodings
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else  " cp932
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis

  let did_encoding_settings = 1
endif

" --- ステータスラインの表示 ---
let &statusline = ''
let &statusline .= '%<%f %h%m%r%w'
let &statusline .= '%='
let &statusline .= '[%{&fileencoding == "" ? &encoding : &fileencoding}]'
let &statusline .= '[%{&ff}]'
let &statusline .= '  %-14.(%l,%c%V%) %P'
set laststatus=2

"tab
source ~/.config/vim/rc/tabutils

"neobundle
source ~/.config/vim/rc/neobundle

"autocmd
source ~/.config/vim/rc/autocmd

"keymaps
source ~/.config/vim/rc/keymaps

"colorscheme
set t_Co=256
colorscheme jellybeans

"neocomplcache
source ~/.config/vim/rc/neocomplecache

"neosnippet
source ~/.config/vim/rc/neosnippet
