autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
set relativenumber
set number
:syntax on
set nocompatible

"set mouse=a
set foldmethod=marker
set foldlevelstart=20
hi Folded ctermbg=234 ctermfg=94
hi CursorLineNr cterm=bold ctermfg=226
set cursorline
hi CursorLine cterm=NONE ctermbg=234 guibg=235
hi Comment ctermfg=120
hi Search ctermfg=3

set ignorecase
set incsearch
set hlsearch

set smartindent
set shiftwidth=4 smarttab expandtab

set path+=**
set tags=./tags,tags;$HOME

set clipboard^=unnamed,unnamedplus

" shoudn't it be by default?
nmap dl vld
nmap dh vhd
nmap cl vlc
nmap ch vhc
nmap yl vly
nmap yh vhy
nmap <c-g> :echom expand('%:p')<Enter>

" vim niceties 

"{{{escaping to the normal mode with Tab.
" See there why this takes place: http://vim.wikia.com/wiki/Avoid_the_escape_key
vnoremap <tab> <esc>
inoremap <tab> <esc>
inoremap <S-tab> <space><space><space><space>
nmap <tab> :noh<Enter>:echom ""<Enter>
nnoremap r<tab> <nop>
"}}}

" positioning
nmap <space> <nop>
noremap <space>u zbkj
noremap <space>d ztkj
noremap <space><space> zz

" u for undo, U for redo
nnoremap U <C-r>

"{{{hjkl navigation
noremap J 5j
noremap K 5k
noremap H 15h
noremap L 15l
noremap <c-h> 5h
noremap <c-l> 5l
noremap <space>h ^
noremap <space>l $
"}}}
"{{{ making habitual hotkeys work in vim
nnoremap <C-a> ggVG
nnoremap <space>s :w<Enter>
"nnoremap <BS> X
"nnoremap <CR> o
"}}}
"{{{ copy / paste paste

" copy
nnoremap <C-c> myyiw`y
vnoremap <C-c> y
vnoremap <C-x> "0d
" enter special symbols with control-C
inoremap <C-c> <C-v>

" paste: <C-V> always puts things that were YANKED, not deleted;
inoremap <C-v> <C-r>0
nnoremap <C-v> i<C-r>0
vnoremap <C-v> c<C-r>0
" change-in-word is an extremely common action; use q for it
nnoremap q ciw
nnoremap Q daw
vnoremap q c
nnoremap <space>w ciw<C-r>0
nnoremap <space>q mXyiw`X
" ...and space-m for macro
nnoremap <space>m q
"}}}
"{{{ cpp-related
" space + ; = append ';' to the end of the line
nnoremap <space>; msA;`s
" <C-j> for ignoring input in FakeVim
nnoremap <C-j> ,
" when the cursor is on the word, add #include directive with that word on space + i
nnoremap <space>i miyiw?#include<Enter>o#include <pa>`ik$/<C-r>0<Enter>zh
" insert for construction
nnoremap <space>f afor (int i = 0; i < N; ++i)FNs
" insert extended if-else construction with brackets
nnoremap <space>e aif (N)o{o}oelseo{o}?N<Enter>s
" space-[ for opening braces
nnoremap <space>[ A {o}O
" replace 'Abc' with 'const Abc&'
nnoremap <space>c diwiconst pa&
" add braces
"}}}
"{{{ working with buffers
noremap <space>k :bn<CR>
noremap <space>j :bp<CR>
set hidden " allow to switch tabs when buffer is modified
function! CloseBuffer()
    if (&mod == 1)
        echom 'file has unsaved changes'
        return -1
    endif
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        quit
    else
        bd
    endif
endfunction

function! SaveAndCloseBuffer()
    if (&mod == 1)
        write
    endif
    :call CloseBuffer()
endfunction

function! DiscardAndQuit()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        quit!
    else
        bd!
    endif
endfunction

noremap <C-w> :call CloseBuffer()<Enter>
noremap <C-d> :call CloseBuffer()<Enter>
noremap <S-w> :call SaveAndCloseBuffer()<Enter>
nnoremap ZQ :call DiscardAndQuit()<Enter>
"}}}

if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=100          " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    set undodir=/tmp
endif

"{{{ airline
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"}}}
"{{{ vundle
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'vim-airline/vim-airline'
Plugin 'https://github.com/lyokha/vim-xkbswitch'

 "All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"}}}

" Qt-ish ctrl+k to navigate
nmap <c-k> :find 

" TODO deal with .c and .cpp
function! Mosh_Flip_Ext()
  " Switch editing between .c* and .h* files (and more).
  " Since .h file can be in a different dir, call find.
  if match(expand("%"),'\.cpp') > 0
    let s:flipname = substitute(expand("%"),'\.cpp\(.*\)','.h\1',"")
    if (filereadable(s:flipname))
        exe ":find " s:flipname
        return
    endif
    let s:flipname = substitute(expand("%"),'\.cpp\(.*\)','.hpp\1',"")
    if (filereadable(s:flipname))
        exe ":find " s:flipname
        return
    endif
  elseif match(expand("%"),"\\.hpp") > 0
    let s:flipname = substitute(expand("%"),'\.hpp\(.*\)','.cpp\1',"")
    if (filereadable(s:flipname))
        exe ":find " s:flipname
    endif
  elseif match(expand("%"),"\\.h") > 0
    let s:flipname = substitute(expand("%"),'\.h\(.*\)','.cpp\1',"")
    if (filereadable(s:flipname))
        exe ":find " s:flipname
    endif
  else
    echom 'file is not h(pp) or c(pp)'
  endif
endfun

map <c-y> :call Mosh_Flip_Ext()<CR>

" TODO follow symbol under cursor: gf, tag, gd
map <c-u> <c-]>

function! ChangeLoc()
    silent exec "!xdotool key ctrl+shift"
    redraw!
    echom 'layout changed'
endfun

" xkbswitch {{{
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']

nmap о :call ChangeLoc()<CR>j
nmap л :call ChangeLoc()<CR>k
nmap О :call ChangeLoc()<CR>J
nmap Л :call ChangeLoc()<CR>K
nmap ф :call ChangeLoc()<CR>a
nmap ш :call ChangeLoc()<CR>i
nmap Ф :call ChangeLoc()<CR>A
nmap Ш :call ChangeLoc()<CR>I
nmap а <c-f>
nmap в <c-f>
"}}}

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nojoinspaces
set pastetoggle=<F12>
:au InsertEnter * set nolist
:au InsertLeave * set list
