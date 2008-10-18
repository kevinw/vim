filetype plugin on
let digsby='c:\dev\digsby\'
let pydir=digsby.'build\msw\python\'
let g:fuzzy_roots=[digsby.'src', digsby.'ext\src', digsby.'build\msw\wxWidgets\src', digsby.'build\msw\wxWidgets\include', pydir.'include', pydir.'Modules', pydir.'Objects', pydir.'Lib', digsby.'build\msw\sip', digsby.'build\msw\wxpy\src']
let g:fuzzy_ignore='*.pyc;*.pyo;.svn;*.suo;*.vcproj;*.o;*.obj;.git'
let g:fuzzy_match_limit=75 " default 200

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

" digsby directories
" if msw...
command! CdSrc :cd c:\dev\digsby\src
command! CdExt :cd c:\dev\digsby\ext
command! CdWxpy :cd c:\dev\digsby\build\msw\wxpy
command! CdWebKit :cd c:\dev\digsby\build\msw\webkit
command! CdWx :cd c:\dev\digsby\build\msw\wxWidgets
command! CdSip :cd c:\dev\digsby\build\msw\sip
command! CdPython :cd c:\dev\digsby\build\msw\python

" digsby website shortcuts
command! -nargs=1 Bug :call LaunchBrowser("http://mini/bugs/?act=view&id=<args>")
command! -nargs=1 Ticket :call LaunchBrowser("http://mini/cgi-bin/ticket/<args>")
command! -nargs=1 Revision :call LaunchBrowser("http://mini/cgi-bin/changeset/<args>")
map \b :Bug 
map \t :Ticket 
map \r :Revision 
map \t :FuzzyFinderTextMate<CR>

command! Todo :sp ~/Desktop/TODO.txt

" highlight SIP files like C++
au BufNewFile,BufRead *.sip set filetype=cpp

" automatically jump to the last position in a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" let VCSCommandGitExec = "c:\\program files\\git\\bin\\git.exe"

set nowrap " no wordwrap

" don't write any temporary files
set nobackup
set nowritebackup
set noswapfile

map ,j :e **/

" ,v opens this file
" ,V reloads it
map ,v :sp ~/vimfiles/.vimrc<CR><C-W>_
map <silent> ,V :source ~/vimfiles/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ,d deletes a line but leaves a blank
map ,d ddO<ESC>

" ,b goes back to previous file
map ,b :e#<CR>

" check syntax more
autocmd BufEnter * :syntax sync fromstart

" don't bother with vi compatibility
set nocompatible

if has("gui_running")
    " make the default window size a bit bigger
"    set lines=60
"    set columns=90
    colorscheme desert
    set gfn=Consolas:h10:cANSI

    set guioptions-=m "remove the menu bar
    set guioptions-=T "remove the tool bar
endif " gui-running

set showmatch   "show matching brackets
set ignorecase  "case insensitive matching
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

" wxPython main stub
iab wxmain import wx<CR><CR>def main():<CR>a = wx.PySimpleApp()<CR>f = wx.Frame(None, -1, 'Test')<CR><CR>f.Show()<CR>a.MainLoop()<CR><CR>if __name__ == '__main__':<CR>main()<ESC>6ko

iab pymain if __name__ == '__main__':<CR>main()<ESC>

ab #d #define

