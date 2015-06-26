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
Plugin 'morhetz/gruvbox'

" Fuzzy file buffer searching
Plugin 'kien/ctrlp.vim'

" File browser
Plugin 'scrooloose/nerdtree'

" Tern (make sure you 'npm install tern' in the term_for_vim folder
" This provides JavaScript omni-completion
Plugin 'marijnh/tern_for_vim'

" JSHint Implemention
" " JSHint should be intalled on the system, i.e., 'sudo npm install -g
" jshint'
Plugin 'walm/jshint.vim'

" Syntactic
" Integrates with external 3rd party syntax checkers and displays errors on
" save
Plugin 'scrooloose/syntastic'

call vundle#end()
filetype plugin indent on

" Plugin Specific Settings
" ------------------------
" Tern
let g:tern_map_keys=1
let g:tern_show_argument_hints='on_hold'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
let g:solarized_termcolors=256

if has('gui_running')
    colorscheme gruvbox
    set background=light
else
    "colorscheme ron
    colorscheme gruvbox
    set background=dark
endif

" Editor options
" --------------
set helpheight=100 "Full screen help
set nowrap

" Mouse Support In Terminal
" -------------------------
set mouse=a

" Turn on Fast TTY by Default
" ---------------------------
set ttyfast
set lazyredraw

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

set t_Co=256
