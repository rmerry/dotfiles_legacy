" Environment Settings
"---------------------
set nocompatible "Force not to run like vi
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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
" Line Numbers
"----------------
"set relativenumber
set number
" Plugins
"--------
execute pathogen#infect()
let g:OmniSharp_timeout = 1
"Showmatch significantly slows down omnicomplete
""when the first match contains parentheses.
set noshowmatch
"Super tab settings - uncomment the next 4 lines
""let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
""let g:SuperTabDefaultCompletionTypeDiscovery =
set completeopt=longest,menuone,preview
