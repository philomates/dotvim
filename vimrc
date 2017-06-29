set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

set clipboard+=unnamedplus

" {{{ PLUG
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'

Plug 'clojure-vim/async-clj-omni'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fholiveira/vim-clojure-static',  { 'for': 'clojure', 'branch': 'hack-update'}
Plug 'hkupty/async-clj-highlight'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'
Plug 'clojure-vim/acid.nvim'

Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-classpath'
Plug 'terryma/vim-expand-region'
Plug 'klen/python-mode'
Plug 'morhetz/gruvbox'
Plug 'osyo-manga/vim-brightest'
Plug 'henrik/vim-qargs'
Plug 'majutsushi/tagbar'
Plug 'wlangstroth/vim-racket'
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'benekastah/neomake', { 'for': ['python', 'javascript', 'json'] }
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mileszs/ack.vim'

Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }

call plug#end()


" }}}

"{{{ LAYOUT and SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " Use Vim defaults instead of 100% vi compatibility

set number
set ruler
set noincsearch

set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set ff=unix "removes ^M dos stuff
"set foldmethod=marker " auto fold {{{,}}}
set nofoldenable

set switchbuf=useopen

" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

set history=100 " have fifty lines of command-line (etc) history

" change the mapleader from \ to ,
let mapleader=","
let maplocalleader="`"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme gruvbox
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ts=2 " Tab size
set sw=2 " Shift Width - Auth indent size
set sts=2 " Soft Tab Stops - Backspace over 2 spaces like it was one tab
set expandtab " Convert tabs to spaces
set smarttab

set ai "Auto indent
set si "Smart indet
set copyindent " copy the previous indentation on autoindenting

set iskeyword+=_,$,@,%,# " none of these are word dividers
set linespace=0 " don't insert extra pixels between rows

" welcome to the 21st century
set encoding=utf-8
set fileencoding=utf-8

" highlight whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set mouse=c

syntax enable
syntax on

" user pare to format text (gq)
" w - specify line length
" r - repeat characters in bodiless lines
" j - justifies text
" e - remove ‘superflous’ lines
" q - handle nested quotations in plaintext email
":set formatprg=par


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" always show a status line
set laststatus=2

set statusline=%<%f%r%h%w\ [%L]\%=\:\b%n\ %y\ [%04l,%04v]\ %p%%\ %m
"                 | | | |    |       |     |   |      |    |      |
"                 | | | |    |       |     |   |      |    |      +-- modified
"                 | | | |    |       |     |   |      |    +-- percent
"                 | | | |    |       |     |   |      +-- current column
"                 | | | |    |       |     |   +-- current line
"                 | | | |    |       |     +-- current syntax
"                 | | | |    |       +-- current buffer
"                 | | | |    +-- number of lines
"                 | | | +-- preview flag in square brackets
"                 | | +-- help flag in square brackets
"                 | +-- readonly flag in square brackets
"                 +--path to file buffer

set showmode " display current mode and partially-typed commands in status line
set showcmd " Show command in statusline as it's being typed

set hidden " Let us move between buffers without writing them.
set wildmenu " turn on command line completion wild style
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.class,*.svn,*.jpg,*.gif,*.png,*.glob,*.vo,*.log,*.aux

" too long of code
" set colorcolumn=85

"}}}

" {{{ MOVEMENT
" Movement between split windows
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
" because Ctrl-h wasn't mapping correctly in nvim...
nnoremap <Backspace> <Esc><C-w>h

" Maps Alt-[h,j,k,l] to resizing a window split
nnoremap <C-LEFT> <C-w><
nnoremap <C-UP> <C-W>+
nnoremap <C-DOWN> <C-W>-
nnoremap <C-RIGHT> <C-w>>

nnoremap <C-G> :cnext<CR>
nnoremap <C-T> :cprev<CR>
nnoremap <C-S-A-RIGHT> :lnext<CR>
nnoremap <C-S-A-LEFT> :lprev<CR>

" instead of 0
noremap H ^
" instead of $
noremap L g_


"sets viewport scroll x3
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" remap j and k so that they move one screen line even when file lines wrap
noremap j gj
noremap k gk

" Map jj to <Esc> during insert mode
imap jj 

" got to parent block
nnoremap ]s vatatv
nnoremap [s vatatov

let g:sexp_enable_insert_mode_mappings = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" }}}

" {{{ SEARCHING
set hls " Turn highlight search on by default

" Let \ clear the search highlighting
map <silent> \ :let @/=""<cr>

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

let g:brightest#highlight = { "group" : "BrightestUnderline" }

" List of buffers
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <leader>f :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

command! -bar FZFTags if !empty(tagfiles()) | call fzf#run({
\   'source': "sed '/^\\!/d;s/\t.*//' " . join(tagfiles()) . ' | uniq',
\   'sink':   'tag',
\ }) | else | echo 'Preparing tags' | call system('ctags -R') | FZFTag | endif
nnoremap <leader>ta :FZFTags<CR>
" Highlight word {{{
nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>
" }}}

" }}}

" {{{ MAPS AND FUNCTIONS
" Editing vimrc
nmap <silent> <leader>r :source $MYVIMRC<CR>
nmap <silent> <leader>e :edit $MYVIMRC<CR>

" Sudo Save
command! W w !sudo tee % >/dev/null

" in normal mode, toggle paste mode and line numbers
nnoremap <F2> :set invnumber<CR>:set invpaste paste?<CR>
set pastetoggle=<F2> "switch between insert paste and insert

"allow deleting selection without updating the clipboard (yank buffer)
noremap x "_x
noremap X "_X

" no more shift for :
nnoremap ; :

" close quickfix window
nnoremap <leader>r :ccl <CR>

" aaaaag
nnoremap <leader>a :Ack
" search current word under cursor
nnoremap <leader>z :Ack --literal "<C-R><C-W>"<CR>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" select things that were just pasted
nnoremap <leader>v V`]

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Fuck you too, manual key.
nnoremap K <nop>

" Lambda for racket
imap <C-S-L> λ

" Change case up
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

nnoremap <C-p> :FZF<CR>

" Change case down
nnoremap <C-d> guiw
inoremap <C-d> <esc>guiwea

" Show current file in NERDTree
nmap \f :NERDTreeFind<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Really useful!
" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" open starting from path of current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/"  <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>

" replaces all exact instances of a variable in a file with another
function! ReplaceVar()
  let old_var = expand("<cword>")
  let new_var = input("Replace ".old_var." with: ")
  exe "normal! mZ"
  exe "%s/\\<".old_var."\\>/".new_var."/g"
  exe "normal! `Z"
endfunction

noremap <F8> :call ReplaceVar()<CR>
noremap <F7> :TagbarToggle<CR>

let g:tagbar_autofocus = 1
noremap <F6> :NERDTreeToggle<CR>

" Command Make will call make and then cwindow which
" " opens a 3 line error window if any errors are found.
" " If no errors, it closes any open cwindow.
":command -nargs=* Make make <args> | cwindow 3

if maparg("<F9>") == ""
    map <F9> :make!<CR>
endif

" to run type :DiffSaved, to turn off type :diffoff
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" remove spaces at EOL
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

command! NuTapd :normal i#nu/tapd <ESC>
command! RemoveNuTapd :normal V :s/#nu\/tapd\ //g<CR>
nmap <leader>n :NuTapd<CR>
nmap <leader>m :RemoveNuTapd<CR>
command! NuCatchd :normal i#nu/catchd <ESC>
command! RemoveNuCatchd :normal V :s/#nu\/catchd\ //g<CR>
nmap <leader>w :NuCatchd<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" disable man lookup
map <S-k> l


" save session maps
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
noremap <leader>q :mksession! ~/.vim/.session <CR>
noremap <leader>s :source ~/.vim/.session <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Surround.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap s ysi
nmap S ysa
nmap s$ ys$
nmap sv gvs

" }}}

" {{{ FILETYPE STUFF
" Activate auto filetype detection
filetype on
filetype plugin on
filetype indent on

" disable for html
autocmd filetype html,xml set listchars-=tab:>.
autocmd filetype html,xml set iskeyword+=-

" xml
autocmd FileType xml setlocal equalprg=xmllint\ --format\ -\ 2>/dev/null

let NERDTreeIgnore = ['\.pyc$','\.aux$','\.class$','\.toc$','\.pdf$','\.log$','\.glob','\.v.d','\.vo','#$[[file]]']
let g:NERDTreeMapUpdirKeepOpen = "-"
let NERDTreeHijackNetrw=1

au BufRead,BufNewFile *.scrbl set filetype=scribble
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.gradle setf groovy

" java
let g:syntastic_java_javac_classpath = $CLASSPATH . ':/home/mates/programming/java/textual-filters/build/classes'
au FileType java set ts=4 sw=4 sts=4 tags=.tags


" .md is a markdown filetype
au BufRead,BufNewFile *.md set filetype=pdc
au BufRead,BufNewFile *.md.draft set filetype=pdc
au! BufRead,BufNewFile *.ott setfiletype ott

set directory=$HOME/.vim/tmp//

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extended python highlighting
let python_highlight_all=0
au FileType python set makeprg=pylint\ --reports=n\ --output-format=parseable\ --rcfile=/home/mates/.pylintrc\ %
au FileType python set errorformat=%f:%l:\ %m
au FileType python set ts=4 sw=4 sts=4
" Pylint support
let g:pymode_lint = 1
let g:pymode_lint_message = 1
let g:pymode_lint_cwindow = 1
let g:pymode_folding = 0
let g:pymode_doc = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope = 0
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
au BufWriteCmd *.py write || :PymodeLint

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LaTeX-Suite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
" let g:tex_flavor='latex'
" let g:tex_indent_items = 1
" let g:tex_indent_brace = 0
" let g:Tex_EnvironmentMaps = 0
" let g:Tex_EnvironmentMenus = 0
" let g:Tex_FontMaps = 0
" let g:Tex_FontMenus = 0
" let g:Tex_SectionMaps = 0
" let g:Tex_SectionMenus = 0

" overriding imaps JumpFunc
" let g:Imap_UsePlaceHolders=1
" nmap <C-U> <Plug>IMAP_JumpForward
" nmap <F3> :w !detex \| wc -w<CR>
" nmap <F10> :!pdflatex %<CR>
" let g:Tex_IgnoredWarnings=1
" au FileType tex set makeprg=make
" au FileType tex map <F9> :Make<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Haskell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use ghc functionality for haskell files
" au Bufenter *.hs compiler ghc
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
au FileType haskell nnoremap <buffer> <F4> :Hoogle
au FileType haskell nnoremap <buffer> <C-F4> :HoogleClose<CR>
let g:haddock_browser = "/usr/bin/chromium"
let g:haddock_docdir = "/usr/share/doc/ghc/html/"
au Bufenter *.hs compiler ghc
" Reload
map <silent> <leader>tu :call GHC_BrowseAll()<CR>
" Type Lookup
map <silent> <leader>tw :call GHC_ShowType(1)<CR>
" let g:syntastic_haskell_checkers=['hdevtools', 'hlint']

autocmd FileType coq set commentstring=(*\ %s\ *)

autocmd FileType clojure set iskeyword-=/
au FileType clojure nnoremap <buffer> <F3> :Require<CR>
au FileType clojure nnoremap <buffer> <F4> :RunTests<CR>

" }}}

" Digraphs {{{
digraph -( 8713
digraph -0 8888
digraph -\ 8614
digraph \- 8866
digraph ~> 8669
digraph \> 8657
digraph \< 8659
digraph \2 8777
" ⅋
digraph -& 8523
" ⊗
digraph 0x 8855
" ْْ⊕
digraph 0+ 8853
" }}}

  " Split/Join {{{
  "
  " Basically this splits the current line into two new ones at the cursor position,
  " then joins the second one with whatever comes next.
  "
  " Example:                      Cursor Here
  "                                    |
  "                                    V
  " foo = ('hello', 'world', 'a', 'b', 'c',
  "        'd', 'e')
  "
  "            becomes
  "
  " foo = ('hello', 'world', 'a', 'b',
  "        'c', 'd', 'e')
  " }}}

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['haskell', 'clojure'],
                           \ 'passive_filetypes': ['python', 'java', 'tex', 'puppet'] }
map <silent> <Leader>c :Errors<CR>
map <Leader>x :SyntasticToggleMode<CR>

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  " set t_ut=
endif

let g:sexp_insert_after_wrap = 0

source $HOME/.vim/conf/deoplete.vim
source $HOME/.vim/conf/acid.vim
source $HOME/.vim/conf/iron_nvimux.vim
source $HOME/.vim/conf/bufexplorer.vim

let @t = 'i(tryl%a(catch Exception e(kb (nu/tapd e)))lh%'
let @c = 'ldwJhxx%a)jjjddk$h%'
