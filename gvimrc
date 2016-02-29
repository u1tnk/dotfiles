set lines=50 columns=180
set guifont=Ricty:h18
colorscheme railscasts

augroup hack234
  autocmd!
    if has('mac')
      autocmd FocusGained * set transparency=10
      autocmd FocusLost * set transparency=90
  endif
augroup END

call singleton#enable()
