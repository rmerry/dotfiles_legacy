" Pre Initialisation Settings {{{

filetype off

if has("win32")
  set rtp+=$USERPROFILE/.vim/bundle/Vundle.vim
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif

" }}}

" Core Settings {{{

set nocompatible "Force not to run like vi
set helpheight=100 "Full screen help
set hidden " Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set bs=2 " Backspace not working on windows
set noswapfile
set ttyfast
set lazyredraw

" }}}

" Plugin Installation {{{

" Vundle specific settings NOTE: Vundle must be installed in the ~/[.vim|vimfiles]/bundle folder
call vundle#begin()

  Plugin 'mileszs/ack.vim'
  Plugin 'gmarik/Vundle.vim'
  Plugin 'altercation/vim-colors-solarized'
  Plugin 'morhetz/gruvbox'
  Plugin 'kien/ctrlp.vim' " Fuzzy file buffer searching
  " Plugin 'Valloric/YouCompleteMe' " YouCompleteMe - AutoComplete plugin
  Plugin 'scrooloose/nerdtree' " File browser
  " Vim JS Indent
  Plugin 'jelera/vim-javascript-syntax'
  Plugin 'vim-scripts/JavaScript-Indent'
  "Plugin 'pangloss/vim-javascript' " Better indentation and syntax highlighting
  "Plugin 'gavocanov/vim-js-indent' " Better than vim-javascript
  " Tern (make sure you 'npm install tern' in the term_for_vim folder
  " This provides JavaScript omni-completion
  Plugin 'marijnh/tern_for_vim'
  " JSHint should be intalled on the system, i.e., 'sudo npm install -g
  Plugin 'walm/jshint.vim'
  Plugin 'jpalardy/vim-slime'
  " Tools to make Vim superb for developing with Node.js.
  " It's the Node equivalent of Rails.vim (vimscript #1567) and Rake.vim (vimscript #3669).
  Plugin 'moll/vim-node'
  " Integrates with external 3rd party syntax checkers and displays errors on
  " Remember to do a 'npm install jshint -g' to get JavaScript linting working save
  Plugin 'scrooloose/syntastic'
  " Obsession.vim (Used to maintain session state [:mksession])
  Plugin 'tpope/vim-obsession'
  " Ack search plugin
  "Plugin 'mileszs/ack.vim'
  " Vim Tetris
  Plugin 'TeTrIs.vim'
  " Omnisharp (C# Development)
  Plugin 'OmniSharp/omnisharp-vim'
  " Vim Dispatch
  Plugin 'tpope/vim-dispatch'
  " NeoComplete
  Plugin 'Shougo/neocomplete.vim'
  " Vim Fugative (git integration)
  Plugin 'tpope/vim-fugitive'
  " Vim Cucumber
  Plugin 'tpope/vim-cucumber'
  " Vim Airline
  Plugin 'bling/vim-airline'

call vundle#end()            " required

" }}}

" Plugin Configuration {{{

  " Airline {{{

  let g:airline#extensions#tabline#enabled = 1

  " }}}

  " CtrlP {{{

  "  'c' - the directory of the current file.
  "  'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr
  "  'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
  "  0 or '' (empty string) - disable this feature.
  let g:ctrlp_working_path_mode = 'ra'

  " }}}

  " Neo Complete {{{

  let g:neocomplete#enable_at_startup=1

  " }}}

  " NERDTree {{{

  let g:nerdtree_tabs_open_on_gui_startup=1
  let g:nerdtree_tabs_open_on_console_startup=1
  let g:nerdtree_tabs_open_on_new_tab=1

  if has('gui_running')
    autocmd VimEnter *  NERDTree
  endif

  " }}}

  " OmniSharp {{{

  " Use Roslyn Compiler
  "let g:OmniSharp_server_type = 'v1'
  "let g:OmniSharp_server_type = 'roslyn'
  "This is the default value, setting it isn't actually necessary
  let g:OmniSharp_host = "http://localhost:2000"

  "Set the type lookup function to use the preview window instead of the status line
  "let g:OmniSharp_typeLookupInPreview = 1

  "Timeout in seconds to wait for a response from the server
  let g:OmniSharp_timeout = 1

  "Showmatch significantly slows down omnicomplete
  "when the first match contains parentheses.
  set noshowmatch

  "Super tab settings - uncomment the next 4 lines
  let g:SuperTabDefaultCompletionType = 'context'
  let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
  let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
  let g:SuperTabClosePreviewOnPopupClose = 1

  "don't autoselect first item in omnicomplete, show if only one item (for preview)
  "remove preview if you don't want to see any documentation whatsoever.
  set completeopt=longest,menuone,preview
  " Fetch full documentation during omnicomplete requests.
  " There is a performance penalty with this (especially on Mono)
  " By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
  " you need it with the :OmniSharpDocumentation command.
  " let g:omnicomplete_fetch_documentation=1

  "Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
  "You might also want to look at the echodoc plugin
  set splitbelow

  " Get Code Issues and syntax errors
  let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
  let g:syntastic_loc_list_height=2
  " If you are using the omnisharp-roslyn backend, use the following
  " let g:syntastic_cs_checkers = ['code_checker']

  " this setting controls how long to wait (in ms) before fetching type / symbol information.
  set updatetime=2000
  " Remove 'Press Enter to continue' message when type information is longer than one line.
  set cmdheight=2

  " Contextual code actions (requires CtrlP or unite.vim)
  nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
  " Run code actions with text selected in visual mode to extract method
  vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

  " rename with dialog
  nnoremap <leader>nm :OmniSharpRename<cr>
  nnoremap <F2> :OmniSharpRename<cr>
  " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
  command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

  " Force OmniSharp to reload the solution. Useful when switching branches etc.
  nnoremap <leader>rl :OmniSharpReloadSolution<cr>
  nnoremap <leader>cf :OmniSharpCodeFormat<cr>
  " Load the current .cs file to the nearest project
  nnoremap <leader>tp :OmniSharpAddToProject<cr>

  " (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
  nnoremap <leader>ss :OmniSharpStartServer<cr>
  nnoremap <leader>sp :OmniSharpStopServer<cr>

  " Add syntax highlighting for types and interfaces
  nnoremap <leader>th :OmniSharpHighlightTypes<cr>

  augroup omnisharp_commands

    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    "The following commands are contextual, based on the current cursor position.
    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

  augroup END

  " }}}

  " ShellCheck {{{

  autocmd Filetype sh set makeprg=shellcheck\ -f\ gcc\ % tabstop=4 sts=4 sw=4 et smarttab
  "autocmd BufWritePost * :silent make | redraw!

  " }}}

  " Solarized {{{

  let g:swlime_target = "tmux"
  let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
  " }}}

  " Solarized {{{

  let g:solarized_termcolors=256

  " }}}

  " Syntactic {{{

  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  " }}}

  " Tern {{{

  let g:tern_map_keys=1
  let g:tern_show_argument_hints='on_hold'
  let g:tern_request_timeout=5

  " }}}

  " TrafficScript {{{

  "filetype plugin on "Load filetype plugins.
  "#set completeopt=menuone,menu,longest,preview "Omni Complete options.

  " }}}

" }}}

" Chrome Settigns {{{

" gVim Settings {{{

:set guioptions-=m "menu bar
:set guioptions-=T "toolbar
:set guioptions-=r "right-hand scroll bar
:set guioptions-=L "left-hand scroll bar

" }}}

" Colours {{{

silent! colorscheme gruvbox
set background=dark
set t_Co=256

" }}}

" }}}

" Editor Settings {{{

  " Global (terminal and gVim) {{{

  "set relativenumber
  set number " Line numbers
  set nowrap
  set foldmethod=indent

  " Tab Option
  set expandtab
  set smartindent
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2

  " }}}

  " Filetype Specific {{{

  autocmd Filetype js set tabstop=2 sts=2 sw=2 et smarttab

  "  }}}

  " Terminal Specific {{{

  set mouse=a " Mouse Support In Terminal

  " }}}

" }}}

" Post Initialisation Settings {{{

if has('win32') && isdirectory('/development/git') " work machine
  cd /development/git
endif

filetype plugin indent on
syntax on

" }}}

" vim:foldmethod=marker:foldlevel=0
"
" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " .  a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

map <c-f><c-f> :call DmenuOpen("e")<cr>
map <c-f><c-v> :call DmenuOpen("vsplit")<cr>
map <c-f><c-h> :call DmenuOpen("split")<cr>
