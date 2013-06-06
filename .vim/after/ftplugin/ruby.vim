function! s:ExecuteMake()
    silent make! -c "%" | redraw!
endfunction

compiler ruby
augroup rbsyntaxcheck
  autocmd! BufWritePost *.rb call s:ExecuteMake()
augroup END

