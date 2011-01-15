"ファイルタイプの判別を有効化
filetype on

"基本設定
filetype plugin indent on
syntax enable

let mapleader = ","              " キーマップリーダー

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
set noswapfile

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
"
"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

"yankとclipboardを共用（gvimのみ）
set clipboard=unnamed

"ファイル保存ダイアログの初期ディレクトリをバッファファイル位置に設定
set browsedir=buffer

"map系
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

" Ctrl-iでヘルプ
nnoremap <C-i>  :<C-u>help<Space>
" " カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>


" pathogenでftdetectなどをloadさせるために一度ファイルタイプ判定をoff
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" ファイルタイプ判定をon
filetype plugin on

" ファイルタイプ判定をon
filetype plugin on

"php関連
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
autocmd Syntax php set fdm=syntax

"カレントウィンドウのカーソル行をハイライトする
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

"filetype拡張子追加
augroup filetypedetect
autocmd! BufRead,BufNewFile *.thtml	 setfiletype php
augroup END

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

"QuickRunを実行
nnoremap <Space>x :QuickRun -into 0 <CR>
vnoremap <Space>x :QuickRun -into 0 <CR>

"先祖tagsファイルを参照
if has('path_extra')
    set tags+=tags;
endif

"外部grep設定
set grepprg=grep\ -nH

" NeoComplCache設定
let g:neocomplcache_enable_at_startup = 1
" smart case
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
" 若干重いとのことで一旦コメントアウト
" let g:NeoComplCache_EnableCamelCaseCompletion = 1
" Use underbar completion.
let g:NeoComplCache_EnableUnderbarCompletion = 1
" Print caching percent in statusline.
let g:NeoComplCache_CachingPercentInStatusline = 1

" phpmanual path for vim-ref
let g:ref_phpmanual_path = $HOME. '/dotfiles/.vim/bundle/vim-ref/doc/php-chunked-xhtml/'
" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" git-vim setting
nnoremap <Leader>gP :GitPush<Enter>

nnoremap <Space>ut :Unite tab<Enter>
nnoremap <Space>uf :Unite file<Enter>
nnoremap <Space>ur :Unite file_mru<Enter>

