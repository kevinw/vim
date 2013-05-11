set lazyredraw

" vimwiki location
let g:vimwiki_list = [{'path': '~/Dropbox/Wiki/'}]

" reload chrome's active tab with leader-r
map <Leader>r :silent !osascript -e "tell application \"Google Chrome\" to tell the active tab of its first window to reload"<CR><CR>

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

set noeol

let php_folding = 0
let php_strict_blocks = 0
let php_large_file = 800

" let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" let g:syntastic_jsl_conf = "~/.vim/bundle/syntastic/syntax_checkers/jsl.conf"
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1

" custom shortcuts use "," not "\" -- it's easier to reach!
let mapleader = ","

if has("win32") || has("win64")
    " open current file in explorer
    :map <Leader>e :silent !explorer /select,%:p<CR>
endif

set nocompatible " don't bother with vi compatibility

let g:loaded_delimitMate = 1 " disabled for now
let g:pyflakes_builtins = ['sentinel', 'Sentinel', '_', 'N_', 'Null']
let g:VCSCommandSplit = 'vertical'

command! KillPydevComments :%s/\s*#@UnresolvedImport\s*//g

" make Q format text instead of entering Ex mode
map Q gq

" for mistyping :w as :W
command! W :w

command! CdFile :cd %:h " change directories to the current file's directory

" hides file types in directory listings
let g:netrw_list_hide='^\.svn/$,^\.settings/$,.*\.pyo$,.*\.pyc,.*\.obj'

" Launches web browser with the given URL.
function! LaunchBrowser(url)
    let startcmd = has("win32") || has("win64") ? "! start " : "! "
    let endcmd = has("unix") ? "&" : ""

    " Escape characters that have special meaning in the :! command.
    " let url = substitute(a:url, '!\|#\|%', '\\&', 'g')

    silent! execute startcmd url endcmd
endfunction

" highlight SIP files like C++
au BufNewFile,BufRead *.sip set filetype=cpp
au BufNewFile,BufRead *.pde set filetype=cpp
au BufNewFile,BufRead *.tenjin set filetype=html
au BufNewFile,BufRead *.as set filetype=javascript
au BufNewFile,BufRead *.less set filetype=less
au BufRead,BufNewFile *.go set filetype=go
au BufNewFile,BufRead *.as set filetype=actionscript
au BufRead,BufNewFile *.jst set filetype=html
au BufRead,BufNewFile *.hbs set filetype=html
au BufRead,BufNewFile *.html set filetype=php " read .html as PHP
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 


set nowrap " no wordwrap

" don't write any temporary files
set nobackup
set nowritebackup
set noswapfile

" check syntax more
autocmd BufEnter * :syntax sync fromstart

if has("gui_running")
    " make the default window size a bit bigger
    set columns=110
    set lines=60

    syntax enable
    set background=dark
	"let g:solarized_menu=0
    colorscheme solarized

    "colorscheme wombat
    set gfn=Consolas:h11

    set guioptions-=m "remove the menu bar
    set guioptions-=T "remove the tool bar

    set guioptions-=L " never show scrollbars
    set guioptions-=R

    " highlight cursor line
    set cursorline
endif " gui-running

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set showmatch   "show matching brackets
set ignorecase  "case insensitive matching
set smartcase   " match case sensitive if there are uppercase letters
set textwidth=0 "don't wrap text
set scrolloff=5 "keep context while scrolling

let python_highlight_all = 1

set autowrite " automatically save files when changing buffers

set wildignore+=*.lib,*.dll,*.exe,*.o,*.obj,*.pyc,*.pyo,*.png,*.gif,*.jpg,*.jpeg,*.bmp,*.tiff " ignore filetypes for auto complete

syntax on

" set nohls " turn off search highlighting (set hls will bring it back)
set nohlsearch
set nobackup
set nowritebackup

set expandtab   " enter spaces when tab is pressed:
set textwidth=0 " do not break lines when line length increases

" use 4 spaces to represent a tab
set tabstop=4
set softtabstop=4

" Copy indent from current line when starting a new line.
set smartindent
set showmode
set autoindent

" number of space to use for auto indent
" you can use >> or << keys to indent current line or selection
" in normal mode.
set shiftwidth=4

" automatically strip trailing whitespace from Python files
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" auto indent after "def foo():<CR>"
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

set backspace=indent,eol,start " makes backspace key more powerful.
set incsearch " shows the match while typing
set ruler     " show line and column number
set wildmenu  " show some autocomplete options in status bar

" share clipboard with windows clipboard
set clipboard+=unnamed

set showmatch " highlight matching parens

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Use the ack.pl script on PATH to grep intelligently
function! Ack(args)
    let grepprg_bak=&grepprg
    set grepprg=ack\ -H\ --nocolor\ --nogroup
    execute "silent! lgrep " . a:args
    botright lopen
    let &grepprg=grepprg_bak
endfunction

function! Mdgrep(args)
    let grepprg_bak=&grepprg
    set grepprg=mdgrep
    execute "silent! lgrep " . a:args
    botright lopen
    let &grepprg=grepprg_bak
endfunction

command! -nargs=* -complete=file Ack call Ack(<q-args>)
command! -nargs=* -complete=file Mdgrep call Mdgrep(<q-args>)

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

map <C-j> :lnext<CR>
map <C-k> :lprevious<CR>

" <Leader> commands

" open current buffer in trac browser
map <Leader>to :TracBrowser<CR>

" open trac revision log for current buffer
map <Leader>tl :TracLog<CR>

map <Leader>b :Bug 

" add a missing semicolon to the end of this line
map <Leader>; <ESC>A;<ESC>

map <Leader>m :w \| :silent make \| redraw!<CR>

" Jump to any file in any subdirectory under the current
map <Leader>j :e **/

" <Leader>a is equivalent to ":Ack [word at cursor]"
map <Leader>a :Ack <C-r><C-w>

" Jump to the best file match for the word under the cursor
map <Leader>J :e **/<C-r><C-w>*<CR>

" Ack (grep) for the word under the cursor. 
:nnoremap <Leader>g :Gstatus<CR>

" <Leader>s replaces the word at the cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" swap this word with the next
" noremap <silent> <Leader>xn :s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<CR>
noremap <silent> <leader>xp "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>

" <Leader>A selects whole buffer
map <Leader>A ggVG

" highlight spelling errors with a bright orange curly line
if has("gui_running")
    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

:nnoremap <Leader>q :cn<CR>

" leader P copies full file path to clipboard
map <Leader>p :let @+=expand("%:p")<CR>:echo "copied" expand("%:p")<CR>

map <Leader>r :!racket -i -t %:p<TAB><CR>
map <Leader>w :set lbr wrap<CR>
map <Leader>W :set nolbr nowrap<CR>

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

" don't underline whitespace in between HTML <a> tags
syn match htmlLinkWhite /\s\+/ contained containedin=htmlLink 
hi default htmlLinkWhite term=NONE cterm=NONE gui=NONE 

" always move by virtual lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

if filereadable("~/.vim-passwords.vimrc")
    source ~/.vim-passwords.vimrc
endif

set undodir=~/.vim/undodir
set undofile
set undolevels=50 "maximum number of changes that can be undone
set undoreload=50 "maximum number lines to save for undo on a buffer reload

autocmd filetype scheme,racket setlocal tabstop=2
autocmd filetype scheme,racket setlocal shiftwidth=2

autocmd filetype mkd setlocal spell wrap lbr

autocmd filetype asm setlocal autoread
