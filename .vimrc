set nocompatible

" begin vundle

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'https://github.com/kien/ctrlp.vim.git'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'rking/ag.vim'
Bundle 'jnwhiteh/vim-golang'
Bundle 'scrooloose/nerdtree'
Bundle 'bling/vim-airline'
Bundle 'groenewege/vim-less'
Bundle 'davidhalter/jedi-vim'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'ekalinin/Dockerfile.vim'

" snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

" iced-coffee-script
Bundle "AndrewRadev/vim-coffee-script"

filetype plugin indent on
 
" end vundle

let mapleader=","
syntax on
set noeol
set hidden
set nowrap
set nobackup
set nowritebackup
set noswapfile
set showmatch
set ignorecase
set autoindent
set smartcase
set textwidth=0
set scrolloff=5
set autowrite
set nohlsearch
set expandtab
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set incsearch
set ruler
set wildmenu
set clipboard+=unnamed

set background=dark
let g:solarized_termtrans = 0
colorscheme solarized

if has("gui_running")
    " make the default window size a bit bigger
    set columns=110
    set lines=60

    set gfn=Consolas:h13

    set guioptions-=m "remove the menu bar
    set guioptions-=T "remove the tool bar

    set guioptions-=L " never show scrollbars
    set guioptions-=R

    " highlight cursor line
    set cursorline
endif " gui-running

if has('mouse')
  set mouse=a
endif

command! W :w

" always move by virtual lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

set undodir=~/.vim/undodir
set undofile
set undolevels=100 "maximum number of changes that can be undone
set undoreload=100 "maximum number lines to save for undo on a buffer reload

" ctrl+p
let g:ctrlp_user_command = 'git ls-files %s --cached --exclude-standard --others'

" Fugitive
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gw :Gbrowse<cr>

" Ag

" <Leader>a is equivalent to ":Ag [word at cursor]"
map <Leader>a :Ag <C-r><C-w>

" Syntastic
let g:syntastic_python_checkers=['pyflakes']

" Jedi
let g:jedi#use_tabs_not_buffers = 0

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" <Leader>s replaces the word at the cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" highlight spelling errors with a bright orange curly line
if has("gui_running")
    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

" leader P copies full file path to clipboard
map <Leader>p :let @+=expand("%:p")<CR>:echo "copied" expand("%:p")<CR>

function! JSONPrettify()
    python << EOF
import vim
try:
    import simplejson
except ImportError:
    import json as simplejson
b = vim.current.buffer
b[:] = simplejson.dumps(simplejson.loads('\n'.join(b[:])), indent=4).split('\n')
EOF
endfunction

" format JSON nicely (via python's simplejson)
command! JSONPrettify :call JSONPrettify()

iab Fasle False
iab Ture True
