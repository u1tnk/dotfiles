"PHP lint
nnoremap <Space>l :call PHPLint()<CR>

function! PHPLint()
	let result = system(&ft . ' -l ' . bufname(""))
	echo result
endfunction
