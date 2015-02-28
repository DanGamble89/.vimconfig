" Dan Gamble
" Misc {{{
set nocompatible
set encoding=utf-8
set modelines=1
filetype off

" indent
set ai
set si

" status bar
set laststatus=2

" make yanks go to system clipboard
set clipboard=unnamed

" make Vim read files on external change (Git merge, etc.)
set autoread

set backspace=indent,eol,start
set cursorline
set expandtab
set lazyredraw
set nowrap
set number
set ruler
set showmode
set showcmd
set showmatch
set colorcolumn=80
set softtabstop=4 tabstop=4 shiftwidth=4
set wildmenu
set wrap
" }}}
" Searching {{{
set nohlsearch
set incsearch
set ignorecase
set smartcase
" }}}
" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" Vundle {{{
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Alternatively, pass a apath where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive.git'
Plugin 'https://github.com/vim-scripts/ScrollColors'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-surround'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'davidhalter/jedi-vim'
Plugin 'mjbrownie/vim-htmldjango_omnicomplete'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'cwood/vim-django'
Plugin 'scrooloose/nerdcommenter'
Plugin 'valloric/MatchTagAlways'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'airblade/vim-rooter'
Plugin 'othree/xml.vim'
Plugin 'bling/vim-airline'

" The follow are examples of different formats supported
" Keep Plugin commands between vundle#begin/end

" All of my plugins must be added before the following line
call vundle#end()
filetype plugin indent on
" }}}
" Color / Theme {{{
syntax enable
set background=dark
colorscheme gruvbox
" }}}
" Leader {{{
let mapleader=","
" }}}
" Autocmd {{{
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

" Set cursor based on different mode
:autocmd InsertEnter, InsertLeave * set cul!

au BufNewFile,BufRead *.html set filetype=htmldjango
" }}}
" CtrlP {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_follow_symlinks = 1
map <C-a> :Ack<CR>
" }}}
" Django-vim {{{
let g:django_projects = '~/Workspace' "Sets all projects under project
let g:django_activate_virtualenv = 1 "Try to activate the associated virtualenv
" }}}
" Emmet {{{
let g:user_emmet_mode = "a"
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" }}}
" Syntastic {{{
let g:syntastic_check_on_open = 1
let g:syntastic_python_flake8_post_args='--ignore=E501,E128'
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
" }}}
" Auto complete {{{
"--ENABLE PYTHON/DJANGO OMNICOMPLETE

set omnifunc=syntaxcomplete#Complete
" autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
au FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango

"--SuperTab Integration
set completeopt-=previewtj
let g:SuperTabDefaultCompletionType = ""
let g:SuperTabDefaultCompletionType = "context"
" }}}
" Custom binds {{{
nnoremap gV `[v`]

" Move to beginning/end of line
nnoremap £ ^

" Move back and forward when searching etc.
" nnoremap * d
" nnoremap # a

" Make sure the old binds don't do anything
nnoremap ^ <nop>
" nnoremap * <nop>
" nnoremap # <nop>

" Number setting based on mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Ag
nnoremap <leader>a :Ag

" }}}
" Backups {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Custom functions {{{
function! StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
" }}}

" ~/.vimrc file:
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

" add the ability to create files in Vim using `:E`
command -nargs=1 E execute('silent! !mkdir -p "$(dirname "<args>")"') <Bar> e <args>

if exists("+relativenumber")
    " Due to a problem with relative line numbers not persisting across new
    " tabs and splits, set no line numbers at all...
    set nonumber
    " ..then set relative ones.
    set relativenumber
else
    set number
endif

" Change cursor based on mode (iTerm only)
if exists('$ITERM_PROFILE')
    if exists('$TMUX')
        let &t_SI = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[0 q"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
end

" vim:foldmethod=marker:foldlevel=0
