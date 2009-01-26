""
"" python specific abbreviations
""

iab <buffer> slef self
iab <buffer> sefl self
iab <buffer> printexc traceback.print_exc()

imap <buffer> __i __init__
imap <buffer> __c __cmp__
imap <buffer> __en __enter__
imap <buffer> __ex __exit__
imap <buffer> __n __name__
imap <buffer> __m __main__
imap <buffer> __f __file__
imap <buffer> __r __repr__
imap <buffer> __s __str__
imap <buffer> __u __unicode__
imap <buffer> __h __hash__
imap <buffer> __i __init__

iab <buffer> wxmain import wx<CR><CR>def main():<CR>a = wx.PySimpleApp()<CR>f = wx.Frame(None, -1, 'Test')<CR><CR>f.Show()<CR>a.MainLoop()<CR><CR>if __name__ == '__main__':<CR>main()<ESC>6ko
iab <buffer> pymain if __name__ == '__main__':<CR>main()

iab <buffer> pdb import pdb; pdb.set_trace()

