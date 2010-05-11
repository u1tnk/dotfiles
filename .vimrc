"set系
"大文字小文字
:set ignorecase
:set smartcase

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
noremap ; :
noremap : ;

"<space>j, <space>kで画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

"対応する括弧に移動
nnoremap [ %
nnoremap ] %

"vimrc編集関連
nnoremap <Space>.	:<C-u>edit $HOME/dotfiles/.vimrc<Return>
nnoremap <Space>s	:<C-u>source $MYVIMRC<Return>

"php関連
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=1
au Syntax php set fdm=syntax

"ファイルタイプの判別を有効化
filetype on

"基本設定
filetype plugin indent on
syntax enable

