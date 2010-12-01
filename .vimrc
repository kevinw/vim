filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

" custom shortcuts use "," not "\" -- it's easier to reach!
let mapleader = ","

" ssh into sites
command! NFS :e scp://kevinwatters_symbolsystem@ssh.phx.nearlyfreespeech.net/

if has("win32") || has("win64")
    " open current file in explorer
    :map <Leader>e :silent !explorer /select,%:p<CR>
endif

" rope options
let g:ropevim_editor_changes = 1
let g:ropevim_autoimport_modules = ["os", "shutil", "sys"]
let g:ropevim_enable_shortcuts = 0
let g:ropevim_guess_project = 1

map <Leader>rm :RopeExtractMethod!<CR>
map <Leader>rs :RopeChangeSignature!<CR>
map <Leader>rr :RopeRename!<CR>
map <Leader>rg :silent RopeGotoDefinition<CR>

" generate
map <Leader>rnv :silent RopeGenerateVariable!<CR>
map <Leader>rnf :silent RopeGenerateFunction!<CR>
map <Leader>rnc :silent RopeGenerateClass!<CR>


" lookups
map <Leader>rad :RopeShowDoc<CR>

" don't bother with vi compatibility
set nocompatible

let g:loaded_delimitMate = 1 " disabled for now

let digsby='c:\dev\digsby\'
let pydir=digsby.'build\msw\python\'
let g:fuzzy_roots=[digsby.'src', digsby.'ext\src', digsby.'build\msw\wxWidgets\src', digsby.'build\msw\wxWidgets\include', pydir.'include', pydir.'Modules', pydir.'Objects', pydir.'Lib', digsby.'build\msw\sip', digsby.'build\msw\wxpy\src']
let g:fuzzy_ignore='*.pyc;*.pyo;.svn;*.suo;*.vcproj;*.o;*.obj;.git'
let g:fuzzy_match_limit=75 " default 200
let g:fuzzy_roots = ['~/src/digsby/src']

let g:pyflakes_builtins = ['sentinel', 'Sentinel', '_', 'Null']

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

" digsby website shortcuts
command! -nargs=1 Bug :call LaunchBrowser("http://mini/bugs/?act=view&id=<args>")
command! -nargs=1 Ticket :call LaunchBrowser("http://mini/cgi-bin/ticket/<args>")
command! -nargs=1 Revision :call LaunchBrowser("http://mini/cgi-bin/changeset/<args>")

command! Todo :sp ~/Desktop/TODO.txt

" highlight SIP files like C++
au BufNewFile,BufRead *.sip set filetype=cpp
au BufNewFile,BufRead *.pde set filetype=cpp
au BufNewFile,BufRead *.tenjin set filetype=html
au BufNewFile,BufRead *.as set filetype=javascript

au BufRead,BufNewFile *.go set filetype=go
au BufNewFile,BufRead *.as set filetype=actionscript


" automatically jump to the last position in a file
" au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" let VCSCommandGitExec = "c:\\program files\\git\\bin\\git.exe"

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

    colorscheme wombat
    set gfn=Monaco:h15:a,Consolas:h10:cANSI

    set guioptions-=m "remove the menu bar
    set guioptions-=T "remove the tool bar

    set guioptions-=L " never show scrollbars
    set guioptions-=R
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
set hlsearch
set nobackup
set nowritebackup

" enter spaces when tab is pressed:
set expandtab

" do not break lines when line length increases
set textwidth=0

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

" makes backspace key more powerful.
set backspace=indent,eol,start

" shows the match while typing
set incsearch

" show line and column number
set ruler

" show some autocomplete options in status bar
set wildmenu

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

command! -nargs=* -complete=file Ack call Ack(<q-args>)

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" <Leader> commands

" open current buffer in trac browser
map <Leader>to :TracBrowser<CR>

" open trac revision log for current buffer
map <Leader>tl :TracLog<CR>

map <Leader>b :Bug 

" add a missing semicolon to the end of this line
map <Leader>; <ESC>A;<ESC>

" maximize the window
if (has("win32") || has("win64"))
    map <Leader>m :simalt ~x<CR>
endif

" <Leader>V opens this file (.vimrc)
map <Leader>v :sp ~/vimfiles/.vimrc<CR><C-W>_
map <Leader>V :source ~/.vimrc<CR>

" Jump to any file in any subdirectory under the current
map <Leader>j :e **/

" <Leader>a is equivalent to ":Ack [word at cursor]"
map <Leader>a :Ack <C-r><C-w>

" Jump to the best file match for the word under the cursor
map <Leader>J :e **/<C-r><C-w>*<CR>

" Ack (grep) for the word under the cursor. 
:nnoremap <Leader>g :Ack <C-r><C-w>

" <Leader>s replaces the word at the cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" swap this word with the next
" noremap <silent> <Leader>xn :s/\v(<\k*%#\k*>)(\_.{-})(<\k+>)/\3\2\1/<CR>
noremap <silent> <leader>xp "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o>

" swap this word with the previous
"noremap <silent> <Leader>xp :s/\v(<\k+>)(.{-})(<\k*%#\k*>)/\3\2\1/<CR>

" <Leader>A selects whole buffer
map <Leader>A ggVG

" highlight spelling errors with a bright orange curly line
if has("gui_running")
    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

:nnoremap <Leader>q :cc<CR>

" leader P copies full file path to clipboard
map <Leader>p :let @+=expand("%:p")<CR>:echo "copied" expand("%:p")<CR>

" <Leader>z opens Google's "I'm feeling lucky" result for the word at the cursor
function! Lucky()
    if has("python")
        python << EOF
from xgoogle.search import GoogleSearch
import os
term = vim.eval("expand(\"<cword>\")")
gs = GoogleSearch(term)
results = gs.get_results()
if results: os.startfile(results[0].url)
EOF
    endif
endfunction

map <Leader>z :call Lucky()<CR>

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

