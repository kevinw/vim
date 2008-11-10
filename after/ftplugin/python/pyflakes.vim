" pyflakes.vim - A script to highlight Python code with warnings from Pyflakes.
"
" Place in your after/ftplugin directory.
"
" Maintainer: Kevin Watters <kevin.watters@gmail.com>
" Version: 0.1
"
" Thanks to matlib.vim for ideas/code on interactive linting.
"

if exists("b:did_pyflakes_plugin")
    finish
end

let b:did_pyflakes_plugin = 1

let s:cpo_sav = &cpo
set cpo-=C

if !exists("b:did_python_init")
    python << EOF
import vim
import os.path
import sys
from pyflakes import checker, ast
from operator import attrgetter

def check(filename):
    try:
        contents = open(filename, 'U').read()
    except IOError:
        return

    try:
        tree = ast.parse(contents, filename)
    except (SyntaxError, IndentationError):
        value = sys.exc_info()[1]
        try:
            lineno, offset, line = value[1][1:]
        except IndexError:
            print >> sys.stderr, 'could not compile %r' % (filename,)
            return 1
        if line.endswith("\n"):
            line = line[:-1]
        print >> sys.stderr, '%s:%d: could not compile' % (filename, lineno)
        print >> sys.stderr, line
        print >> sys.stderr, " " * (offset-2), "^"
        return []
    else:
        w = checker.Checker(tree, filename)
        w.messages.sort(key = attrgetter('lineno'))
        return w.messages


def squo(s):
    return s.replace('"', r'\"')
EOF
    let b:did_python_init = 1
endif

" return '%s:%s: %s' % (self.filename, self.lineno, self.message % self.message_args)

au BufWinLeave <buffer> call s:ClearPyflakes()
au BufEnter <buffer> call s:RunPyflakes()
au InsertLeave <buffer> call s:RunPyflakes()

au CursorHold <buffer> call s:RunPyflakes()
au CursorHold <buffer> call s:GetPyflakesMessage()
au CursorHoldI <buffer> call s:RunPyflakes()

if !exists("*s:RunPyflakes")
    function s:RunPyflakes()
        highlight PyFlakes term=underline gui=undercurl guisp=Orange

        if exists("b:cleared")
            if b:cleared == 0
                silent call s:ClearPyflakes()
                let b:cleared = 1
            endif
        else
            let b:cleared = 1
        endif
        
        let b:matched = []
        python << EOF
for w in check(vim.current.buffer.name):
    vim.command('let s:matchDict = {}')
    vim.command("let s:matchDict['lineNum'] = " + str(w.lineno))
    vim.command("let s:matchDict['message'] = \"%s\"" % squo(w.message % w.message_args))


    if w.col is None:
        # without column information, just highlight the whole line
        # (minus the newline)
        vim.command(r"let s:mID = matchadd('PyFlakes', '\%" + str(w.lineno) + r"l\n\@!')")
    else:
        # with a column number, highlight the first keyword there
        vim.command(r"let s:mID = matchadd('PyFlakes', '^\%" + str(w.lineno) + r"l\_.\{-}\zs\k\+\k\@!\%>" + str(w.col) + r"c')")

    vim.command("call add(b:matched, s:matchDict)")
EOF
        let b:cleared = 0
    endfunction
end

if !exists("*s:GetPyflakesMessage")
    function s:GetPyflakesMessage()
        let s:cursorPos = getpos(".")
        for s:pyflakesMatch in b:matched
        " If we're on a line with a match then show the message
            if s:pyflakesMatch['lineNum'] == s:cursorPos[1]
                " The two lines commented below cause a message to be shown
                " only when the cursor is actually over the offending item in
                " the line.
                "\ && s:cursorPos[2] > s:pyflakesMatch['colStart'] 
                "\ && s:cursorPos[2] < s:pyflakesMatch['colEnd']
                echo s:pyflakesMatch['message']
            endif
        endfor
    endfunction
endif

if !exists('*s:ClearPyflakes')
    function s:ClearPyflakes()
        let s:matches = getmatches()
        for s:matchId in s:matches
            if s:matchId['group'] == 'PyFlakes'
                call matchdelete(s:matchId['id'])
            end
        endfor
        let b:matched = []
        let b:cleared = 1
    endfunction
endif

let &cpo = s:cpo_sav
