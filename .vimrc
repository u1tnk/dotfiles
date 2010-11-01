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
set expandtab

"split時右、下に開く
set splitright
set splitbelow

"空白表示
"set list

"インクリメントサーチ
set incsearch

"バックアップを作らない
set nobackup

"swpファイルの作成先変更
set directory=~/temp/vim/swap

"backspaceキー
set backspace=eol,indent,start

"statusLIne
set statusline=%F%m%r%h%w\ (%Y\ %{&fileencoding}\ %{&ff})%=[x=%v,y=%l/%L]
set laststatus=2

""dotfiles以下にプラグインをインストール
set runtimepath+=~/dotfiles/.vim,~/dotfiles/.vim/after

"Kコマンドをmanからhelpに変更
set keywordprg=:help

"文字コード判定
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

"tab表示
set showtabline=2
set tabpagemax=20
noremap <Space>tn :tabnew<CR>
noremap GT :tabprevious<CR>

"補完候補の表示
set wildmenu

"yankとclipboardを共用（gvimのみ）
set clipboard=unnamed

"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer 

"map系
"スクロール
noremap <Space>j <C-f>
noremap <Space>k <C-b>

"カーソル位置の単語をyankする
nnoremap vv viwy

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
vnoremap ; :
vnoremap : ;

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

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
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

"QuickRunを実行
nnoremap <Space>x :QuickRun -into 0 <CR>
vnoremap <Space>x :QuickRun -into 0 <CR>

"vimball設定
let g:vimball_home = "~/dotfiles/.vim/vimball"

"先祖tagsファイルを参照
if has('path_extra')
    set tags+=tags;
endif

"外部grep設定
set grepprg=grep\ -nH

" NeoComplCache設定
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:NeoComplCache_SmartCase = 1
" Use camel case completion.
let g:NeoComplCache_EnableCamelCaseCompletion = 1
" Use underbar completion.
let g:NeoComplCache_EnableUnderbarCompletion = 1
" Set minimum syntax keyword length.
let g:NeoComplCache_MinSyntaxLength = 3
" Set manual completion length.
let g:NeoComplCache_ManualCompletionStartLength = 0
" Print caching percent in statusline.
let g:NeoComplCache_CachingPercentInStatusline = 1
