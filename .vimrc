
set encoding=utf-8
scriptencoding utf-8

" vim-tiny か vim-small の場合は初期化しない
if 0 | endif

" dein設定 {{{

if has('vim_starting')
  if &compatible
    " vi との互換性をもたない
    set nocompatible
  endif
endif

" <Leader> をスペースにする。<Space>ではうまく動かない {{{
let g:mapleader=' '
" }}}

" deinのパス設定 {{{
let s:dein_dir       = expand('~/.vim/dein/')
let s:dein_repo_name = 'Shougo/dein.vim'
let s:dein_repo_dir  = s:dein_dir . 'repos/github.com/' . s:dein_repo_name
let s:dein_git_url   = 'https://github.com/' . s:dein_repo_name
let s:toml_file      = expand('~/.dein.toml')
let s:lazy_toml_file = expand('~/.dein_lazy.toml')
" }}}

" deinのインストール {{{
if !isdirectory(s:dein_repo_dir)
  echo "Installing dein...\n"
  silent execute '!mkdir -p ' . s:dein_repo_dir
  silent execute '!git clone ' . s:dein_git_url . ' ' . s:dein_repo_dir
endif
" }}}

" 設定の読み込み {{{
let &runtimepath .= ',' . s:dein_repo_dir
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file, s:lazy_toml_file])

    " TOMLファイルの読み込み
    if filereadable(s:toml_file)
        call dein#load_toml(s:toml_file, {'lazy' : 0})
    endif
    if filereadable(s:lazy_toml_file)
        call dein#load_toml(s:lazy_toml_file, {'lazy' : 1})
    endif

    call dein#end()

    call dein#save_state()
endif
" }}}

" vimproc のみ先にインストール {{{
if dein#check_install(['vimproc'])
    call dein#install(['vimproc'])
endif
" }}}

" vimproc 以外をインストール {{{
if dein#check_install()
    call dein#install()
endif
" }}}

" }}}

" Basic Settings {{{

" lightline {{{
" http://itchyny.hatenablog.com/entry/20130828/1377653592
" http://itchyny.hatenablog.com/entry/20130917/1379369171

set laststatus=2
set noshowmode
if !has('gui_running')
    set t_Co=256
endif

" mode: モード表示(ex. NORMAL )
" paste: Paste表示(ex. PASTE)
" readonly: 読み込み専用表示(ex. RO)
" filename: ファイル名表示(ex. .vimrc)
" modified: 変更状態表示(ex. +)
" fugitive: Gitリポジトリ表示
" fileformat: 改行コード(ex. unix)
" filetype: ファイル形式(ex. vim)
" fileencoding: 文字コード(ex. utf-8)
"
" 'active': 左側表示を[モード+Paste][Gitリポジトリ+ファイル名]にする
"
" "\ue0a0" : Git
" "\ue0a1" : LN
" "\ue0a2" : 鍵マーク
" "\ue0b0" : 右向き三角（塗りつぶし）
" "\ue0b2" : 左向き三角（塗りつぶし）
" "\ue0b1" : 右向き三角（塗りつぶしなし）
" "\ue0b3" : 左向き三角（塗りつぶしなし）
let g:lightline = {
\ 'colorscheme': 'jellybeans',
\ 'active': {
\   'left' : [ ['mode', 'paste'], ['fugitive', 'filename', 'qfstatusline', 'anzu'] ],
\   'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'] ],
\ },
\ 'component': {
\   'lineinfo': "%3l:%-2v",
\ },
\ 'component_expand': {
\   'qfstatusline': 'qfstatusline#Update',
\ },
\ 'component_type': {
\   'qfstatusline': 'error',
\ },
\ 'component_function': {
\   'mode'         : 'LightLineMode',
\   'readonly'     : 'LightLineReadonly',
\   'filename'     : 'LightLineFilename',
\   'modified'     : 'LightLineModified',
\   'fugitive'     : 'LightLineFugitive',
\   'fileformat'   : 'LightLineFileformat',
\   'fileencoding' : 'LightLineFileencoding',
\   'filetype'     : 'LightLineFiletype',
\   'anzu'         : 'LightLineAnzu',
\ },
\ 'separator': { 'left': "", 'right': "" },
\ 'subseparator': { 'left': "|", 'right': "|" },
\ }

" モード表示(表示幅が狭ければ表示しない)
function! LightLineMode()
    return &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" 読み込み専用(読み込み専用であれば"x")
function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "ReadOnly" : ''
endfunction

" ファイル名(前後に読み込み専用と変更状態を挿入する)
function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" 変更状態(変更されていれば"+"、変更できない場合は"-")
function! LightLineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

" Gitリポジトリ(fugitiveがあればリポジトリのHEAD名を表示)
function! LightLineFugitive()
    try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
            let _ = fugitive#head()
            return strlen(_) ? "Git: " . _ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineAnzu()
    return anzu#search_status()
endfunction
" }}}

" ファイル別 plugin (~/.vim/ftplugin/拡張子.vim) {{{
filetype plugin indent on 
" }}}

" Help {{{
set helplang=ja

" Unite Help
nnoremap <C-i> :<C-u>Unite help<CR>
nnoremap <C-i><C-i> :<C-u>UniteWithCursorWord help<CR>

" 'K' でヘルプを開く
set keywordprg=:help

" タブでヘルプを開く
nnoremap <Leader>t :<C-u>tab help<Space>
nnoremap <Leader>v :<C-u>vertical belowright help<Space>

augroup HelpSettings
    autocmd!

    " ヘルプをqで閉じる
    autocmd FileType help nnoremap <buffer>q <C-w>c
    " ヘルプを別タブで表示する
    autocmd FileType help nnoremap <silent><buffer>tm :<C-u>call <SID>MoveToNewTab()<CR>

    function! s:MoveToNewTab()
        tab split
        tabprevious

        if winnr('$') > 1
            close
        elseif bufnr('$') > 1
            buffer #
        endif

        tabnext
    endfunction
augroup END
" }}}

" 文字コード {{{
set fileformats=unix,dos,mac
set langmenu=japanese

" 以下のファイルの時は文字コードをutf-8に設定
set fileencoding=utf-8
set fileencodings=utf-8

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932
"}}}

" インデント {{{
set autoindent                  " 自動でインデント
set smartindent                 " インデント調整あり・コメント維持
set shiftwidth=4                " インデント１つ分の空白文字の数
set tabstop=4                   " tab 文字を表示するときに使用する空白文字の数
set softtabstop=0               " 編集で tab 文字の幅として使用する空白文字の数（0で無効にする）
set expandtab                   " 挿入モード時にtab文字を使用しないで空白文字を使用する
let g:vim_indent_cont = 0

" HTML
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
"}}}

" 削除 {{{
set backspace=indent,eol,start  " BS でindent,改行,挿入開始前を削除
set smarttab                    " BS でインデント幅を削除
"}}}

" 検索 {{{
set hlsearch                    " 検索文字列を色付け
set ignorecase                  " 大文字小文字を判別しない
set smartcase                   " でも大文字小文字が混ざってい入力されたら区別する
set incsearch                   " インクリメンタルサーチ
set wrapscan                    " 検索が終わったら最初から検索しなおしする
set gdefault                    " 置換で g オプションをデフォルトにする
" enter で検索ハイライトをクリア
nnoremap <silent> <CR> :nohlsearch<CR><CR>
" visual 選択中に * で選択文字列を検索
vnoremap * y/\V<c-r>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>gV
"}}}

" バックアップ {{{
"set backup                      " ファイル上書きでバックアップファイルを作成
"set backupdir=/vim_back
"set directory=/vim_back
set nobackup
set noswapfile
"}}}

" 表示 {{{
set background=dark             " 背景の明るさ。light or dark
set ruler                       " 左下に行列位置を表示
set showcmd                     " 入力中のコマンドを右下に表示
set showmatch                   " カッコの入力で対応するカッコを一瞬強調
set matchtime=1
set splitright                  " vsplit で新規ウィンドウは右側に
set title                       " ウィンドウタイトルを書き換える
set number                      " 行番号を表示する
set display=lastline
set pumheight=10                " 補完候補の表示枠の大きさ
set cursorline                  " カーソル行を強調表示

" http://vim-users.jp/2009/07/hack40/
set list
set listchars=tab:>.,trail:_,nbsp:%,extends:>,precedes:<

if has('syntax')
    " 全角スペースの表示
    function! ZenkakuSpace()
        highlight ZenkakuSpace term=underline ctermbg=lightblue gui=underline guibg=darkblue
    endfunction
    call ZenkakuSpace()

    augroup ZenkakuSpace
        autocmd!
        autocmd VimEnter,ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufWinEnter * let w:m1 = matchadd('ZenkakuSpace', '　')
    augroup END
endif

" if !has('gui_running')
"     set t_Co=256
" endif
" set ttymouse=xterm2
if has('mac')
    let g:hybrid_use_iTerm_colors = 1
endif

syntax on
colorscheme hybrid
"}}}

" 補完 {{{
set wildmenu                    " コマンド入力をタブで補完
set wildchar=<Tab>              " コマンド補完を開始するキー
set wildmode=list:longest,full  " 補完動作（リスト表示で最長一致、その後選択）
set history=1000                " コマンドの履歴数

" <c-space> で omni 補完
" inoremap <C-Space> <C-x><C-o>
"}}}

" 入力 {{{
" insert mode での移動
inoremap <C-e> <END>
inoremap <C-a> <HOME>

" F2で前のバッファ
map <F2> <ESC>:bp<CR>
" F3で次のバッファ
map <F3> <ESC>:bn<CR>
noremap <Leader>p <ESC>:bp<CR>
noremap <Leader>n <ESC>:bn<CR>
noremap <Leader>d <ESC>:bd<CR>

" 矩形選択時にテキストがないところでも選択可能にする
set virtualedit+=block

" normal mode 時 ; を : にする
" nnoremap ; :

" insert mode 時 <C-w> で保存
inoremap <C-w> <Esc>:<C-u>w<Enter>a

" insert mode 時 C-j でノーマルモードへ
inoremap <C-j> <ESC>

" ビジュアルモード時に連続でインデントする
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" ウィンドウ分割
nnoremap <C-w>- :split<CR>
nnoremap <C-w><Bar> :vsplit<CR>

" ウィンドウの移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 'Y' の動作を変更
nnoremap Y y$

" 数字のインクリメント・デクリメント
nnoremap + <C-a>
nnoremap - <C-x>

" キー入力の反応
" <C-w>h を入力するとした場合
" <C-w> <= ([timeoutlen]msec) => h
" ttimeoutlen: キーコード待ち（エスケープシーケンスを正しく解釈するため）
" カーソルの左キーは ^[OD すなわち <ESC>OD のキーコードとなる
" これを１つの塊とみなす時間指定がttimelenとなる
set timeout timeoutlen=1000 ttimeoutlen=75
"}}}

" その他 {{{

" set mouse=a                     " ターミナルマウスを有効
set hidden                      " 編集中に他ファイルを開ける

" set paste をトグル
set pastetoggle=<Leader>sp
augroup OffPasteOnInserLeave
    autocmd!
    autocmd InsertLeave * set nopaste
augroup END

" フォーカスを失ったら保存
augroup SaveOnFocusLost
    autocmd!
    autocmd FocusLost * :wa
augroup END

" Web+DB Vol52 {{{
" .vimrc を編集する
nnoremap <Leader>. :<C-u>edit $MYVIMRC<Enter>
" .vimrc をリロードする
nnoremap <Leader>s. :<C-u>source $MYVIMRC<Enter>

" 挿入モード時に日付を挿入する
inoremap <expr> ,df strftime('%Y-%m-%d %T')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

"}}}

" カレントウィンドウのみカーソル行をハイライトする
augroup highlightOnlyCurrentWindow
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" vim 起動時は tmux のステータスを隠す
if !has('gui_running') && $TMUX !=# ''
    augroup Tmux
        autocmd!
        autocmd VimEnter,VimLeave * silent !tmux set status
    augroup END
endif

"}}}

"}}}


