function! s:ExecuteMake()
    silent make! -c "%" | redraw!
endfunction

compiler ruby
augroup rbsyntaxcheck
  autocmd! BufWritePost <buffer> call s:ExecuteMake()
augroup END
