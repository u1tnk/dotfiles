set lines=40 columns=150
set guifont=Inconsolata:h18
colorscheme desert

augroup hack234
  autocmd!
    if has('mac')
      autocmd FocusGained * set transparency=10
      autocmd FocusLost * set transparency=90
  endif
augroup END
