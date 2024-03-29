" Pre Initialisation Settings {{{
  filetype off

  if has("win32")
    set rtp+=$USERPROFILE/.vim/bundle/Vundle.vim
  else
    set rtp+=~/.vim/bundle/Vundle.vim
  endif
" }}}

" Core Settings {{{
  set helpheight=100 " full screen help
  set hidden         " don't ask to save when changing buffers (i.e. when jumping to a type definition)
  set hlsearch       " highlight search matches, turn this off temporarily with :noh
  set ignorecase     " ignore case when searching
  set smartcase      " don't ignore case if search is not all lowercase
  set incsearch      " show search matches as you type
  set nocompatible   " force not to run like vi (that's "vee-eye" people!)
  set noswapfile
  set nowrap
  set showcmd
  set showmatch      " show matching parenthesis
  set bs=2           " Backspace not working on windows
" }}}

" Editing Settings {{{
  " Global (terminal and gVim) {{{
    set relativenumber
    set number " Line numbers

    " Tab Option
    set expandtab         " turn tabs into spaces
    set smartindent
    set autoindent
    set shiftwidth=2      " number of spaces for each step of (auto)indent
    set softtabstop=2     " number of spaces tab 'counts for' when editing
    set tabstop=2         " number of spaces tab 'counts for' in the file

    set laststatus=2 " always display statusbar

  " }}}

  " Folding {{{
    set foldmethod=indent
    set foldlevel=1
    set foldcolumn=2
  " }}}

  " Filetype Specific {{{
    autocmd Filetype set tabstop=2 sts=2 sw=2 et smarttab
    autocmd Filetype markdown,text set spell wrap linebreak
    autocmd Filetype javascript,ruby set tabstop=2 sts=2 sw=2 et smarttab 
    autocmd FileType c,cpp,go,java,javascript,php,python,ruby autocmd BufWritePre <buffer> %s/\s\+$//e " Remove trailing whitespace
  "  }}}

  " Omnifuncs
  augroup omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  augroup end

  " Terminal Specific {{{
    set mouse=a " Mouse Support In Terminal
  " }}}

  " Vimgrep settings {{{
    set wildignore=*.o,*.obj,*/node_modules/*,tags
  " }}}
" }}}

" Terminal Settings (see termcap_options) {{{
  set ttyfast
  set lazyredraw
  set t_ut=
" }}}

" Custom Keybindings {{{
  " For local replace (http://stackoverflow.com/questions/597687/changing-variable-names-in-vim)
  nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

  " For global replace
  nnoremap gR gD:%s/<C-R>///gc<left><left><left>

  " QuickFix List Navigation
  nnoremap [Q :cfirst<CR>
  nnoremap ]Q :clast<CR>
  nnoremap ]q :cnext<CR>
  nnoremap [q :cprevious<CR>

  " Location List Navigation
  nnoremap [L :lfirst<CR>
  nnoremap ]L :llast<CR>
  nnoremap ]l :lnext<CR>
  nnoremap [l :lprevious<CR>

  " For vimgrep
  nnoremap <leader>gw :vimgrep /<C-R><C-W>/gj **<CR>:botright cwindow<CR>
  nnoremap <leader>gW :vimgrep /<C-R><C-A>/gj **<CR>:botright cwindow<CR>

  " Enhanced editing facilities
  nnoremap ds% %x``x          " Remove surrounding {[( objects
  nnoremap ds" di"hPl2x       " Remove surrounding double quote

  " Run ctags on save
  " autocmd BufWritePost * call system("ctags -R")
" }}}

" Plugins {{{
  " Vundle Initialisation {{{
    " Vundle specific settings NOTE: Vundle must be installed in the ~/[.vim|vimfiles]/bundle folder
    call vundle#begin()
    Plugin 'google/vim-searchindex'
    Plugin 'tpope/vim-commentary' " Comment out code 
    Plugin 'gmarik/Vundle.vim'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'morhetz/gruvbox'
    Plugin 'kien/ctrlp.vim' " Fuzzy file buffer searching
    Plugin 'jelera/vim-javascript-syntax'
    Plugin 'vim-scripts/JavaScript-Indent'
    Plugin 'rmerry/jscomplete-vim'
    Plugin 'godlygeek/tabular' " Provide tabularisation functionality through (:tabularize)
    " Tern (make sure you 'npm install tern' in the term_for_vim folder
    " This provides JavaScript omni-completion
    " Plugin 'marijnh/tern_for_vim'
    Plugin 'jpalardy/vim-slime'
    " Tools to make Vim superb for developing with Node.js.
    " It's the Node equivalent of Rails.vim (vimscript #1567) and Rake.vim (vimscript #3669).
    Plugin 'moll/vim-node'
    " Integrates with external 3rd party syntax checkers and displays errors on
    " Remember to do a 'npm install jshint -g' to get JavaScript linting working save
    Plugin 'scrooloose/syntastic'
    Plugin 'TeTrIs.vim'
    " Plugin 'Shougo/neocomplete.vim'
    Plugin 'tpope/vim-fugitive' " git integration
    Plugin 'tpope/vim-cucumber'
    Plugin 'bling/vim-airline'
    " Plugin 'ngmy/vim-rubocop' 
    Plugin 'vim-ruby/vim-ruby'
    "Plugin 'airblade/vim-rooter' 
    "Plugin 'walm/jshint.vim' " JSHint should be intalled on the system, i.e., 'sudo npm install -g
    "Plugin 'scrooloose/nerdtree' " File browser
    call vundle#end()
  " }}}

  " Configuration {{{
    " Airline {{{
      "let g:airline#extensions#tabline#enabled = 1
      let g:airline_left_sep = '▶'
      let g:airline_right_sep = '◀'
    " }}}

    " CtrlP {{{
      "  'c' - the directory of the current file.
      "  'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr
      "  'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
      "  0 or '' (empty string) - disable this feature.
      let g:ctrlp_working_path_mode = 'ra'
      let g:ctrlp_map = '<c-p>'
      let g:ctrlp_cmd = 'CtrlP'
      let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:40,results:40'
      let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
      let g:ctrlp_show_hidden = 1

      nnoremap <leader><c-p> :CtrlPMRUFiles<CR>
    " }}}

    " Neo Complete {{{
      " if exists('g:plugs["neocomplete"]')
        let g:neocomplete#enable_at_startup=1
        let g:neocomplete#enable_auto_close_preview=1
      " endif

      if exists('g:plugs["tern_for_vim"]')
        echo "it exists"
        let g:tern_show_argument_hints = 'on_hold'
        let g:tern_show_signature_in_pum = 1

        autocmd FileType javascript setlocal omnifunc=tern#Complete
      endif
    " }}}

    " netrw {{{
      " Make Ctrl-^ return to last edited file and not netrw
      let g:netrw_altfile=1
    " }}}

    " ShellCheck {{{
      autocmd Filetype sh set makeprg=shellcheck\ -f\ gcc\ % tabstop=4 sts=4 sw=4 et smarttab
      "autocmd BufWritePost * :silent make | redraw!
    " }}}

    " Slime {{{
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
      let g:syntastic_loc_list_height = 3
      let g:syntastic_check_on_open = 1
      let g:syntastic_check_on_wq = 0
      let g:syntastic_javascript_checkers = ['eslint']
      let g:syntastic_ruby_checkers = ['rubocop']

      augroup linter_setup

        autocmd FileType javascript call SetJSLinter()
        autocmd FileType ruby call SetRubyOptions()

        function! SetJSLinter()
          "the api folder is a work specific environment configuration
          if filereadable(globpath('.', '.eslintrc*')) || filereadable(globpath('./api/', '.eslintrc*'))
            let g:syntastic_javascript_checkers = ['eslint']
          else
            "autocmd FileType javascript let g:syntastic_javascript_checkers = ['jshint', 'jscs']
            "if !filereadable(".jscsrc")
            "  autocmd FileType javascript let g:syntastic_javascript_jscs_args = "--config ~/dev/git/whitebeam/wb-gulp-tasks/config/.jscsrc"
            "endif
          endif
        endfunction

        function! SetRubyOptions()
          let g:syntastic_javascript_checkers = ['rubocop']

          if filereadable(globpath('.', '.rubocop.yaml'))
            let g:syntastic_ruby_rubocop_args = "--config .rubocop.yaml"
          endif
        endfunction

      augroup END

      augroup work_environment_setup

        autocmd FileType javascript call SetPikselFoundationEnvironment()

        function! SetPikselFoundationEnvironment()
          set colorcolumn=120
        endfunction

      augroup END

      autocmd BufReadPre *.js let b:javascript_lib_use_jasmine = 1
      autocmd BufReadPre *.js let b:javascript_lib_use_react = 0
      autocmd BufReadPre *.js set suffixesadd+=.js
    " }}}

    " Tern {{{
      let g:tern_map_keys=1
      let g:tern_show_argument_hints='on_hold'
      let g:tern_request_timeout=5
    " }}}
  " }}}
" }}}

" Chrome Settings {{{
  " gVim Settings
  set guioptions-=m "menu bar
  set guioptions-=T "toolbar
  set guioptions-=r "right-hand scroll bar
  set guioptions-=L "left-hand scroll bar

  " Colours
  silent! colorscheme gruvbox
  set t_Co=256
  set background=dark
" }}}

" Post Initialisation Settings {{{
  set runtimepath+=/home/rmerry/.vim/plugin/mpc
  filetype plugin indent on
  syntax on
" }}}
