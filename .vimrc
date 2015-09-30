 " ENVIRONMENT {
    " this must be first, because it changes other options as a side effect.
    set nocompatible
    " Vundle {
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#rc()
    " }

    " When started as "evim", evim.vim will already have done these settings.
    if v:progname =~? "evim"
        finish
    endif 

    " show line numbers
    set number
    " encoding
    set termencoding=utf-8
    set encoding=utf-8
    " remember more commands
    set history=1000
    " levels of undo command
    set undolevels=1000
    " no backup file :D
    set nobackup
    set noswapfile
    " hides the buffer instead of closing the files
    set hidden
    " ignore case when searching
    set ignorecase
    " show search matches as you type
    set incsearch
    " no sonds
    set visualbell
    set noerrorbells
    " let the cursor go anywhere
    set virtualedit=all 
    " highlight search terms
    set hlsearch
    " set syntax on
    syntax on
" }

" FORMATING / CODING {
    " highlight the syntax
    " dont wrap lines
    set nowrap
    " convert tab to spaces
    set expandtab
    " set tab to be 4 spaces
    set tabstop=4
    " allow backspace over everything in edit mode
    set backspace=indent,eol,start
    " set auto indent
    set autoindent
    " copy the previous indentation
    set copyindent
    " set 4 space for autoindenting
    set shiftwidth=4
    " set multiples of shiftwidth when indenting with '<' 
    set shiftround
    " show the matching symbols
    set showmatch
    " set the identation on
    filetype plugin indent on
    " use case sensitive when the terms are not all in smallcase
    set smartcase   
    " pastetoggle (sane indentation on pastes) 
    set pastetoggle=<F12>           
    "Sourced from vim tip: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
    autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" } /FORMATING / CODING

" VIM UI {
    " dark background as default  
    set background=dark    
    " display incomplete commands
    set showcmd
    " make tab completion for files/buffers act like bash
    set wildmenu                    
    " show a list when pressing tab and complete
    set wildmode=list:longest,full          
    " hide mouse cursor when typing
    set mousehide
    " show the cursor position all the time
    set ruler 
    " set 4 lines on the edge of the screen
    set scrolloff=4
    " Change the terminal title
    set title
    " set the colorscheme
    colorscheme molokai

    " set the default gui font 
    set guifont=Inconsolata\ Bold\ 13
    " disable the toolbar
    set guioptions-=T
    " disable the menu
    set guioptions-=m 
    " don't update the display while executing macros
    set lazyredraw
    " highlight cursorline
    set cursorline
    " format the error message when checking php syntax
    set errorformat=%m\ in\ %f\ on\ line\ %l
    " highlight long lines (soft limit: 80, hard limit: 100)
    au BufWinEnter *.php,*.phtml,*.html,*.py let w:m1=matchadd('Search', '\%<101v.\%>80v', -1)
    au BufWinEnter *.php,*.phtml,*.html,*.py let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)

    " statusline { 
        " Re-organize statusline, using example from here http://got-ravings.blogspot.com.br/2008/08/vim-pr0n-making-statuslines-that-own.html
        " tail of the filename
        if (has('statusline'))
            " tell VIM to always put a status line in, even if there is only one window 
            set laststatus=2
            set statusline=%t       
            "file encoding
            set statusline+=[%{strlen(&fenc)?&fenc:'none'}, 
            "fugitive.vim information
            set statusline+=%{fugitive#statusline()} 
            "file format
            set statusline+=%{&ff}] 
            "help file flag
            set statusline+=%h      
            "modified flag
            set statusline+=%m      
            "read only flag
            set statusline+=%r      
            "filetype
            set statusline+=%y      
            "left/right separator
            set statusline+=%=      
            "cursor column
            set statusline+=%c,     
            "cursor line/total lines
            set statusline+=%l/%L   
            "percent through file
            set statusline+=\ %P    
        endif
    "} statusline
" } VIM UI 

" FILETYPES {
    " JSON {
        " add filetype JSON
        au! BufRead,BufNewFile *.json setfiletype  
    " } JSON
    " LESS au BufNewFile,BufRead *.less set ft=css " PHP {
        " set multiple filetypes to the php files
        " autocmd Filetype php set ft=php.html
        " highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
        autocmd FileType php let php_sql_query=1
        " does exactly that. highlights html inside of php strings
        autocmd FileType php let php_htmlInStrings=1
        " no short tags
        autocmd FileType php let php_noShortTags=1
        " automagically folds functions & methods. this is getting IDE-like isn't it?
        autocmd FileType php let php_folding=1
    " } PHP
" }

" RE MAPPING {
    " activate Nerd Commenter
    map <C-c> <leader>ci
    " activate NERDTree
    map <C-n> :NERDTreeToggle<CR>
    " check php syntax
    " activate Emmet
    imap <C-z> <C-y>,
    " move through folds up and down
    " in normal mode
    nnoremap <A-j> zj
    nnoremap <A-k> zk
    " in insert mode
    inoremap <A-j> <Esc>zji
    inoremap <A-k> <Esc>zki
    " move lines up and down with control + movement keys
    nnoremap <C-j> :m .+1<CR>==
    nnoremap <C-k> :m .-2<CR>==
    inoremap <C-j> <Esc>:m .+1<CR>==gi
    inoremap <C-k> <Esc>:m .-2<CR>==gi
    vnoremap <C-j> :m '>+1<CR>gv=gv
    vnoremap <C-k> :m '<-2<CR>gv=gv
" }

" PLUGINS {
    " enable filetype plugins
    filetype plugin on

    " Neocomplcache, taken from: https://github.com/shougo/neocomplcache
        " Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
        let g:acp_enableAtStartup = 0
        " Launches neocomplcache automatically on vim startup.
        let g:neocomplcache_enable_at_startup = 1
        " Use smartcase.
        let g:neocomplcache_enable_smart_case = 1
        " Use camel case completion.
        let g:neocomplcache_enable_camel_case_completion = 1
        " Use underscore completion.
        let g:neocomplcache_enable_underbar_completion = 1
        " Sets minimum char length of syntax keyword.
        let g:neocomplcache_min_syntax_length = 3
        " buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
        let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

        " Define file-type dependent dictionaries.
        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

        " Define keyword, for minor languages
        if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        imap <C-k>     <Plug>(neocomplcache_snippets_expand)
        smap <C-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()

        " SuperTab like snippets behavior.

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
        " <TAB>: completion.
        "inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

        " AutoComplPop like behavior.
        "let g:neocomplcache_enable_auto_select = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplcache_enable_auto_select = 1
        "let g:neocomplcache_disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
        "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

        " Enable omni completion. Not required if they are already set elsewhere in .vimrc
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Snipmate {
        let g:snips_author="Rafael Dias Moreira <rafael.moreira@dafiti.com.br>"
    " } Snipmate
    
    " Omnifunction {
        " autocomplete funcs and identifiers for languages
        autocmd FileType python     set omnifunc=pythoncomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
        autocmd FileType c          set omnifunc=ccomplete#Complete
    " } Omnifunction
" }

" Bundles {
    Bundle 'scrooloose/nerdtree'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'tpope/vim-surround'
    Bundle 'kien/ctrlp.vim'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'tpope/vim-fugitive'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'Shougo/neocomplcache'
    " Snipmate dependencies
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle "honza/vim-snippets"
    " Snipmate
    Bundle 'garbas/vim-snipmate'
    " PHP
    Bundle 'spf13/PIV'
    Bundle 'scrooloose/syntastic'
    Bundle 'joonty/vdebug'
    " HTML
    Bundle 'amirh/HTML-AutoCloseTag'
    Bundle 'mattn/emmet-vim'
    Bundle 'hail2u/vim-css3-syntax'
    " CSS
    Bundle 'skammer/vim-css-color'
" }

let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
let g:vdebug_options["break_on_open"] = 0
let g:vdebug_options["server"] = '172.17.42.1'
let g:vdebug_options["path_maps"] = {"/shop/www/htdocs/bob.dev": "/home/nexus/bob", "/shop/www/htdocs/alice.dev": "/home/nexus/alice", "/shop/www/htdocs/checkout.dev": "/home/nexus/checkout", "/shop/www/htdocs/payment.dev": "/home/nexus/payment", "/shop/www/htdocs/marketplace.dev": "/home/nexus/marketplace"}
