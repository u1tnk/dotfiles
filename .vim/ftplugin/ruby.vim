nnoremap <Space>l :call RubyLint()<CR>

""
" RubyLint
"
function! RubyLint()
    let result = system( &ft . ' -c ' . bufname(""))
    echo result
endfunction

setlocal shiftwidth=2
setlocal tabstop=2
