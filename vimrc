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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme inkpot

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ts=4 " Tab size
set sw=4 " Shift Width - Auth indent size
set sts=4 " Soft Tab Stops - Backspace over 4 spaces like it was one tab
set expandtab " Convert tabs to spaces
set smarttab

set ai "Auto indent
set si "Smart indet
set copyindent " copy the previous indentation on autoindenting

set iskeyword+=_,$,@,%,# " none of these are word dividers
set linespace=0 " don't insert extra pixels between rows

" welcome to the 21st century
set encoding=utf-8

" highlight whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

syntax enable

" user pare to format text (gq)
" w - specify line length
" r - repeat characters in bodiless lines
" j - justifies text
" e - remove ‘superflous’ lines
" q - handle nested quotations in plaintext email
:set formatprg=par


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
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.class,*.svn,*.jpg,*.gif,*.png

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
set hls " Turn highlight search on by defaul

" Let \ clear the search highlighting
map <silent> \ :let @/=""<cr>

" Let H toggle highlighting
map <silent> H :set hls!<CR>
" }}}

" {{{ MAPS AND FUNCTIONS
" Editing vimrc
nmap <silent> <leader>r :source $MYVIMRC<CR>
nmap <silent> <leader>e :edit $MYVIMRC<CR>

command W w !sudo tee % >/dev/null

" split windows
nmap - :Sexplore<CR>

" in normal mode, toggle paste mode and line numbers
nnoremap <F2> :set invnumber<CR>:set invpaste paste?<CR>
set pastetoggle=<F2> "switch between insert paste and insert

"allow deleting selection without updating the clipboard (yank buffer)
noremap x "_x
noremap X "_X

" no more shift for :
nnoremap ; :

" aaaaack
nnoremap <leader>a :Ack

" select things that were just pasted
nnoremap <leader>v V`]

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

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
  let new_var = input("Replace With?: ")
  let old_var = expand("<cword>")
  exe "%s/\\<".old_var."\\>/".new_var."/g"
endfunction

noremap <F8> :call ReplaceVar()<CR>
noremap <F7> :TlistToggle<CR>
noremap <F6> :NERDTreeToggle<CR>

" Command Make will call make and then cwindow which
" " opens a 3 line error window if any errors are found.
" " If no errors, it closes any open cwindow.
":command -nargs=* Make make <args> | cwindow 3

if maparg("<F5>") == ""
    map <F5> :Run<CR>
endif

if maparg("<F9>") == ""
    map <F9> :make<CR>
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extended python highlighting
let python_highlight_all=0
" Pylint support
autocmd FileType python compiler pylint
let g:pylint_onwrite = 0
let g:pylint_show_rate = 0
let g:pylint_cwindow = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LaTeX
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" overriding imaps JumpFunc
let g:Imap_UsePlaceHolders=0
nmap <C-U> <Plug>IMAP_JumpForward

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Haskell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
" configure browser for haskell_doc.vim
let g:haddock_browser = "/usr/bin/firefox"

" }}}
