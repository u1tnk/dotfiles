:set ignorecase
:set smartcase

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
