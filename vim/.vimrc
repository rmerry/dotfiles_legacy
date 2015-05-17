set nocompatible "Force not to run like vi
filetype off

" Plugins
"--------
" Vundle specific settings NOTE: Vundle must be installed in the ~/[.vim|vimfiles]/bundle folder
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" All plugins must go here
Plugin 'altercation/vim-colors-solarized'

" Fuzzy file buffer searching
Plugin 'kien/ctrlp.vim'

" File browser
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on


" Environment Settings
"
"---------------------
set background=dark
syntax on

" Buffer Settings
"----------------
set hidden "no need to save buffer before viewing another one

" Richard's GVim Options
"-----------------------
:set guioptions+=m "menu bar
:set guioptions-=T "toolbar
:set guioptions+=r "right-hand scroll bar
:set guioptions-=L "left-hand scroll bar
" Backspace not working on windows
set bs=2

" Colours
"----------------
if has('gui_running')
    colorscheme solarized
else
    colorscheme solarized
endif

" Editor options
" --------------
set helpheight=100 "Full screen help
set nowrap

" Tab Option
"----------------
set expandtab
set smartindent

set shiftwidth=2
set softtabstop=2
set tabstop=2

" Swap File options
" -----------------
set noswapfile

" Line Numbers
"----------------
"set relativenumber
set number

