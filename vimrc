set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

set clipboard+=unnamedplus

" {{{ PLUG
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'

" Plug 'fholiveira/vim-clojure-static',  { 'for': 'clojure', 'branch': 'hack-update'}
" Plug 'hkupty/async-clj-highlight'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': ['clojure', 'fennel']}
Plug 'Olical/conjure'
Plug 'Olical/aniseed'

Plug 'm00qek/baleia.nvim'

Plug 'junegunn/vim-easy-align'
Plug 'dart-lang/dart-vim-plugin'

" Python
" let g:jedi#completions_enabled = 0
" let g:jedi#use_splits_not_buffers = "right"
" Plug 'davidhalter/jedi-vim'
Plug 'sbdchd/neoformat'
Plug 'neomake/neomake'
let g:neomake_python_enabled_makers = ['pylint']

" Fennel
Plug 'bakpakin/fennel.vim'

Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'terryma/vim-expand-region'
Plug 'morhetz/gruvbox'
Plug 'henrik/vim-qargs'
Plug 'majutsushi/tagbar'
Plug 'wlangstroth/vim-racket'
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'jremmen/vim-ripgrep'

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
" Plug 'chrisbra/Colorizer'
call plug#end()


" }}}

"{{{ LAYOUT and SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " Use Vim defaults instead of 100% vi compatibility
set backupcopy=yes

set number
set ruler
set noincsearch

set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set ff=unix "removes ^M dos stuff
set foldmethod=marker " auto fold {{{,}}}
set nofoldenable
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

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
let maplocalleader="-"

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

" {{{ LANGUAGE SERVER
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
let g:sexp_filetypes = 'clojure,fennel'

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


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
nmap <silent> <leader>R :source $MYVIMRC<CR>
nmap <silent> <leader>E :edit $MYVIMRC<CR>

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
nnoremap <leader>a :Rg
" search current word under cursor
nnoremap <leader>z :Rg -F "<C-R><C-W>"<CR>
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

set grepprg=rg\ --vimgrep

" select things that were just pasted
nnoremap <leader>v V`]

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Lambda for racket
imap <C-S-L> λ

" Change case up
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

nnoremap <C-p> :FZF<CR>

" Change case down
nnoremap <C-d> guiw
inoremap <C-d> <esc>guiwea

inoremap <C-N> <C-X><C-O>

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

" disable '-' mapping
noremap - <NOP>

" save session maps
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
noremap <leader>Q :mksession! ~/.vim/.session <CR>
noremap <leader>S :source ~/.vim/.session <CR>

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
let g:NERDTreeMapUpdirKeepOpen = "U"
let NERDTreeHijackNetrw=1

au BufRead,BufNewFile *.scrbl set filetype=scribble
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.gradle setf groovy

" java
au FileType java set ts=4 sw=4 sts=4 tags=.tags

" .md is a markdown filetype
au BufRead,BufNewFile *.md set filetype=pdc
au BufRead,BufNewFile *.md.draft set filetype=pdc

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
" au BufWriteCmd *.py write || :PymodeLint

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => C++
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
command! -nargs=0 Format :call CocAction('format')

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cris :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'inline-symbol', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>

autocmd FileType clojure set iskeyword-=/
" autocmd FileType clojure nnoremap <buffer> gd :normal [<c-d><cr>

let s:baleia = luaeval("require('baleia').setup { line_starts_at = 3 }")
autocmd BufWinEnter conjure-log-* call s:baleia.automatically(bufnr('%'))


" let g:conjure#filetype#fennel = "conjure.client.fennel.stdio"
" let g:conjure#client#fennel#stdio#command = "websocat --protocol bus.sp.nanomsg.org ws://192.168.1.14:5555"
" let g:conjure#client#fennel#aniseed#aniseed_module_prefix = "aniseed."
" let g:conjure#client#fennel#stdio#command = "love ."
" let g:conjure#client#fennel#stdio#prompt_pattern = "\n"


let g:conjure#log#strip_ansi_escape_sequences_line_limit= 0
let g:conjure#log#jump_to_latest#enabled = v:false
let g:conjure#log#jump_to_latest#cursor_scroll_position="top"
" let g:conjure#log#fold#enabled=0
let g:conjure#log#wrap=1

" let g:conjure#client#clojure#nrepl#completion#with_context = v:true
let g:conjure#client#clojure#nrepl#test#current_form_names = ["defspec", "deftest", "defflow", "defflow-wrapped", "wrapped-defflow"]
let g:conjure#client#clojure#nrepl#connection#auto_repl#enabled = v:false
" let g:conjure#debug = v:true

" let g:conjure#log#fold#marker#start="{{{"
" let g:conjure#log#fold#marker#end="}}}"
let g:conjure#log#hud#enabled=0
let g:conjure#mapping#doc_word="K"

let g:conjure_log_direction = "horizontal"
let g:conjure_log_blacklist = ["up", "ret", "ret-multiline", "load-file", "eval"]

noremap <F4> :ConjureLogToggle<CR>
noremap <C-Space> :ConjureEvalFile<CR>


function! ClerkShow()
  " save file changes
  exe "w"
  exe "ConjureEval (nextjournal.clerk/show! \"" . expand("%:p") . "\")"
endfunction

nmap <silent> <localleader>cs :call ClerkShow()<CR>

let g:aniseed#env = v:true


set lispwords+=against-background,fact,facts,future-fact,future-facts

function! SearchClojureWord()
  exe "set iskeyword-=/"
  let var = expand("<cword>")
  exe "set iskeyword+=/"
  return "".var.""
endfunction
" nnoremap * :execute "/" . SearchClojureWord()<CR>

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

" remap jj to escape :terminal mode
if has('nvim')
  tnoremap jj <C-\><C-n>
  tnoremap <Esc> <C-\><C-n>
endif

source $HOME/.vim/conf/treesitter.vim
set completeopt=menu,menuone,noselect
source $HOME/.vim/conf/cmp.vim
