"dotfiles以下にプラグインをインストール
set runtimepath+=~/dotfiles/.vim,~/dotfiles/.vim/after

"pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"vundler
call vundle#rc()
Bundle 'neocomplcache'
Bundle 'neco-look'
Bundle 'surround.vim'
Bundle 'git://github.com/Shougo/unite.vim.git'
Bundle 'taglist.vim'
Bundle 'quickrun.vim'
Bundle 'ref.vim'
Bundle 'git://github.com/Shougo/vimproc.git'
Bundle 'ZenCoding.vim'
Bundle 'YankRing.vim'
Bundle 'git://github.com/Shougo/vimfiler.git'
Bundle 'git://github.com/Shougo/unite-grep.git'
Bundle 'tpope/vim-fugitive'
 

"基本設定
filetype plugin indent on
syntax enable
set nocompatible

"machit
source $VIMRUNTIME/macros/matchit.vim

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

" 常にdiffをverticalに
set diffopt=vertical
"map系
"カーソル位置の単語をyankする
nnoremap vv viwy
nnoremap <Space>p viwp

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

"カレントウィンドウのカーソル行をハイライトする
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

"filetype拡張子追加
augroup filetypedetect
autocmd! BufRead,BufNewFile *.thtml	 setfiletype php
autocmd! BufRead,BufNewFile *.twig	 setfiletype html
augroup END

" 保存時に行末の空白を除去する
" diff見るのに嫌われるため、現状削除
"autocmd BufWritePre * :%s/\s\+$//ge

"QuickRunを実行
nnoremap <Space>x :QuickRun -into 0 <CR>
vnoremap <Space>x :QuickRun -into 0 <CR>

"先祖tagsファイルを参照
if has('path_extra')
    set tags+=tags;
endif

"vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
command! -nargs=* EE VimFiler %:h 
command! -nargs=* E VimFiler 

"外部grep設定
set grepprg=grep\ -nH

" NeoComplCache設定
let g:neocomplcache_enable_at_startup = 1
" smart case
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:NeoComplCache_EnableCamelCaseCompletio = 1
" Use underbar completion.
let g:NeoComplCache_EnableUnderbarCompletion = 1
" Print caching percent in statusline.
let g:NeoComplCache_CachingPercentInStatusline = 1
" シンタックスをキャッシュするときの最小文字長を3
let g:neocomplcache_min_syntax_length = 3
" snippetsファイルのディレクトリパス
let g:neocomplcache_snippets_dir = '~/dotfiles/.vim/snippets'

" phpmanual path for vim-ref
let g:ref_phpmanual_path = $HOME. '/dotfiles/doc/php-chunked-xhtml/'
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
" <TAB>: completion.スニペット展開とバッティングしてたのでコメントアウト
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" add edit snippets command a little short
command! -nargs=* NecoEditSnippets NeoComplCacheEditSnippets

" ターミナル上でコピペするとき全てのindent機能をオフにする
" 戻すのはindentexprを保存しておくのがめんどくさいので非対応
command! -nargs=* NoAllIndent setlocal noautoindent nocindent nosmartindent indentexpr=


command! -nargs=* NormalFormat setlocal fileencoding=utf8 fileformat=unix  bomb
"unite
let g:unite_enable_start_insert=1
nnoremap <Space>ut :Unite tab<Enter>
nnoremap <Space>ub :Unite buffer<Enter>
nnoremap <Space>uf :Unite file<Enter>
nnoremap <Space>ur :Unite file_rec<Enter>

" zen-coding
let g:user_zen_settings = {
            \'indentation' : '    ',
            \}
" toggle taglist view
nnoremap <Space>tl :TlistToggle<Enter>

" http://vim-users.jp/2011/02/hack202/
" 警告しつつ、保存時にディレクトリを作成する
augroup vimrc-auto-mkdir  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " {{{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

" from http://vim-users.jp/2011/02/hack203/
" 今のキーマッピングを表示 ex:AllMaps
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>

" 出力をバッファにキャプチャする  ex:Capture AllMaps
command!
\   -nargs=+ -complete=command
\   Capture
\   call s:cmd_capture(<q-args>)

function! s:cmd_capture(q_args) "{{{
    redir => output
    silent execute a:q_args
    redir END
    let output = substitute(output, '^\n\+', '', '')

    belowright new

    silent file `=printf('[Capture: %s]', a:q_args)`
    setlocal buftype=nofile bufhidden=unload noswapfile nobuflisted
    call setline(1, split(output, '\n'))
endfunction
