"ファイルタイプの判別を有効化
filetype on

"基本設定
filetype plugin indent on
syntax enable

"set系
"大文字小文字
set ignorecase
set smartcase

"行数表示
set number
"インデント
set autoindent
set shiftwidth=4
set tabstop=4
"set expandtab

"空白表示
"set list

"インクリメントサーチ
set incsearch

"バックアップを作らない
set nobackup

"backspaceキー
set backspace=eol,indent,start

"statusLIne
set statusline=%F%m%r%h%w\ (%Y\ %{&fileencoding}\ %{&ff})%=[x=%v,y=%l/%L]
set laststatus=2

""dotfiles以下にプラグインをインストール
set runtimepath+=~/dotfiles/.vim,~/dotfiles/.vim/after

"Kコマンドをmanからhelpに変更
set keywordprg=:help

"map系
"スクロール
noremap <Space>j <C-f>
noremap <Space>k <C-b>

"カーソル位置の単語をyankする
nnoremap vv vawy

"最後に変更されたテキストを選択する
nnoremap gc  `[v`]
vnoremap gc ;<C-u>normal gc<Enter>
onoremap gc ;<C-u>normal gc<Enter>

"  Insert mode中で単語単位/行単位の削除をアンドゥ可能にする
inoremap <C-u>  <C-g>u<C-u>
inoremap <C-w>  <C-g>u<C-w>

" ;でExコマンド入力( ;と:を入れ替)
nnoremap ; :
nnoremap : ;

"<space>j, <space>kで画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

"対応する括弧に移動
nnoremap [ %
nnoremap ] %

"vimrc編集関連
nnoremap <Space>.	:<C-u>edit $HOME/dotfiles/.vimrc<Return>
nnoremap <Space>s	:<C-u>source $MYVIMRC<Return>

"論理行移動と表示行移動を入れ替え
noremap j gj
noremap k gk
noremap gj j
noremap gk k

"Omni補完をtabで実行
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"yanktmp設定
noremap <silent> sy :call YanktmpYank()<CR> 
noremap <silent> sp :call YanktmpPaste_p()<CR> 
noremap <silent> sP :call YanktmpPaste_P()<CR> 
let g:yanktmp_file = '/tmp/yanktmp'

"php関連
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=1
autocmd Syntax php set fdm=syntax

"カレントウィンドウのカーソル行をハイライトする
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

"filetype拡張子追加
augroup filetypedetect
autocmd! BufRead,BufNewFile *.thtml	 setfiletype php
augroup END

"開いているファイルを実行（ファイルタイプと実行コマンドが一致する場合汎用）
function! ScriptExecute()
	let m = matchlist(getline(1), '#!\(.*\)')
	if(len(m) > 2)
		execute '!' . m[1] . ' %'
	else
		execute '!' . &ft . ' %'
	endif
endfunction
nnoremap <Space>x :call ScriptExecute()<CR>


