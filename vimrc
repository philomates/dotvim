"{{{ LAYOUT and SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " Use Vim defaults instead of 100% vi compatibility

set number
set ruler

set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set ff=unix "removes ^M dos stuff
set foldmethod=marker " auto fold {{{,}}}

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

" pathogen bundles
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = ['vim-latex', 'latex-suite']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme inkpot

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

" set statusline=%<%f%r%h%w\ [%L]\%=\:\b%n\ %y\ [%04l,%04v]\ %p%%\ %m
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

" Maps Alt-[h,j,k,l] to resizing a window split
nnoremap <C-LEFT> <C-w><
nnoremap <C-UP> <C-W>+
nnoremap <C-DOWN> <C-W>-
nnoremap <C-RIGHT> <C-w>>

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

" Let H toggle highlighting
map <silent> H :set hls!<CR>

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
command W w !sudo tee % >/dev/null

" in normal mode, toggle paste mode and line numbers
nnoremap <F2> :set invnumber<CR>:set invpaste paste?<CR>
set pastetoggle=<F2> "switch between insert paste and insert

"allow deleting selection without updating the clipboard (yank buffer)
noremap x "_x
noremap X "_X

" no more shift for :
nnoremap ; :

nnoremap <leader>w i{<ESC>l%a}<ESC>h%h

" aaaaag
nnoremap <leader>a :Ag!
nnoremap <leader>b :AgBuffer!

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

" Change case down
nnoremap <C-d> guiw
inoremap <C-d> <esc>guiwea

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 'et'

" Source
vnoremap <leader>S y:execute @@<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>

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

if maparg("<F5>") == ""
    map <F5> :Run<CR>
endif

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

noremap <F10> :Dispatch /home/mates/dimagi/branch_info.sh<CR>


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

let NERDTreeIgnore = ['\.pyc$','\.aux$','\.class$','\.toc$','\.pdf$','\.log$','\.glob','\.v.d','\.vo','#$[[file]]']
let g:NERDTreeMapUpdirKeepOpen = "-"
let NERDTreeHijackNetrw=1

au BufRead,BufNewFile *.scrbl set filetype=scribble
au BufNewFile,BufRead *.ejs set filetype=html

" java
let g:syntastic_java_javac_classpath = $CLASSPATH . ':/home/mates/programming/java/textual-filters/build/classes'
au FileType java set ts=4 sw=4 sts=4 tags=.tags


" .md is a markdown filetype
au BufRead,BufNewFile *.md set filetype=pdc
au BufRead,BufNewFile *.md.draft set filetype=pdc
au! BufRead,BufNewFile *.ott setfiletype ott
autocmd BufNewFile,BufRead *
  \ if expand('%:~') =~ '^\~/Dropbox' |
  \   set noswapfile |
  \ else |
  \   set swapfile |
  \ endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extended python highlighting
let python_highlight_all=0
au FileType python set makeprg=pylint\ --reports=n\ --output-format=parseable\ --rcfile=/home/mates/.pylintrc\ %
au FileType python set errorformat=%f:%l:\ %m
au FileType python set ts=4 sw=4 sts=4
" Pylint support
"autocmd FileType python compiler pylint
"let g:pylint_onwrite = 1
"let g:pylint_show_rate = 0
"let g:pylint_cwindow = 1

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

" Powerline ------------------------------------------------------------------- {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ 'NERD_tree' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? lightline#concatenate([expand('%:h'), expand('%:t')], 0) : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|NERD' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

" augroup AutoSyntastic
"   autocmd!
"   autocmd BufWritePost *.c,*.cpp call s:syntastic()
" augroup END
" function! s:syntastic()
"   SyntasticCheck
"   call lightline#update()
" endfunction
" }}}

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['haskell', 'python'],
                           \ 'passive_filetypes': ['java', 'tex', 'puppet'] }
map <silent> <Leader>c :Errors<CR>
map <Leader>x :SyntasticToggleMode<CR>

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
