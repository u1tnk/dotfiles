"PHP lint
nnoremap <Space>l :call PHPLint()<CR>

function! PHPLint()
	let result = system(&ft . ' -l ' . bufname(""))
	echo result
endfunction

autocmd BufWritePost *.php :call PHPLint()

function PHPLint()  let result = system( &ft . ' -l ' . bufname(""))

  let headPart = strpart(result, 0, 16)

  if headPart != "No syntax errors"

    echo result

  endif

endfunction
