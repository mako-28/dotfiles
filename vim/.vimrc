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

