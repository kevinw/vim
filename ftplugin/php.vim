au! BufWriteCmd  *.php    call PHPsynCHK()

if !exists('*PHPsynCHK')
  function! PHPsynCHK()
    ccl
    let winnum = winnr() " get current window number
    silent execute "%!php -l -f /dev/stdin | sed 's/\\/dev\\/stdin/".bufname("%")."/g' >.vimerr; cat"
    silent cf .vimerr
    cw " open the error window if it contains error
    " return to the window with cursor set on the line of the first error (if any)
    execute winnum . "wincmd w"
    silent undo
    silent cf
    if 1 == len(getqflist())
      w
    endif
  endfunction
endif


set errorformat=%m\ in\ %f\ on\ line\ %l

