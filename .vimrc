set encoding=utf-8
scriptencoding utf-8
syntax enable
colorscheme molokai
set t_Co=256
set autoindent
set smartindent
set smarttab
set noswapfile
set clipboard=unnamedplus
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" 隣接した{}で改行したらインデント
function! Indent2()
    let nowletter = getline(".")[col(".")-1]    " 今いるカーソルの文字
    let beforeletter = getline(".")[col(".")-2] " 1つ前の文字

    " カーソルの位置の括弧が隣接している場合
    if nowletter == "}" && beforeletter == "{"
        return "\n  \n\<UP>\<RIGHT>\<RIGHT>"
    else
        return "\n"
    endif
endfunction

" ファイルタイプ検出を有効にする
filetype on

augroup vimrc
    " 以前の autocmd コマンドをクリア
    autocmd!

    " C/C++/Java 言語系のファイルタイプが設定されたら cindent モードを有効にする
    autocmd FileType c,cpp,java  setl cindent
    autocmd FileType c,cpp,java  setl expandtab tabstop=2 shiftwidth=2 softtabstop=2 shiftround
    autocmd FileType c,cpp,java  inoremap { {}<LEFT>
    autocmd FileType c,cpp,java  inoremap <silent> <expr> <CR> Indent2()
augroup END

" ファイルを開いたときに最後に合ったカーソルの位置に移動する
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
