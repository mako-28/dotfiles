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
set background=dark
set mouse=a
set ttymouse=xterm2
"set ambiwidth=double                " ○とか↑とかの幅。
set nu

" --- 全角スペースの表示 ---
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" --- ファイルタイプ別の設定 ---
if has("autocmd")
  filetype plugin on "ファイルタイプの検索を有効にする
  filetype indent on "そのファイルタイプにあわせたインデントを利用する

  autocmd FileType html :set indentexpr=
  autocmd FileType xhtml :set indentexpr=
endif

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

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" autocmd BufNewFile *.{py,php,txt,css,htm*}{,.in} set fileencoding=utf-8


" --- ステータスラインの表示 ---
let &statusline = ''
let &statusline .= '%<%f %h%m%r%w'
let &statusline .= '%='
let &statusline .= '[%{&fileencoding == "" ? &encoding : &fileencoding}]'
let &statusline .= '[%{&ff}]'
let &statusline .= '  %-14.(%l,%c%V%) %P'
set laststatus=2

" --- キーマップ ---
imap {<Space>} {}<Left>
imap [<Space>] []<Left>
imap (<Space>) ()<Left>
imap "<Space>" ""<Left>
imap '<Space>' ''<Left>
imap <<Space>> <><Left>
nmap <ESC><ESC> :nohlsearch<CR>

"コンマの後に自動的にスペースを挿入
inoremap , ,<Space>
