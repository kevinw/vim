""
"" python specific abbreviations
""

iab <buffer> slef self
iab <buffer> sefl self
iab <buffer> printexc traceback.print_exc()

iab <buffer> wxmain import wx<CR><CR>def main():<CR>a = wx.PySimpleApp()<CR>f = wx.Frame(None, -1, 'Test')<CR><CR>f.Show()<CR>a.MainLoop()<CR><CR>if __name__ == '__main__':<CR>main()<ESC>6ko
iab <buffer> pymain if __name__ == '__main__':<CR>main()

iab <buffer> pdb import pdb; pdb.set_trace()

