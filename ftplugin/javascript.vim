set makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ c:\\Users\\Kevin\\bin\\jsl.conf\ -process\ %
set errorformat=%f(%l):\ %m
"make F10 call make for linting etc.
inoremap <silent> <F10> <C-O>:make<CR>
map <F10> :silent make<CR>
