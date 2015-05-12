" Environment Settings
"---------------------
set nocompatible "Force not to run like vi
set background=dark
syntax on
filetype off

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
    colorscheme codeschool
else
    colorscheme ron
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

" Plugins
"--------
" Vundle specific settings NOTE: Vundle must be installed in the ~/[.vim|vimfiles]/bundle folder
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" All plugins must go here

call vundle#end()
filetype plugin indent on
