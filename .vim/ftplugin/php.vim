"PHP lint
nnoremap <Space>l :call PHPLint()<CR>
"autocmd BufWritePost *.php :call PHPLint()

function! PHPLint()
	let result = system(&ft . ' -l ' . bufname(""))
	echo result
endfunction


"inoremap ar<Tab> ['']<Left><Left>
"inoremap br<Tab> <br />
