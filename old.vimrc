" ---------------------------------------------------------------------
" 参考
" http://ho-ki-boshi.blogspot.com/2007/07/vimrc.html
" http://yuroyoro.hatenablog.com/entries/2012/02/11
" https://github.com/yuroyoro/dotfiles
" ---------------------------------------------------------------------
set encoding=utf-8
scriptencoding utf-8

" NeoBundle プラグインの指定 {{{

" NeoBundle 起動設定 {{{
" ---------------------------------------------------------------------
" インストール
"  $ mkdir -p ~/.vim/bundle
"  $ git clone https://github.com/Shougo/neobundle.vim neobundle.vim
"
" Github から取得する場合
" NeoBundle 'user_name/repository_name'
"
" vim-scriptsから取得する場合
" スクリプト名一覧 http://vim-scripts.org/vim/scripts.html
" NeoBundle 'script_name'
"
" 上記以外のgitリポジトリから取得する場合
" NeoBundle 'git://repository_url'
" ---------------------------------------------------------------------

" vim-tiny か vim-small の場合は初期化しない
if 0 | endif

let s:bundle_dir = '~/.vim/bundle/'
let s:neobundle_dir = s:bundle_dir . 'neobundle.vim/'

if has('vim_starting')
  if &compatible
    " vi との互換性をもたない
    set nocompatible
  endif

  let &runtimepath .= ','.s:neobundle_dir
endif

let s:vundle_readme=expand(s:neobundle_dir . 'README.md')
if !filereadable(s:vundle_readme)
  echo "Installing NeoBundle...\n"
  silent execute '!mkdir -p ' . s:bundle_dir
  silent execute '!git clone https://github.com/Shougo/neobundle.vim ' . s:neobundle_dir
endif
" }}}

"*****************************************************************************
"" NeoBundle Install Packages
"*****************************************************************************

" ここから実際のプラグイン指定 {{{

call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundle 自身を NeoBundle で管理する {{{
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" <Leader> をスペースにする<Space>ではうまく動かない {{{
let g:mapleader=' '
" }}}

" vimproc:vim から非同期実行 {{{
NeoBundle 'Shougo/vimproc', { 
\ 'build' : {
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac'    : 'make',
\     'linux'  : 'make',
\     'unix'   : 'gmake',
\     },
\ }
" }}}

" unite {{{
" Unite vim bible 10-1
NeoBundle 'Shougo/unite.vim', {
\ 'depends': 'Shougo/neomru.vim',
\ }
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'Shougo/unite-help'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/unite-filetype'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'cohama/agit.vim'
" }}}

" vimfile {{{
" vim のファイラー vim bible 2-2
NeoBundle 'Shougo/vimfiler', {
\ 'depends' : 'Shougo/unite.vim',
\ 'mappings' : '<Plug>',
\ 'explorer' : '^\h\w*:',
\ }
" }}}

" vim shell {{{
" vim でシェル vim bible 6-11
NeoBundle 'Shougo/vimshell.vim', {
\ 'mappings': '<Plug>',
\ 'commands': [{
\   'name': ['VimShell'],
\   'complete': 'customlist,vimshell#complete'
\ }],
\ }
" }}}

" Help {{{
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-ft-help_fold'
" }}}

" 辞書参照 {{{
" <S-k>でカーソル上のキーワードを参照する vim bible 6-5
NeoBundle 'thinca/vim-ref'
NeoBundle 'mmisono/ref-dicts-en'
NeoBundle 'mattn/excitetranslate-vim', {
\ 'depends': 'mattn/webapi-vim',
\ }

NeoBundle 'taglist.vim'
" }}}

" 言語パック（言語毎のインデントとか構文のサポート） {{{
NeoBundle 'sheerun/vim-polyglot'
" }}}

" quickrun {{{
NeoBundle 'thinca/vim-quickrun', {
\   'depends': 'Shougo/vimproc',
\ }
NeoBundle 'osyo-manga/shabadou.vim', {
\   'depends': [
\       'thinca/vim-quickrun',
\       'Shougo/vimproc',
\       'Shougo/unite.vim',
\       'osyo-manga/unite-quickfix',
\   ],
\ }
NeoBundle 'osyo-manga/vim-watchdogs', {
\   'depends': [
\       'thinca/vim-quickrun',
\       'Shougo/vimproc',
\       'osyo-manga/shabadou.vim',
\       'cohama/vim-hier',
\       'dannyob/quickfixstatus',
\       'KazuakiM/vim-qfsigns',
\       'KazuakiM/vim-qfstatusline',
\   ],
\ }
" }}}

" 見た目 {{{
" ステータスラインをきれいに表示
NeoBundle 'itchyny/lightline.vim', {
\ 'depends': [
\   'tpope/vim-fugitive',
\   'osyo-manga/vim-anzu',
\ ],
\ }

" colorscheme
NeoBundle 'w0ng/vim-hybrid'

" <LeVader>ig でインデントガイドのトグル vim bible 4-14
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 't9md/vim-quickhl'
" }}}

" ウィンドウ操作 {{{
NeoBundle "simeji/winresizer"
" }}}

" folding {{{
NeoBundle 'LeafCage/foldCC.vim'
" }}}

" スニペット入力 {{{
NeoBundle 'Shougo/neosnippet.vim', {
\ 'depends': [
\   'Shougo/neosnippet-snippets',
\   'Shougo/context_filetype.vim',
\ ],
\}
" }}}

" 入力補完 {{{
function! s:meet_neocomplete_requirements()
  return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete.vim', {
  \ 'depends': 'Shougo/context_filetype.vim',
  \ }
  NeoBundleFetch 'Shougo/neocomplcache.vim'
else
  NeoBundleFetch 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neocomplcache.vim'
endif
" }}}

" 入力補助 {{{
NeoBundle 'kana/vim-smartchr'
NeoBundle 'cohama/lexima.vim'
" }}}

" カーソル移動 {{{
" % コマンドによる移動を拡張 vim bible 4-10
NeoBundle 'tmhedberg/matchit'

" w での単語移動をスマートにする
NeoBundle 'kana/vim-smartword'

" ,w でキャメルケースやアンダーバー区切りで単語移動
NeoBundle 'bkad/CamelCaseMotion'

" }}}

" 編集 {{{
" gcc/<C-_><C-_> でコメントアウト vim bible 6-3
NeoBundle 'tomtom/tcomment_vim'

" true <=> false などをトグル。Insertモードでは<C-t>, それ以外では +
" <C-t> でトグル用にしている。
NeoBundle 'taku-o/vim-toggle'

" Markdownでメモ
NeoBundle 'rcmdnk/vim-markdown', {
\ 'depends': 'godlygeek/tabular',
\ }
NeoBundle 'kannokanno/previm'

" }}}

" Git {{{
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
" }}}

" php {{{
" CakePHP
" NeoBundle 'violetyk/cake.vim'
NeoBundle 'arnaud-lb/vim-php-namespace'
" }}}

" HTML {{{
" NeoBundle 'amirh/HTML-AutoCloseTag'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundle 'tpope/vim-haml'
" <C-y>, で展開する vim bible 9-7
" NeoBundle 'mattn/zencoding-vim'
NeoBundle 'mattn/emmet-vim'
" }}}

" テキストオブジェクト {{{
" ixxx, axxx xxxはテキストオブジェクトが入る。
" 意味は i:inner a:a
" aw iw             | 単語（iskeyword）
" aW iW             | 単語（空白区切り）
" as is             | 分（sentence）
" ap ip             | 段落（paragraph）
" a[ a] i[ i]       | [
" a( a) i( i) ib    | (
" a< a> i< i>       | <
" at it             | Htmlタグ（tag）
" a{ a} aB i{ i} iB | {
" a" a' a` i" i' i` | " ' ``
" 
" テキストオブジェクトを囲んだりする vim bible 5-14
" ys{motion}{surround}            : surround で囲む
" ds{surround}                    : surround を削除する
" cs{old-surround}{new-surround}  : surround を変更する
NeoBundle 'tpope/vim-surround'

" . で surround.vim の作業を繰り返す vim bible 5-16
NeoBundle 'tpope/vim-repeat'

" テキストオブジェクト vim bible 5-15
" テキストオブジェクトを簡単に作成するためのコアモジュール
NeoBundle 'kana/vim-textobj-user'

" [i] インデントをテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-indent'

" [y] syntax highlight されたものをテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-syntax'

" [l] １行をテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-line'

" [z] フォールディングをテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-fold'

" [e] テキスト全体をテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-entire'

" [d] 日付をテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-datetime'

" [j] カッコをテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-jabraces'

" [/][?] 最後の検索にマッチした箇所をテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-lastpat'

" [f] 任意の文字で囲まれた範囲をテキストオブジェクトにする
NeoBundle 'thinca/vim-textobj-between'

" [c] コメントをテキストオブジェクトにする
NeoBundle 'thinca/vim-textobj-comment'

" [,]+w/b/e/ge スネークケースやキャメルケースをテキストオブジェクトにする
NeoBundle 'h1mesuke/textobj-wiw'

" [g] $/@/& などで始まる文字列（変数でよく使われれる）をテキストオブジェクトにする
NeoBundle 'vimtaku/vim-textobj-sigil'

" [f] 関数の中身をテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-function'

" }}}

" その他 {{{

" gx でカーソルの文字をブラウザで検索 {{{
NeoBundle 'tyru/open-browser.vim'
" }}}

" 文字コードの自動認識 {{{
NeoBundle 'banyan/recognize_charcode.vim'
" }}}

" region {{{
NeoBundle 'terryma/vim-expand-region'
" }}}

" coding {{{
" trinity
NeoBundle 'Source-Explorer-srcexpl.vim'
NeoBundle 'trinity.vim'

" }}}

" ヤンクの履歴を保存し後から使用できるようにする vim bible 4-4 {{{
NeoBundle "YankRing.vim"
" }}}

" }}} その他

call neobundle#end()

" ファイル別 plugin (~/.vim/ftplugin/拡張子.vim)
filetype plugin indent on 

" If there are uninstalled bundles found on startup,
" this will convenientlly prompt you to install them.
NeoBundleCheck
" }}}

" }}}


" NeoBundle 各プラグインの設定 {{{

" unite {{{
if neobundle#tap('unite.vim')
    function! neobundle#hooks.on_source(bundle)
        call unite#custom#profile('default', 'context', {
        \ 'auto_select': 0,
        \ 'start_insert': 0,
        \ })
        
        call unite#custom#action('file,cdable', 'agit', s:agit_action)
    endfunction

    augroup unite_my_settings
        autocmd!
        autocmd FileType unite call s:unite_my_settings()
    augroup END
    function! s:unite_my_settings()
        let g:unite_enable_start_insert = 0

        nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')
        inoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')
        nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
        inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    endfunction

    let s:agit_action = {}
    function! s:agit_action.func(dir)
        if isdirectory(a:dir.word)
            let s:dir = fnamemodify(a:dir.word, ':p')
        else
            let s:dir = fnamemodify(a:dir.word, ':p:h')
        endif
        execute 'Agit --dir=' . s:dir
    endfunction

    call neobundle#untap()
endif

" キーバインド
nnoremap [unite] <Nop>
nmap f [unite]

" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>

" レジスタ一覧 
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" 最近使用したファイル一覧 
nnoremap <silent> [unite]m :<C-u>Unite file_mru buffer<CR>

" ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>

" ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

" 整形
nnoremap <silent> [unite]l :<C-u>Unite alignta<CR>
" }}}

" vimfiler {{{
if neobundle#tap('vimfiler.vim')
    function! neobundle#hooks.on_source(bundle)
        call vimfiler#custom#profile('default', 'context', {
        \ 'safe': 0,
        \ })
    endfunction
endif

" vimfiler をデフォルトのファイラーにする
let g:vimfiler_as_default_explorer = 1

nnoremap <silent> ff :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> fi :<C-u>:VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -no-quit<CR>
" }}}

" vimshell {{{
nnoremap <Leader>sh :<C-u>VimShell<CR>
" }}}

" Help {{{
set helplang=ja

" キーマッピング
nnoremap <C-i> :<C-u>Unite help<CR>
nnoremap <C-i><C-i> :<C-u>UniteWithCursorWord help<CR>

" 'K' でヘルプを開く
set keywordprg=:help

" タブでヘルプを開く
nnoremap <Space>t :<C-u>tab help<Space>
nnoremap <Space>v :<C-u>vertical belowright help<CR>

augroup HelpSettings
    autocmd!

    " ヘルプをqで閉じる
    autocmd FileType help nnoremap <buffer>q <C-w>c
    " ヘルプを別タブで表示する
    autocmd FileType help nnoremap <silent><buffer>tm :<C-u>call <SID>MoveToNewTab()<CR>
augroup END

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
" }}}

" vim-ref {{{
" S-k でマニュアル検索
let g:ref_phpmanual_path = $HOME . '/.vim/reference/php/'

" webdict
let g:ref_source_webdict_sites = {
\   'eijiro': {
\     'url': 'http://eow.alc.co.jp/search?q=%s',
\   },
\ }
let g:ref_source_webdict_sites.default = 'eijiro'
" 出力に対するフィルタ
function! g:ref_source_webdict_sites.eijiro.filter(output)
    return join(split(a:output, "\n")[35 :], "\n")
endfunction

" ヘルプをqで閉じる
augroup CloseHelpWithQRef
    autocmd!
    autocmd FileType ref-* nnoremap <buffer><silent>q :<C-u>close<CR>
    autocmd BufEnter ==Translate==\ Excite nnoremap <buffer><silent>q :<C-u>close<CR>
augroup END

" カーソル下のキーワードをヘルプでひく
nnoremap <C-i>k :<C-u>Ref webdict <C-r><C-w><CR>
nnoremap <C-i>e :ExciteTranslate<CR>
" }}}

" taglist {{{
if (executable('/usr/bin/ctags'))
  let g:Tlist_Ctags_Cmd = '/usr/bin/ctags'
elseif (executable('/usr/local/bin/ctags'))
  let g:Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
endif
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_Use_Right_Window = 1

nnoremap <silent><Leader>l :<C-u>TlistToggle<CR>
" }}}

" quickrun {{{
" quickrun の実行を非同期実行にする
" 実行処理設定(runner)    : vimproc
" 出力処理設定(outputter) : multi(bufferとquickfixを使う)
" フック処理(hook)        :
"  close_buffer: 実行に失敗した場合にバッファを閉じる
"  close_quickfix: 実行終了時にquickfixを閉じる
"  unite_quickfix: 実行失敗時にunite_quickfixを起動する
"  close_unite_quickfix:
"  すでにunite_quickfixを開いている場合は閉じてから実行
"
" execオプションの書式
" %%: %自体
" %c: コマンド('command'で指定したもの)
" %o: コマンドラインオプション('cmdopt'で指定したもの)
" %s: ソースファイル
" %a: スクリプトの引数
let g:quickrun_config = {
\ '_': {
\   'runner': 'vimproc',
\   'runner/vimproc/updatetime': 40,
\   'outputter': 'multi:buffer:quickfix',
\   'outputter/buffer/split': ':botright 8sp',
\   'outputter/buffer/close_on_empty': 1,
\   'hook/close_buffer/enable_failure': 1,
\   'hook/close_quickfix/enable_exit': 1,
\   'hook/close_unite_quickfix/enable_hook_loaded': 1,
\   'hook/back_window/enable_exit': 1,
\   'hook/back_window/priority_exit': 1,
\   'hook/quickfix_status_enable/enable_exit': 1,
\   'hook/quickfix_status_enable/priority_exit': 2,
\   'hook/qfsigns_update/enable_exit': 1,
\   'hook/qfsigns_update/priority_exit': 3,
\   'hook/qfstatusline_update/enable_exit': 1,
\   'hook/qfstatusline_update/priority_exit': 4,
\ },
\ 'watchdogs_checker/_': {
\ },
\ 'watchdogs_checker/php': {
\   'command': 'php',
\   'exec': '%c -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0 -l %o %s:p',
\   'errorformat': '%m\ in\ %f\ on\ line\ %l',
\ },
\ }

" \   'hook/unite_quickfix/enable_failure': 1,
" \   'hook/back_window/enable_exit': 1,
" \   'hook/back_window/priority_exit': 1,
" \   'hook/quickfix_status_enable/enable_exit': 1,
" \   'hook/quickfix_status_enable/priority_exit': 2,

" watchdogsの設定をquickrunに追加する
call watchdogs#setup(g:quickrun_config)

" ファイル書き込み時にチェックするかどうか
let g:watchdogs_check_BufWritePost_enable = 0
let g:watchdogs_check_BufWritePost_enables = {
\   'php': 1,
\ }

" 一定時間キー入力がなかったらチェックする
let g:watchdogs_checkCursorHold_enable = 1
let g:watchdogs_checkCursorHold_enables = {
\   'php': 1,
\ }

" :WatchdogsRun後にlightline.vimを更新
let g:Qfstatusline#UpdateCmd = function('lightline#update')

" <Leader>qでquickfixを閉じる
" nnoremap <silent><Leader>q :<C-u>bwipeout! \[quickrun\ output\]<CR>
nnoremap <silent><Leader>q :<C-u>call <SID>QuickrunCloseWithQ()<CR>
function! s:QuickrunCloseWithQ()
    try
        if exists(":UniteClose")
            silent execute ":UniteClose"
        endif
        bwipeout! [quickrun
    catch
    endtry
endfunction
"}}}

" LightLine {{{
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
\   'lineinfo': "\ue0a1  %3l:%-2v",
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
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
\ }

" モード表示(表示幅が狭ければ表示しない)
function! LightLineMode()
    return &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" 読み込み専用(読み込み専用であれば"x")
function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
endfunction

" ファイル名(前後に読み込み専用と変更状態を挿入する)
function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
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
            return strlen(_) ? "\ue0a0" . _ : ''
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

" vim-anzu {{{
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
" }}}

" indent-guides {{{
let g:indent_guides_auto_colors = 0
augroup indentGuidesSettings
    autocmd!
    autocmd VimEnter,Colorscheme * :highlight IndentGuidesOdd  ctermbg=239
    autocmd VimEnter,Colorscheme * :highlight IndentGuidesEven ctermbg=242
    " g:indent_guides_enable_on_vim_startup だけではうまくいかなかった
    autocmd VimEnter,BufWinEnter * :IndentGuidesEnable
augroup END
" let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help']
" }}}

" quickhl {{{
nmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>m <Plug>(quickhl-manual-this)
nmap <Leader>M <Plug>(quickhl-manual-reset)
xmap <Leader>M <Plug>(quickhl-manual-reset)
" }}}

" folding {{{
" ---------------------------------------------------------------------
" http://d.hatena.ne.jp/leafcage/20111223/1324705686
" http://leafcage.hateblo.jp/entry/2013/04/24/053113
" ---------------------------------------------------------------------
set foldtext=FoldCCtext()
let g:foldCCtext_enable_autofdc_adjuster = 1
set foldcolumn=3
set fillchars=vert:\|
set foldmethod=marker

" マーカーの追加
nnoremap  z[     :<C-u>call <SID>put_foldmarker(0)<CR>
nnoremap  z]     :<C-u>call <SID>put_foldmarker(1)<CR>
function! s:put_foldmarker(foldclose_p) " {{{
  let crrstr = getline('.')
  let padding = crrstr=='' ? '' : crrstr=~'\s$' ? '' : ' '
  let [cms_start, cms_end] = ['', '']
  let outside_a_comment_p = synIDattr(synID(line('.'), col('$')-1, 1), 'name') !~? 'comment'
  if outside_a_comment_p
    let cms_start = matchstr(&cms,'\V\s\*\zs\.\+\ze%s')
    let cms_end = matchstr(&cms,'\V%s\zs\.\+')
  endif
  let fmr = split(&fmr, ',')[a:foldclose_p]. (v:count ? v:count : '')
    exe 'norm! A'. padding. cms_start. fmr. cms_end
endfunction
" }}}

" 次のマーカーへ移動
nnoremap <silent>zj :<C-u>call <SID>smart_foldjump('j')<CR>
nnoremap <silent>zk :<C-u>call <SID>smart_foldjump('k')<CR>
function! s:smart_foldjump(direction) "{{{
  if a:direction == 'j'
    let [cross, trace, compare] = ['zj', ']z', '<']
  else
    let [cross, trace, compare] = ['zk', '[z', '>']
  endif
 
  let i = v:count1
  while i
    let save_lnum = line('.')
    exe 'keepj norm! '. trace
    let trace_lnum = line('.')
    exe save_lnum
 
    exe 'keepj norm! '. cross
    let cross_lnum = line('.')
    if cross_lnum != save_lnum && eval('cross_lnum '. compare. ' trace_lnum') || trace_lnum == save_lnum
      let i -= 1
      continue
    endif
 
    exe trace_lnum
    let i -= 1
  endwhile
  mark `
  norm! zz
endfunction
"}}}

" フォールドレベル
nnoremap <silent>z0    :set foldlevel=0<CR>
nnoremap <silent>z1    :set foldlevel=1<CR>
nnoremap <silent>z2    :set foldlevel=2<CR>
nnoremap <silent>z3    :set foldlevel=3<CR>
nnoremap <silent>zu    :set foldlevel=<C-r>=foldlevel('.')-1<CR><CR>

"}}}

" neosnippet{{{
let g:neosnippet#snippets_directory = $HOME.'/.vim/snippets'

" スニペットを展開する
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" }}}

" neocomplete/neocomplcache {{{
if s:meet_neocomplete_requirements()
    " neocomplete を使用する場合の設定

    " 競合するのでAutoComplPopを無効化する
    let g:acp_enableAtStartup = 0

    " 起動時にneocomplecacheを有効にする
    let g:neocomplete#enable_at_startup = 1

    " 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1

    " シンタックスをキャッシュするときの最小文字数
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    " neocomplete を自動的にロックするバッファ名のパターン
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " 辞書補完の辞書を指定。filetype:辞書ファイル名
    let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ }

    " キーワードの定義
    if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " キーマッピング
    " <C-g>: UNDO
    " <C-l>: 補完候補の共通部分までを補完する
    " <C-y>: 補完を確定
    " <C-e>: 補完のキャンセル
    " <CR>: ポップアップを閉じてインデントを保存
    " <TAB> で補完
    " <C-h>, <BS>: ポップアップを閉じて<BS>
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()
    inoremap <expr><C-y> neocomplete#close_popup()
    inoremap <expr><C-e> neocomplete#cancel_popup()
    inoremap <silent><CR> <C-r>=<SID>my_cr_function()<CR>
    inoremap <expr><TAB>   pumvisible() ? "\<Down>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<UP>"   : "\<S-TAB>"
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<BS>"

    function! s:my_cr_function()
        " return (pumvisible() ? "\<C-y>" : "") . "\<CR>"
        " For no inserting <CR> key.
        return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction

    " オムニ補完を有効にする
    augroup OmnicompleteSettings
        autocmd!
        autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END

    " 重いオムニ補完を有効にする
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input#patterns = {}
    endif

else
    " neocomplcacheを使用する場合の設定

    " 競合するのでAutoComplPopを無効化する
    let g:acp_enableAtStartup = 0
    " 起動時にneocomplecacheを有効にする
    let g:neocomplcache_enable_at_startup = 1
    " 補完が自動的に開始される文字数
    let g:neocomplcache_auto_completion_start_length = 3
    " 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplcache_enable_smart_case = 1
    " Camel Case を有効にする。大文字を区切りとして補完する
    let g:neocomplcache_enable_camel_case_completion = 1
    " アンダーバー区切りとして補完する
    let g:neocomplcache_enable_underbar_completion = 1
    " シンタックスをキャッシュするときの最小文字数
    let g:neocomplcache_min_syntax_length = 3
    " neocomplcache を自動的にロックするバッファ名のパターン
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
    " 表示する候補の数
    let g:neocomplcache_max_list = 20

    " 辞書補完の辞書を指定。filetype:辞書ファイル名
    let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " FileType毎のOmni補完を設定
    augroup OmnicompleteSettings
        autocmd!
        autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
    augroup END

    " オムニ補完
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif

    " キーマッピング
    " UNDO
    " 補完候補の共通部分までを補完する
    " 補完を確定して閉じる
    " 補完をキャンセルして閉じる
    " <CR> 候補が出ていれば確定にする
    " <TAB> で補完
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    inoremap <expr><C-y> neocomplcache#close_popup()
    inoremap <expr><C-e> neocomplcache#cancel_popup()
    inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<UP>" : "\<S-TAB>"
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"
endif
" }}}

" smartchr/lexima {{{
" inoremap <expr>= smartchr#loop('=', '==', ' = ', ' == ', ' === ')
" inoremap <expr>+ smartchr#loop('+', '++', ' + ')
" inoremap <expr>- smartchr#loop('-', '--', ' - ')
" inoremap <expr>/ smartchr#loop('/', '//', ' / ', '// ')
" inoremap <expr>* smartchr#loop('*', ' * ')
" inoremap <expr>% smartchr#loop('%', ' % ')
" inoremap <expr>& smartchr#loop('&', '&&', ' & ', ' && ')
" inoremap <expr><Bar> smartchr#loop('<Bar>', '<Bar><Bar>', ' <Bar> ', ' <Bar><Bar> ')
" inoremap <expr>, smartchr#loop(',', ', ')
"
let g:lexima_no_default_rules     = 0
let g:lexima_enable_basic_rules   = 1
let g:lexima_enable_newline_rules = 0
let g:lexima_enable_space_rules   = 1
let g:lexima_enable_endwise_rules = 0
" }}}

" matchit {{{
" let b:match_words = &matchpairs . ',\<if\>:\<endif\>,\<:\>'
let b:match_ignorecase = 1
" }}}

" smartword {{{
map w <Plug>(smartword-w)
map b <Plug>(smartword-b)
map e <Plug>(smartword-e)
map ge <Plug>(smartword-ge)

map ,w <Plug>CamelCaseMotion_w
map ,b <Plug>CamelCaseMotion_b
map ,e <Plug>CamelCaseMotion_e
map ,ge <Plug>CamelCaseMotion_ge
" }}}

" tcomment {{{
if !exists( 'g:tcomment_types' )
  let g:tcomment_types = {}
endif
let g:tcomment_types = {
\ 'php_surround' : "<?php %s ?>",
\ 'php_surround_echo' : "<?php echo %s ?>"
\ }
augroup TCommentSettings
    autocmd!
    autocmd FileType php inoremap <buffer><C-_>c :TCommentAs php_surround<CR>
    autocmd FileType php inoremap <buffer><C-_>= :TCommentAs php_surround_echo<CR>
    autocmd FileType php inoremap <buffer><C-_>e :TCommentAs php_surround_echo<CR>
augroup END

" <C-_>b ブロックコメント
" <C-_>i 囲むようにコメント
" Space + / コメントをトグル
nnoremap <Leader>/ :TComment<CR>
vnoremap <Leader>/ :TComment<CR>
" }}}

" toggle {{{
imap <C-t> <Plug>ToggleI
nmap <C-t> <Plug>ToggleN
vmap <C-t> <Plug>ToggleV
"}}}

" vim-markdown {{{
let g:vim_markdown_folding_disabled=1
" }}}

" previm {{{
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
"}}}

" emmet/Zencoding {{{
" <C-y>,
" let g:user_zen_settings = {
let g:user_emmet_settings = {
\ 'lang' : 'ja',
\ 'indentation' : '    ',
\ 'javascript' : {
\     'snippets' : {
\         'jq' : "$function(){\n\t${cursor}${child}\n};",
\         'jq:each' : "$.each(${cursor}, function(index, item){\n\t${child}\n});",
\         'fn' : "(function(){\n\t${cursor}\n})();",
\         'tm' : "setTimeout(function(){\n\t${cursor}\n}, 100);",
\     },
\ },
\ 'php' : {
\     'extends' : 'html',
\     'filters' : 'html',
\ },
\ }
" }}}

" open-browser {{{
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
"}}}

" YankRing {{{
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '.yankring_history'
let g:yankring_max_history = 10
let g:yankring_window_height = 13
"}}}

" ExpandRegion {{{
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
"}}}

" HTML {{{
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
"}}}

"}}}


" Basic Settings {{{

" 文字コード {{{
set fileformats=unix,dos,mac
" set fencs=                      " 空白設定すると常に enc で開く
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
" set splitbelow                  " split で新規ウィンドウは下側に
set splitright                  " vsplit で新規ウィンドウは右側に
set title                       " ウィンドウタイトルを書き換える
set number                      " 行番号を表示する
set display=lastline
set pumheight=10                " 補完候補の表示枠の大きさ

" カーソル行を強調表示
set cursorline

" http://vim-users.jp/2009/07/hack40/
set list
set listchars=tab:>.,trail:_,nbsp:%,extends:>,precedes:<

" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace term=underline ctermbg=lightblue gui=underline guibg=darkblue
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufWinEnter * let w:m1 = matchadd('ZenkakuSpace', '　')
        " autocmd VimEnter,WinEnter,BufWinEnter * let w:m1 = matchadd('ZenkakuSpace', '\%u3000')
    augroup END
    call ZenkakuSpace()
endif

if !has('gui_running')
    set t_Co=256
endif
set ttymouse=xterm2

" カラーテーマ
" let g:solarized_termcolors=16
" let g:solarized_termtrans=0
" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_italic=1
" let g:solarized_contrast='normal'
" let g:solarized_visibility='normal'
" colorscheme solarized
if has('mac')
    let g:hybrid_use_iTerm_colors = 1
endif

" syntax と colorschemeの設定順を変えないこと
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
noremap <Leader>h :split<CR>
noremap <Leader>v :vsplit<CR>
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
set pastetoggle=<Space>sp
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
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
" .vimrc をリロードする
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

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


