" pyflakes.vim
"
" thanks to matlib.vim for ideas/code on interactive linting

if exists("b:did_pyflakes_plugin")
    finish
end

let b:did_pyflakes_plugin = 1

let s:cpo_sav = &cpo
set cpo-=C

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


        let b:cleared = 0
    end
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
