set nocompatible
filetype off
"dotfiles以下にプラグインをインストール 
set runtimepath+=~/dotfiles/.vim,~/dotfiles/.vim/after

"pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"NeoBundle
if has('vim_starting')
    call neobundle#rc(expand('~/.bundle'))
endif
NeoBundle 'tpope/vim-rails'
NeoBundle 'tsaleh/vim-align'
NeoBundle 'neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'neco-look'
NeoBundle 'surround.vim'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'taglist.vim'
NeoBundle 'quickrun.vim'
NeoBundle 'ref.vim'
NeoBundle 'Shougo/vimproc', { 'build' : {'mac' : 'make -f make_mac.mak', 'unix' : 'make -f make_unix.mak'}, }
NeoBundle 'ZenCoding.vim'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'kana/vim-altr.git'
NeoBundle 'tyru/open-browser.vim.git'
NeoBundle 'tyru/savemap.vim.git'
NeoBundle 'tyru/vice.vim.git'
NeoBundle 'h1mesuke/unite-outline.git'
NeoBundle 'chaquotay/ftl-vim-syntax.git'
NeoBundle 'kana/vim-textobj-user.git'
NeoBundle 'h1mesuke/textobj-wiw.git'
NeoBundle 'kana/vim-fakeclip.git'
NeoBundle 'tyru/caw.vim.git'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'gregsexton/gitv'
NeoBundle 'tanabe/ToggleCase-vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'koron/minimap-vim'

"基本設定
filetype plugin indent on
syntax enable

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

"ハイライト
set hlsearch

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
	
" 空白文字表示
set listchars=eol:$,tab:>- 

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
autocmd! BufRead,BufNewFile *.ftl	 setfiletype ftl
augroup END

inoremap <C-e> <Esc>
vnoremap <C-e> <Esc>
cnoremap <C-e> <C-c>

" 保存時に行末の空白を除去する
" diff見るのに嫌われるため、現状削除
"autocmd BufWritePre * :%s/\s\+$//ge

"QuickRunを実行
nnoremap <Space>x :QuickRun -into 0 <CR>
vnoremap <Space>x :QuickRun -into 0 <CR>

"先祖tagsファイルを参照
if has('path_extra')
    set tags+=tags
    set tags+=gems.tags
end

if filereadable(expand('~/rtags'))
    au FileType ruby,eruby setl tags+=~/rtags
end

"vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
command! -nargs=* E VimFilerBufferDir
command! -nargs=* EE VimFiler 

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


"command! -nargs=* NormalFormat setlocal fileencoding=utf8 fileformat=unix  bomb
command! -nargs=* NormalFormat setlocal fileencoding=utf8 fileformat=unix
"unite
let g:unite_enable_start_insert=1
nnoremap <Space>ut :Unite tab<Enter>
nnoremap <Space>ub :Unite buffer<Enter>
nnoremap <Space>uf :Unite file<Enter>
nnoremap <Space>ur :Unite file_rec<Enter>

" zen-coding
" zen-coding時のindentがtabstop,shiftwidthで変わらないので、4から変えたいときは定義
"let g:user_zen_settings = {
"            \'indentation' : '  ',
"            \}
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

"vim-textmanip
"http://vim-users.jp/2011/07/hack223/
" 選択したテキストの移動
vmap <C-j> <Plug>(Textmanip.move_selection_down)
vmap <C-k> <Plug>(Textmanip.move_selection_up)
vmap <C-h> <Plug>(Textmanip.move_selection_left)
vmap <C-l> <Plug>(Textmanip.move_selection_right)

" 行の複製
vmap <C-y> <Plug>(Textmanip.duplicate_selection_v)
nmap <C-y> <Plug>(Textmanip.duplicate_selection_n)

" vim-altr

nmap <Space>a  <Plug>(altr-forward)

" For ruby tdd
call altr#define('%.rb', 'spec/%_spec.rb')

" For rails tdd
call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')


" open-browser
"let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap <Space>ob <Plug>(openbrowser-smart-search)
vmap <Space>ob <Plug>(openbrowser-smart-search)

" rsense
" let g:rsenseHome = "$HOME/local/rsense"

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
" let g:rsenseUseOmniFunc = 1
if filereadable(expand('$HOME/local/rsense/bin/rsense'))
  let g:rsenseHome = expand('$HOME/local/rsense')
  " 暫定対処 Updateしたらcompleteで落ちるようになった…
"   let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif

autocmd FileType html setlocal includeexpr=substitute(v:fname,'^\\/','','') | setlocal path+=;/

" コメントアウトを切り替えるマッピング例
nmap <Leader>c <Plug>(caw:I:toggle)
vmap <Leader>c <Plug>(caw:I:toggle)

" snippet
command! -nargs=* Snippet cd $HOME/Dropbox/snippets | edit $HOME/Dropbox/snippets/

" for gitv
autocmd FileType git :setlocal foldlevel=99

" Center words for search
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" After insert, automatically set nopaste
autocmd InsertLeave * set nopaste

" After these command, list shown, type an item, then jump to there
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin

" toggle case.vim http://blog.kaihatsubu.com/?p=2049
nnoremap <silent> <C-c> :<C-u>call ToggleCase()<CR>

" align.vim http://vim-users.jp/2009/09/hack77/
let g:Align_xstrlen=3

" cd current directory
command! -nargs=* CD cd %:p:h
 

" 連続コピペ時にバッファを上書きしない
" http://qiita.com/items/bd97a9b963dae40b63f5
vnoremap <silent> <C-p> "0p<CR>

" コマンドウィンドウで開くかつ;と:の入れ替え
nnoremap / q/a
vnoremap / q/a

nnoremap ; q:a
vnoremap ; q:a
nnoremap q; :
vnoremap q; :
nnoremap : ;
vnoremap : ;

let g:quickrun_config = {}
let g:quickrun_config.markdown = {
      \ 'outputter/buffer/close_on_empty' : 1,
      \ 'command' : 'open',
      \ 'cmdopt'  : '-a',
      \ 'args'    : 'Marked',
      \ 'exec'    : '%c %o %a %s',
      \ }

let howm_dir = '~/Dropbox/howm'
