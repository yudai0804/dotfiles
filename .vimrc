" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible
set encoding=UTF-8
" Set Dein base path (required)
let s:dein_base = "/home/" .. $USER .. "/.cache/dein"
" Set Dein source path (required)
let s:dein_src = "/home/" .. $USER .. "/.cache/dein/repos/github.com/Shougo/dein.vim"
" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('altercation/vim-colors-solarized')
call dein#add('junegunn/fzf')
call dein#add('junegunn/fzf.vim')
call dein#add('preservim/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
"nerd-fontsを別でインストールしないとvim-deviconsは使えないので注意
call dein#add('ryanoasis/vim-devicons')
"call dein#add('itchyny/lightline.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('tpope/vim-fugitive')
" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
"if has('syntax')
"  syntax on
"endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
   set t_ut=
endif

syntax enable
set background=dark
colorscheme solarized

" nerdree
" 常にNERDTreeを表示する
"autocmd VimEnter * execute 'NERDTree'
" 隠しファイルを表示する
let NERDTreeShowHidden = 1
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" 行数を表示
set number
" 行末を '↲'、タブを '>-'、末尾のスペースを '_' で表示
set listchars=eol:↲,tab:>-,trail:_
set list
"-------------------------
" Show double byte spaces
"-------------------------
hi DoubleByteSpace term=underline ctermbg=blue guibg=darkgray
match DoubleByteSpace /　/

"set laststatus=2
let g:airline_poerline_fonts=1
let g:airline_theme='solarized'
" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

