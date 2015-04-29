set nocompatible

" begin vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'L9'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'rking/ag.vim'
Plugin 'jnwhiteh/vim-golang'
Plugin 'scrooloose/nerdtree'
Plugin 'groenewege/vim-less'
" Plugin 'davidhalter/jedi-vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'OmniSharp/omnisharp-vim.git'

" snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" iced-coffee-script
Plugin 'AndrewRadev/vim-coffee-script'

" elm
Plugin 'lambdatoast/elm.vim'

call vundle#end()            " required
filetype plugin indent on
 
" end vundle

let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim

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

" au FocusLost * :wa

set background=dark
let g:solarized_termtrans = 0
colorscheme solarized

" hide certain filetypes in file listings
let g:netrw_liststyle=3
let g:netrw_list_hide='.*\.pyc$,.*\.swp$'
let NERDTreeIgnore = ['\.pyc$']


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
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:syntastic_coffee_checkers=['coffee', 'coffeejshint']
"let g:syntastic_debug=3

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

iab flase false
iab fasle false
iab ture true

iab Fasle False
iab Ture True

if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

" force md files to be read as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.meta     " Linux/MacOSX
