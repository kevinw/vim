" don't bother with vi compatibility
set nocompatible

" custom shortcuts use "," not "\" -- it's easier to reach!
let mapleader = ","

" let plugins for specific filetypes load
filetype plugin indent on

let digsby='c:\dev\digsby\'
let pydir=digsby.'build\msw\python\'
let g:fuzzy_roots=[digsby.'src', digsby.'ext\src', digsby.'build\msw\wxWidgets\src', digsby.'build\msw\wxWidgets\include', pydir.'include', pydir.'Modules', pydir.'Objects', pydir.'Lib', digsby.'build\msw\sip', digsby.'build\msw\wxpy\src']
let g:fuzzy_ignore='*.pyc;*.pyo;.svn;*.suo;*.vcproj;*.o;*.obj;.git'
let g:fuzzy_match_limit=75 " default 200
let g:fuzzy_roots = ['~/src/digsby/src']

let g:pyflakes_builtins = ['sentinel', '_']

command KillPydevComments :%s/\s*#@UnresolvedImport\s*//g

" make Q format text instead of entering Ex mode
map Q gq

" for mistyping :w as :W
command W :w

function! SetFuzzyOptions()
    if exists("g:FuzzyFinderOptions") && exists("g:FuzzyFinderOptions.TextMate")
        let g:FuzzyFinderOptions.TextMate.matching_limit = 50
    endif
endfunction

au VimEnter * call SetFuzzyOptions()

command CdFile :cd %:h " change directories to the current file's directory

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
map <Leader>b :Bug 
map <Leader>t :Ticket 
map <Leader>r :Revision 
map <Leader>t :FuzzyFinderTextMate<CR>

command! Todo :sp ~/Desktop/TODO.txt

" highlight SIP files like C++
au BufNewFile,BufRead *.sip set filetype=cpp

" automatically jump to the last position in a file
" au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" let VCSCommandGitExec = "c:\\program files\\git\\bin\\git.exe"

set nowrap " no wordwrap

" don't write any temporary files
set nobackup
set nowritebackup
set noswapfile

map <Leader>j :e **/

" ,v opens this file
" ,V reloads it
map ,v :sp ~/vimfiles/.vimrc<CR><C-W>_
map <silent> ,V :source ~/vimfiles/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" check syntax more
autocmd BufEnter * :syntax sync fromstart

if has("gui_running")
    " make the default window size a bit bigger
"    set lines=60
"    set columns=90
    colorscheme desert
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

set wildignore+=*.o,*.obj,*.pyc,*.pyo " ignore filetypes for auto complete
map ,; <esc>A;<esc>

syntax on

set nohls " turn off search highlighting (set hls will bring it back)
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

function! Ack(args)
    let grepprg_bak=&grepprg
    set grepprg=ack\ -H\ --nocolor\ --nogroup
    execute "silent! grep " . a:args
    botright copen
    let &grepprg=grepprg_bak
endfunction

command! -nargs=* -complete=file Ack call Ack(<q-args>)

:nnoremap <Leader>g :Ack <C-r><C-w>

" <Leader>s replaces the word at the cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

