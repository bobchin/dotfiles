" ---------------------------------------------------------------------
" 参考
" http://ho-ki-boshi.blogspot.com/2007/07/vimrc.html
" http://yuroyoro.hatenablog.com/entries/2012/02/11
" https://github.com/yuroyoro/dotfiles
" ---------------------------------------------------------------------

" vi との互換性をもたない
set nocompatible

" NeoBundle {{{
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
filetype off
if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" }}}

let mapleader=' '

" プラグイン管理 {{{
NeoBundle 'Shougo/neobundle.vim'

" }}}

" ドキュメント管理 {{{
" vimdoc-ja
NeoBundle 'vim-jp/vimdoc-ja'

" <S-k>でカーソル上のキーワードを参照する vim bible 6-5
NeoBundle 'thinca/vim-ref'

" jQuery のリファレンス
" NeoBundle 'mojako/ref-sources.vim'
"javascript のリファレンス
" NeoBundle 'tokuhirom/jsref'

" Excite翻訳
NeoBundle 'mattn/excitetranslate-vim', {
  \ 'depends': 'mattn/webapi-vim'
  \ }

" }}}

" 入力補完 {{{
" 自動補完 vim bible 9-10
NeoBundle 'Shougo/neocomplcache'

" スニペット入力
NeoBundle 'Shougo/neosnippet'

" javascript の補完
" NeoBundle 'teramako/jscomplete-vim'
" }}}

" ctags {{{
NeoBundle 'taglist.vim'

" }}}


" unite {{{
" Unite vim bible 10-1
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-help'
" NeoBundle 'tsukkee/unite-tag'
" NeoBundle 'thinca/vim-unite-history'
" NeoBundle 'pasela/unite-webcolorname'

" vim のファイラー vim bible 2-2
NeoBundle 'Shougo/vimfiler'

" vim でシェル vim bible 6-11
NeoBundle 'Shougo/vimshell'

" vim から非同期実行
NeoBundle 'Shougo/vimproc', { 
\ 'build' : {
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }

" }}}


" looks {{{
" <Leader>ig でインデントガイドのトグル vim bible 4-14
NeoBundle 'nathanaelkane/vim-indent-guides'

" ステータスラインをきれいに表示
NeoBundle 'taichouchou2/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim' }
" NeoBundle 'Lokaltog/vim-powerline'

" colorscheme
NeoBundle 'altercation/vim-colors-solarized'

" }}}


" text-object {{{
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

" いろんなものをテキストオブジェクトにする
NeoBundle 'thinca/vim-textobj-plugins'

" [f] 関数の中身をテキストオブジェクトにする
NeoBundle 'kana/vim-textobj-function'

" }}}


" move cursor {{{
" <Leader><Leader>w/f で検索先をハイライトして移動 vim bible 4-9
NeoBundle 'Lokaltog/vim-easymotion'

" % コマンドによる移動を拡張 vim bible 4-10
NeoBundle 'matchit.zip'

" w での単語移動をスマートにする
NeoBundle 'kana/vim-smartword'

" ,w でキャメルケースやアンダーバー区切りで単語移動
NeoBundle 'camelcasemotion'

" }}}


" edit {{{
" gcc/<C-_><C-_> でコメントアウト vim bible 6-3
NeoBundle 'tomtom/tcomment_vim'

" <C-y>, で展開する vim bible 9-7
NeoBundle 'mattn/zencoding-vim'

" <Leader>tsp で空白整形 or <Leader>t{separator} でセパレータで整形 vim bible 5-11
" NeoBundle 'Align'

" マルチバイト対応の整形
NeoBundle 'h1mesuke/vim-alignta'

" true <=> false などをトグル。Insertモードでは<C-t>, それ以外では +
" <C-t> でトグル用にしている。
NeoBundle 'taku-o/vim-toggle'

" Markdownでメモ
NeoBundle 'tpope/vim-markdown'

" 翻訳
NeoBundle 'mattn/webapi-vim'

" }}}


" Git {{{
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'extradite.vim'
" }}}


" other {{{
" <Leader>r で編集中のファイルを簡単に実行できる vim bible 6-10
NeoBundle 'thinca/vim-quickrun'

" gx でカーソルの文字をブラウザで検索
NeoBundle 'tyru/open-browser.vim'

" 文字コードの自動認識
NeoBundle 'banyan/recognize_charcode.vim'

" 正規表現で検索 :M/ | :S | :G
NeoBundle 'othree/eregex.vim'
" }}}


" coding {{{
" trinity
NeoBundle 'Source-Explorer-srcexpl.vim'
NeoBundle 'trinity.vim'

" }}}


" php {{{
" CakePHP
" NeoBundle 'violetyk/cake.vim'

" }}}


" javascript {{{
" syntax
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'jQuery'

" }}}


" html {{{
" NeoBundle 'hail2u/vim-css3-syntax'
" NeoBundle 'othree/html5.vim'
" NeoBundle 'AtsushiM/sass-compile.vim'
" }}}

" SQL {{{
" NeoBundle 'dbext.vim'
" }}}


" ヤンクの履歴を保存し後から使用できるようにする vim bible 4-4
NeoBundle "YankRing.vim"

filetype plugin indent on       " ファイル別 plugin (~/.vim/ftplugin/拡張子.vim)
" }}}


" plugin {{{ ----------------------------------------------------------

" vim-ref {{{
" S-k でマニュアル検索
let g:ref_phpmanual_path = $HOME . '/.vim/reference/php/'

" webdict
let g:ref_source_webdict_sites = {
\   'eijiro': {
\     'url': 'http://eow.alc.co.jp/search?q=%s',
\   },
\   'longman': {
\     'url': 'http://www.ldoceonline.com/dictionary/%s_1',
\   },
\ }
let g:ref_source_webdict_sites.default = 'eijiro'
" 出力に対するフィルタ
function! g:ref_source_webdict_sites.eijiro.filter(output)
  return join(split(a:output, "\n")[35 :], "\n")
endfunction
function! g:ref_source_webdict_sites.longman.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction

" カーソル下のキーワードをヘルプでひく
nnoremap <C-i>k :<C-u>Ref webdict <C-r><C-w><Enter>

" ヘルプをqで閉じる
augroup CloseHelpWithQRef
    autocmd!
    autocmd FileType ref-phpmanual nnoremap <buffer>q :<C-u>q<CR>
    autocmd FileType ref-webdict nnoremap <buffer>q :<C-u>q<CR>
augroup END
" }}}


" jquery
let g:ref_jquery_doc_path = $HOME . '/.vim/reference/jquery/'
let g:ref_javascript_doc_path = $HOME . '/.vim/bundle/jsref/htdocs/'
let g:ref_auto_resize = 1


" neocomplcache {{{
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
    \ 'javascript' : $HOME.'/.vim/dict/jacascript.dict',
    \ 'php' : $HOME.'/.vim/dict/php.dict',
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" key-mappings.
" スニペットを展開する
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" UNDO
inoremap <expr><C-g> neocomplcache#undo_completion()
" 補完候補の共通部分までを補完する
inoremap <expr><C-l> neocomplcache#complete_common_string()

" 補完を確定して閉じる
inoremap <expr><C-y> neocomplcache#close_popup()
" 補完をキャンセルして閉じる
inoremap <expr><C-c> neocomplcache#cancel_popup()
" <CR> 候補が出ていれば確定にする
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" <TAB> で補完
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<UP>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"

" ファイル名補完をneocomplcacheで置き換える
inoremap <expr><C-x><C-f> neocomplcache#manual_filename_complete()

" FileType毎のOmni補完を設定
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php           setlocal omnifunc=phpcomplete#CompletePHP

" オムニ補完
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
" let g:neocomplcache_omni_patterns['php'] = '[^. \t]->\h\w*\|\h\w*::'

"ファイルタイプの関連付け
if !exists('g:neocomplcache_same_filetype_lists')
  let g:neocomplcache_same_filetype_lists = {}
endif
let g:neocomplcache_same_filetype_lists['ctp'] = 'php'

" snippets
let g:neosnippet#snippets_directory = $HOME.'/.vim/snippets'
" if has('conceal')
"   set conceallevel=2 concealcursor=i
" endif
" }}}


" taglist {{{
if (executable('/usr/bin/ctags'))
  let Tlist_Ctags_Cmd = '/usr/bin/ctags'
elseif (executable('/usr/local/bin/ctags'))
  let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
endif

nnoremap <silent> ft :<C-u>TlistToggle<CR>
" }}}


" unite {{{
" prefix key
nnoremap [unite] <Nop>
nmap f [unite]

" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
" nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 常用セット
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
" 整形
nnoremap <silent> [unite]l :<C-u>Unite alignta<CR>
" 全部のせ
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" help
nnoremap <C-i> :<C-u>Unite -start-insert help<CR>
nnoremap <C-i><C-i> :<C-u>UniteWithCursorWord help<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    let g:unite_enable_start_insert = 0

    nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-l> unite#do_action('split')
    nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
endfunction
" }}}


" vimfiler {{{
" vimfiler をデフォルトのファイラーにする
let g:vimfiler_as_default_explorer = 1
" セーフモードを無効化する
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> ff :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> fi :<C-u>:VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -no-quit<CR>
" }}}


" indent-guides {{{
" let g:indent_guideson_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
" }}}


" powerline
let g:Powerline_symbols = 'compatible'
let g:Powerline_mode_i = '挿入'
let g:Powerline_mode_R = '置換'
let g:Powerline_mode_n = '通常'
let g:Powerline_mode_v = 'ビジュアル'
let g:Powerline_mode_V = '行ビジュアル'
let g:Powerline_mode_cv = '矩形ビジュアル'
let g:Powerline_mode_s = '選択'
let g:Powerline_mode_S = '行選択'
let g:Powerline_mode_cs = '矩形選択'
set laststatus=2
set noshowmode


" matchit
let b:match_words = &matchpairs . ",\<if\>:\<endif\>,\<:\>"
let b:match_ignorecase = 1


" tcomment {{{
" <C-_>b ブロックコメント
" <C-_>i 囲むようにコメント
" Space + / コメントをトグル
nmap <Leader>/ <C-_><C-_>
vmap <Leader>/ <C-_><C-_>

if !exists( 'g:tcomment_types' )
  let g:tcomment_types = {}
endif
let g:tcomment_types = {
  \'php_surround' : "<?php %s ?>",
  \'php_surround_echo' : "<?php echo %s ?>"
\}
au FileType php imap <buffer><C-_>c :TCommentAs php_surround<CR>
au FileType php imap <buffer><C-_>= :TCommentAs php_surround_echo<CR>
au FileType php imap <buffer><C-_>e :TCommentAs php_surround_echo<CR>
" }}}


" Zencoding
" <C-y>,
let g:user_zen_settings = {
\   'indentation' : '    ',
\   'javascript' : {
\       'snippets' : {
\           'jq' : "$function(){\n\t${cursor}${child}\n};",
\           'jq:each' : "$.each(${cursor}, function(index, item){\n\t${child}\n});",
\           'fn' : "(function(){\n\t${cursor}\n})();",
\           'tm' : "setTimeout(function(){\n\t${cursor}\n}, 100);",
\       },
\   },
\}


" Align
" let g:Align_xstrlen = 3       " for japanese string
" let g:DrChipTopLvlMenu = ''   " remove 'DrChip' menu


" toggle
imap <C-t> <Plug>ToggleI
nmap <C-t> <Plug>ToggleN
vmap <C-t> <Plug>ToggleV


" open-browser
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" qtmplsel
" let g:qts_templatedir = $HOME.'/.vim/template'

" quickrun
" <Leader>r で実行
" 横分割するようにする
let g:quickrun_config   = {}
let g:quickrun_config._ = {
  \ 'split': 'below',
  \ }
let g:quickrun_config.markdown = {
  \ 'outputter': 'browser',
  \ }


" CakePHP
let g:cakephp_enable_fix_mode = 1
let g:cakephp_app = ""
let g:cakephp_enable_auto_mode = 1

nnoremap <Leader>ca :Cakephp<Space>./<CR>
nnoremap <Leader>cc :Ccontroller<Space>
nnoremap <Leader>cm :Cmodel<Space>
nnoremap <Leader>cv :Cview<Space>
nnoremap <Leader>cs :Cshell<Space>
nnoremap <Leader>ct :Ctask<Space>
nnoremap <Leader>ccf :Cconfig<Space>
nnoremap <Leader>cf :Cconfig<Space>
nnoremap <Leader>ccp :Ccomponent<Space>
nnoremap <Leader>cp :Ccomponent<Space>
nnoremap <Leader>cl :Clog<Space>

" YankRing
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '.yankring_history'
let g:yankring_max_history = 10
let g:yankring_window_height = 13


" ---------------------------------------------------------------------
" HTML
" ---------------------------------------------------------------------
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" ---------------------------------------------------------------------
" 文字コード
" ---------------------------------------------------------------------
set encoding=utf-8                " vim 内部文字コード
set ffs=unix,dos,mac              "
" set fencs=                      " 空白設定すると常に enc で開く
set langmenu=japanese
scriptencoding utf-8

" 以下のファイルの時は文字コードをutf-8に設定
autocmd FileType js :set fileencoding=utf-8
autocmd FileType css :set fileencoding=utf-8
autocmd FileType html :set fileencoding=utf-8
autocmd FileType php :set fileencoding=utf-8

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932


" ---------------------------------------------------------------------
" インデント
" ---------------------------------------------------------------------
set autoindent                  " 自動でインデント
set smartindent                 " インデント調整あり・コメント維持
set shiftwidth=4                " tab 文字の入力幅
set tabstop=4                   " tab 文字の表示幅
set softtabstop=0               " tab キーを押したときに挿入される空白の量
set expandtab                   " tab を空白文字に置き換え
if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "そのファイルタイプにあわせたインデントを利用する
  filetype indent on

  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
endif


" ---------------------------------------------------------------------
" 削除
" ---------------------------------------------------------------------
set backspace=indent,eol,start  " BS でindent,改行,挿入開始前を削除
set smarttab                    " BS でインデント幅を削除


" ---------------------------------------------------------------------
" 検索
" ---------------------------------------------------------------------
set hlsearch                    " 検索文字列を色付け
set ignorecase                  " 大文字小文字を判別しない
set smartcase                   " でも大文字小文字が混ざってい入力されたら区別する
set incsearch                   " インクリメンタルサーチ
set wrapscan                    " 検索が終わったら最初から検索しなおしする
set gdefault                    " 置換で g オプションをデフォルトにする
" enter で検索ハイライトをクリア
nnoremap <silent> <cr> :noh<cr><cr>
" visual 選択中に * で選択文字列を検索
vnoremap * y/\V<c-r>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<cr><cr>gV


" ---------------------------------------------------------------------
" バックアップ
" ---------------------------------------------------------------------
"set backup                      " ファイル上書きでバックアップファイルを作成
"set backupdir=/vim_back
"set directory=/vim_back


" ---------------------------------------------------------------------
" 表示
" ---------------------------------------------------------------------
set background=dark             " 背景の明るさ。light or dark
syntax on                       " シンタックスの色付けを有効
set ruler                       " 左下に行列位置を表示
set showcmd                     " 入力中のコマンドを右下に表示
set showmatch                   " カッコの入力で対応するカッコを一瞬強調
set splitbelow                  " split で新規ウィンドウは下側に
set splitright                  " vsplit で新規ウィンドウは右側に
set title                       " ウィンドウタイトルを書き換える
set number                      " 行番号を表示する
" set/oldmethod=marker

" カーソル行を強調表示
set cursorline

" 全角スペースの表示
scriptencoding utf-8
augroup highlightIdegraphicSpace
    autocmd!
    autocmd ColorScheme * highlight IdegraphicSpace term=underline ctermbg=lightblue guibg=darkblue
    autocmd VimEnter,WinEnter * match IdegraphicSpace /　/
augroup END

" http://vim-users.jp/2009/07/hack40/
set list
set listchars=tab:>.,trail:_,nbsp:%,extends:>,precedes:<

set t_Co=256
set ttymouse=xterm2

" カラーテーマ
let g:solarized_termcolors=16
let g:solarized_termtrans=0
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast='normal'
let g:solarized_visibility='normal'
colorscheme solarized


" ---------------------------------------------------------------------
" 補完
" ---------------------------------------------------------------------
set wildmenu                    " コマンド入力をタブで補完
set wildchar=<Tab>              " コマンド補完を開始するキー
set wildmode=list:longest,full  " 補完動作（リスト表示で最長一致、その後選択）
set history=1000                " コマンドの履歴数

" <c-space> で omni 補完
" inoremap <C-Space> <C-x><C-o>


" ---------------------------------------------------------------------
" 入力
" ---------------------------------------------------------------------
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>

" insert mode での移動
inoremap <C-e> <END>
inoremap <C-a> <HOME>

" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

" inoremap <C-f> <PageDown>
" inoremap <C-b> <PageUp>

" F2で前のバッファ
map <F2> <ESC>:bp<CR>
" F3で次のバッファ
map <F3> <ESC>:bn<CR>

" 矩形選択時にテキストがないところでも選択可能にする
set virtualedit+=block

" normal mode 時 ; を : にする
nnoremap ; :

" insert mode 時 <C-w> で保存
inoremap <C-w> <Esc>:<C-u>w<Enter>a

" insert mode 時 jj でノーマルモードへ
inoremap jj <ESC>

" insert mode 時 Enter で途中改行
" inoremap <Enter> <Esc>o
" inoremap <C-j> <Esc>o

" ビジュアルモード時に連続でインデントする
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv


" ---------------------------------------------------------------------
" Help
" C-] <=> C-O
" ---------------------------------------------------------------------
set helplang=ja
" Ctrl-i でヘルプ
" nnoremap <C-i> :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
" nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>
" ヘルプをqで閉じる
augroup CloseHelpWithQ
    autocmd!
    autocmd FileType help nnoremap <buffer>q <C-w>c
augroup END


" ---------------------------------------------------------------------
" その他
" ---------------------------------------------------------------------
" set mouse=a                     " ターミナルマウスを有効
set hidden                      " 編集中に他ファイルを開ける

" set paste をトグル
set pastetoggle=<Space>sp

" フォーカスを失ったら保存
au FocusLost * :wa


" ---------------------------------------------------------------------
" Web+DB Vol52
" ---------------------------------------------------------------------
" .vimrc を編集する
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
" .vimrc をリロードする
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

" 挿入モード時に日付を挿入する
inoremap <expr> ,df strftime('%Y-%m-%d %T')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

" " 最後に選択した範囲を選択する
" nnoremap gc `[v`]
" vnoremap gc :<C-u>normal gc<Enter>
" onoremap gc :<C-u>normal gc<Enter>

" カレントウィンドウのみカーソル行をハイライトする
augroup highlightOnlyCurrentWindow
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" カーソルキーを使用しないようにする
" nnoremap <Left>           :call DrillInstructor('left',  0)<CR>
" nnoremap <Right>          :call DrillInstructor('right', 0)<CR>
" nnoremap <Up>             :call DrillInstructor('up',    0)<CR>
" nnoremap <Down>           :call DrillInstructor('down',  0)<CR>
" inoremap <Left>     <ESC> :call DrillInstructor('left',  1)<CR>
" inoremap <Right>    <ESC> :call DrillInstructor('right', 1)<CR>
" inoremap <Up>       <ESC> :call DrillInstructor('up',    1)<CR>
" inoremap <Down>     <ESC> :call DrillInstructor('down',  1)<CR>
"
" function! DrillInstructor(key, insert)
"   let s:extra_msg = (a:insert) == 1 ? '[ESC] to ' : ''
"   echo printf("Don't use %s-key!!! Press %s[h]", a:key, s:extra_msg)
" endfunction
"

" vim 起動時は tmux のステータスを隠す
if !has('gui_running') && $TMUX !=# ''
    augroup Tmux
        autocmd!
        autocmd VimEnter,VimLeave * silent !tmux set status
    augroup END
endif







