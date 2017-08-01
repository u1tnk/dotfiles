filetype off
" noload defalt plugin
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif
if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    set runtimepath+=~/dotfiles/.vim,~/dotfiles/.vim/after
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    " 設定開始
    call dein#begin(s:dein_dir)

    " プラグインリストを収めた TOML ファイル
    let s:toml      = '~/dotfiles/nvim/vim_plugins.toml'
    let s:lazy_toml = '~/dotfiles/nvim/vim_lazy_plugins.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    " 設定終了
    call dein#end()
    call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

colorscheme Antares

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

"基本設定
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
set noundofile
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
filetype plugin indent on


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
noremap <Leader>tn :tabnew<CR>
noremap GT :tabprevious<CR>

"補完候補の表示
set wildmenu
"
"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

"yankとclipboardを共用
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
nnoremap <leader>.  :<C-u>edit $HOME/dotfiles/nvim/init.vim<Return>
nnoremap <leader>s  :<C-u>source $MYVIMRC<Return>

"論理行移動と表示行移動を入れ替え
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" 入力モード中はemacs的なカーソル移動 http://lambdalisue.hatenablog.com/entry/2015/12/25/000046
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>x

"カレントウィンドウのカーソル行をハイライトする
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

"filetype拡張子追加
augroup filetypedetect
autocmd! BufRead,BufNewFile *.thtml   setfiletype php
autocmd! BufRead,BufNewFile *.twig   setfiletype html
autocmd! BufRead,BufNewFile *.ftl   setfiletype ftl
autocmd! BufRead,BufNewFile *.md   setfiletype markdown
augroup END

" 保存時に行末の空白を除去する
"http://blog.sanojimaru.com/post/18643427334/vim
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
" autocmd BufWritePre * :%s/\t/  /ge

" rubyのとき?も単語に含める
autocmd FileType ruby setl iskeyword+=?

"QuickRunを実行
nnoremap <leader>x :QuickRun -into 0 <CR>
vnoremap <leader>x :QuickRun -into 0 <CR>

"先祖tagsファイルを参照
if has('path_extra')
    set tags+=tags
    set tags+=gems.tags
end

if filereadable(expand('~/rtags'))
    au FileType ruby,eruby setl tags+=~/rtags
end

nnoremap <leader>e :Vaffle<CR>
nnoremap <leader>ee :Vaffle %:h<CR>

"外部grep設定
set grepprg=grep\ -nH

" Recommended key-mappings.

" ターミナル上でコピペするとき全てのindent機能をオフにする
" 戻すのはindentexprを保存しておくのがめんどくさいので非対応
command! -nargs=* NoAllIndent setlocal noautoindent nocindent nosmartindent indentexpr=

command! -nargs=* NormalFormat setlocal fileencoding=utf8 fileformat=unix

" denite
nnoremap <silent> <C-k><C-m> :Denite menu<CR>
nnoremap <silent> <C-k><C-b> :Denite buffer<CR>
nnoremap <silent> <C-k><C-f> :Denite file_rec<CR>
nnoremap <silent> <C-k><C-r> :Denite file_mru<CR>
nnoremap <silent> <C-k><C-g> :Denite -no-empty grep<CR>
nnoremap <silent> <C-k><C-l> :Denite line<CR>
nnoremap <silent> <C-k><C-u> :Denite -resume<CR>
nnoremap <silent> <C-k><C-n> :Denite -resume -immediately -select=+1<CR>
nnoremap <silent> <C-k><C-p> :Denite -resume -immediately -select=-1<CR>
nnoremap <silent> <C-k><C-y> :Denite neoyank<CR>

" Change file_rec command.
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Change mappings.
call denite#custom#map(
        \ 'insert',
        \ '<C-j>',
        \ '<denite:move_to_next_line>',
        \ 'noremap'
        \)
call denite#custom#map(
        \ 'insert',
        \ '<C-k>',
        \ '<denite:move_to_previous_line>',
        \ 'noremap'
        \)

" Change matchers.
call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])

" Change sorters.
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])

" Add custom menus
let s:menus = {}

let s:menus.zsh = {
    \ 'description': 'zsh configs'
    \ }
let s:menus.zsh.file_candidates = [
    \ ['init.vim', '~/dotfiles/nvim/init.vim'],
    \ ['zshrc', '~/dotfiles/zshrc'],
    \ ['zshenv', '~/dotfiles/zshrc'],
    \ ]

let s:menus.vim = {
    \ 'description': 'vim configs'
    \ }
let s:menus.vim.file_candidates = [
    \ ['init.vim', '~/dotfiles/nvim/init.vim'],
    \ ['plugin', '~/dotfiles/nvim/vim_plugins.toml'],
    \ ['lazy plugin', '~/dotfiles/nvim/vim_lazy_plugins.toml'],
    \ ]

call denite#custom#var('menu', 'menus', s:menus)

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--match'])
call denite#custom#var('grep', 'separator', [])
call denite#custom#var('grep', 'default_opts', ['--nocolor', '--nogroup'])

" Define alias
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#source('file_mru', 'converters', ['converter_relative_word'])
" Change default prompt
call denite#custom#option('default', 'prompt', '>')

" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
        \ [ '.git/', '.ropeproject/', '__pycache__/',
        \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])


" from http://vim-users.jp/2011/02/hack203/
" 今のキーマッピングを表示 ex:AllMaps
command!
\   -nargs=* -complete=mapping
\   AllMaps
\   map <args> | map! <args> | lmap <args>

" vim-altr

nmap <leader>a  <Plug>(altr-forward)

" For ruby tdd
call altr#define('%.rb', 'spec/%_spec.rb')

" For rails tdd
call altr#define('app/%.rb', 'spec/%_spec.rb')
call altr#define('lib/%.rb', 'spec/lib/%_spec.rb')

" コメントアウトを切り替えるマッピング例
nmap <Leader>c <Plug>(caw:I:toggle)
vmap <Leader>c <Plug>(caw:I:toggle)

" snippet
command! -nargs=* Snippet cd $HOME/Dropbox/snippets | edit $HOME/Dropbox/snippets/

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

" コマンドウィンドウで開くかつ;と:の入れ替え、iは即時INSERTモード
nnoremap / q/i
vnoremap / q/i
nnoremap q/ /
vnoremap q/ /


 nnoremap ; :
 vnoremap ; :
 nnoremap ; :
 vnoremap ; :
" nnoremap ; q:i
" vnoremap ; q:i
" nnoremap q; :
" vnoremap q; :

augroup RSpec
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

augroup slim
  autocmd!
  autocmd BufWinEnter,BufNewFile *.slim set filetype=slim
augroup END

au BufNewFile,BufRead Guardfile setfiletype ruby
au BufNewFile,BufRead *.jbuilder setfiletype ruby

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

let g:quickrun_config['python'] = {
  \ 'command': 'python3',
  \}

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" indentの表示文字カスタマイズ
let g:indentLine_char = '|'

if has('python3')

    " deoplete
    let g:deoplete#enable_at_startup = 1

    set completeopt+=noinsert
"     <TAB>: completion.
    imap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}

    " <S-TAB>: completion back.
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

    " <C-h>, <BS>: close popup and delete backword char.
"     inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
"     inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

    inoremap <expr><C-g> deoplete#mappings#undo_completion()
    " <C-l>: redraw candidates
    inoremap <expr><C-l>       deoplete#mappings#refresh()

    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function() abort
        return deoplete#mappings#close_popup() . "\<CR>"
    endfunction

    inoremap <expr> '  pumvisible() ? deoplete#mappings#close_popup() : "'"

    let g:deoplete#keyword_patterns = {}
    let g:deoplete#keyword_patterns._ = '[a-zA-Z_]\k*\(?'
    let g:deoplete#keyword_patterns.tex = '[^\w|\s][a-zA-Z_]\w*'

    let g:deoplete#omni#input_patterns = {}
    let g:deoplete#omni#input_patterns.python = ''

    let g:deoplete#enable_refresh_always = 1
    let g:deoplete#enable_camel_case = 1
endif


" neosnippet
let g:neosnippet#snippets_directory = '~/dotfiles/.vim/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
" if has('conceal')
"   set conceallevel= concealcursor=i
" endif


" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

function! s:check_back_space()"{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}}

let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': ['ruby', 'lua', 'sh', 'vim'],
            \ 'passive_filetypes': ['html', 'python']
            \}
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
" let g:syntastic_ruby_rubocop_exec = '/Users/yuichi/.rbenv/shims/ruby /Users/yuichi/apps/dividual/synchroapp-backend/bin/bundle exec rubocop'



" http://itchyny.hatenablog.com/entry/2014/12/25/090000
nnoremap Y y$
set display=lastline
set pumheight=10
set showmatch
set matchtime=1

command! -nargs=* Spon cd $HOME/apps/gram30/spon-server | edit $HOME/apps/gram30/spon-server
command! -nargs=* Sync cd $HOME/apps/dividual/synchroapp-backend | edit $HOME/apps/dividual/synchroapp-backend
command! -nargs=* Pet cd $HOME/apps/u1tnk/petit-ballon | edit $HOME/apps/u1tnk/petit-ballon
