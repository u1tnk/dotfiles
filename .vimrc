" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

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
NeoBundle 'tsaleh/vim-align'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'surround.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'taglist.vim'
NeoBundle 'quickrun.vim'
NeoBundle 'ref.vim'
NeoBundle 'Shougo/vimproc', { 'build' : {'mac' : 'make -f make_mac.mak', 'unix' : 'make -f make_unix.mak'}, }
NeoBundle 'ZenCoding.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kana/vim-altr'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'h1mesuke/textobj-wiw'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'tyru/caw.vim'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'tanabe/ToggleCase-vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tyru/coolgrep.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kevinw/pyflakes-vim'

NeoBundleCheck

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
set list

"インクリメントサーチ
set incsearch

"ハイライト
set hlsearch

"バックアップ/swapを作らない
set nobackup
set nowritebackup
set noswapfile

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

"backspaceキー
set backspace=eol,indent,start

"statusLIne
set statusline=%F%m%r%h%w\ (%Y\ %{&fileencoding}\ %{&ff})%=[x=%v,y=%l/%L]
set laststatus=2

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

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

" matchpairに<>を追加
set matchpairs& matchpairs+=<:>

" '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set shiftround

" バッファを閉じる代わりに隠す（Undo履歴を残すため）
set hidden

" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen

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
nnoremap <Space>.  :<C-u>edit $HOME/dotfiles/.vimrc<Return>
nnoremap <Space>s  :<C-u>source $MYVIMRC<Return>

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
autocmd! BufRead,BufNewFile *.thtml   setfiletype php
autocmd! BufRead,BufNewFile *.twig   setfiletype html
autocmd! BufRead,BufNewFile *.ftl   setfiletype ftl
augroup END

inoremap <C-e> <Esc>
vnoremap <C-e> <Esc>
cnoremap <C-e> <C-c>

echo $filetype
" 保存時に行末の空白を除去する
"http://blog.sanojimaru.com/post/18643427334/vim
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
" autocmd BufWritePre * :%s/\t/  /ge

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

" Recommended key-mappings.

" ターミナル上でコピペするとき全てのindent機能をオフにする
" 戻すのはindentexprを保存しておくのがめんどくさいので非対応
command! -nargs=* NoAllIndent setlocal noautoindent nocindent nosmartindent indentexpr=


"command! -nargs=* NormalFormat setlocal fileencoding=utf8 fileformat=unix  bomb
command! -nargs=* NormalFormat setlocal fileencoding=utf8 fileformat=unix
"unite
let g:unite_enable_start_insert=1
nnoremap <silent> <Space>ut :Unite tab<Enter>
nnoremap <silent> <Space>ub :Unite buffer<Enter>
nnoremap <silent> <Space>uf :Unite file<Enter>
nnoremap <silent> <Space>uo :<C-u>Unite -vertical -no-quit outline<CR>
nnoremap <silent> <Space>ur :<C-u>Unite -start-insert file_rec<CR>
nnoremap <silent> <Space>ug :Unite grep -buffer-name=grep <Enter>
" UniteWithBufferDir だと、パス入力済みで検索しづらいので、Uniteにパス渡すようにした
" nnoremap <silent> <Space>uc :UniteWithBufferDir -start-insert  -buffer-name=files file_rec<CR>
nnoremap <silent> <Space>uc :Unite file_rec:<C-r>=expand('%:p:h:gs?[ :]?\\\0?')<CR><CR>

let s:file_rec_ignore_pattern = (unite#sources#rec#define()[0]['ignore_pattern']) . '\|.*\.\(png\|jpg\|gif\)'
call unite#custom#source('file_rec', 'ignore_pattern', s:file_rec_ignore_pattern)
call unite#custom#source('grep', 'ignore_pattern', s:file_rec_ignore_pattern)

let g:unite_source_file_rec_max_cache_files = 9000

let g:unite_winwidth = 40

" マクロ実行を手早く
nnoremap <silent> <c-Q> @qq

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

" let g:rsenseUseOmniFunc = 1
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
nnoremap / q/
vnoremap / q/
nnoremap q/ /
vnoremap q/ /

nnoremap ; q:
vnoremap ; q:
nnoremap q; :
vnoremap q; :

augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

au BufNewFile,BufRead Guardfile setfiletype ruby

let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
let g:quickrun_config.markdown = {
      \ 'outputter/buffer/close_on_empty' : 1,
      \ 'command' : 'open',
      \ 'cmdopt'  : '-a',
      \ 'args'    : 'Marked',
      \ 'exec'    : '%c %o %a %s',
      \ }

let g:quickrun_config['ruby.rspec'] = {
  \ 'type': 'rspec',
  \ 'command': 'rspec',
  \ 'cmdopt': "--format progress -I . -l %{line('.')}",
  \ 'exec': 'bundle exec spring rspec %o %s',
  \ 'filetype': 'rspec-result'
  \}

" ２系がメインなので…
" let g:quickrun_config['python'] = {
"   \ 'command': 'python3',
"   \}

" http://qiita.com/items/c8962f9325a5433dc50d
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup -i'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" indentの表示文字カスタマイズ
let g:indentLine_char = '|'

" neocomplete
"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 3


" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <silent><expr><CR> pumvisible() ? neocomplete#close_popup(). "\<CR>" : "\<CR>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

inoremap <expr><Space> pumvisible() ? neocomplete#close_popup(). "\<Space>" : "\<Space>"

" For cursor moving in insert mode(Not recommended)
inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"

let g:neocomplete#enable_auto_select = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" http://kazy.hatenablog.com/entry/2013/07/18/131118
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

" neosnippet
let g:neosnippet#snippets_directory = '~/dotfiles/.vim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" コマンドラインウィンドウでtab動作がおかしいのを指摘したら以下の設定指示された。わからんが動く。
" https://github.com/Shougo/neocomplete.vim/issues/74
autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
autocmd MyAutoCmd CmdwinLeave * let g:neocomplete_enable_auto_select = 0

function! s:init_cmdwin()
  NeoBundleSource vim-altercmd

  let g:neocomplete_enable_auto_select = 0
  let b:neocomplete_sources_list = ['vim_complete']

  nnoremap <buffer><silent> q :<C-u>quit<CR>
  nnoremap <buffer><silent> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> neocomplete#close_popup()."\<CR>"
  inoremap <buffer><expr><C-h> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"
  inoremap <buffer><expr><BS> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplete#cancel_popup()."\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB>  pumvisible() ?
        \ "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>\<C-p>"

  startinsert!
endfunction"}}}

function! s:check_back_space()"{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}}

let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['ruby', 'lua', 'sh', 'vim'],
            \ 'passive_filetypes': ['html', 'python']
            \}

let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200
