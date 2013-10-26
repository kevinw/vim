set nocompatible

" begin vundle

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'airblade/vim-gitgutter'

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
set tabstop=4
set softtabstop=4
set shiftwidth=2
set backspace=indent,eol,start
set incsearch
set ruler
set wildmenu
set clipboard+=unnamed

set background=dark
let g:solarized_termtrans = 0
colorscheme solarized

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

" FuzzyFinder
nnoremap <Leader>f :FufFile **/<cr>
nnoremap <Leader>b :FufBuffer<cr>
nnoremap <Leader>t :FufTag<cr>

" Fugitive
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gw :Gbrowse<cr>


" Ack
function! Ack(args)
    let grepprg_bak=&grepprg
    set grepprg=ack\ -H\ --nocolor\ --nogroup
    execute "silent! lgrep " . a:args
    botright lopen
    let &grepprg=grepprg_bak
endfunction

command! -nargs=* -complete=file Ack call Ack(<q-args>)

" Syntastic
let g:syntastic_python_checkers=['pyflakes']

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" <Leader>a is equivalent to ":Ack [word at cursor]"
map <Leader>a :Ack <C-r><C-w>

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

