set relativenumber 
set number
:syntax on
:hi Comment ctermfg=120
set path+=**
set nocompatible
set smartindent
set autoindent
set hlsearch
set shiftwidth=4 smarttab
set clipboard^=unnamed,unnamedplus
set timeout timeoutlen=700 ttimeoutlen=700

" vim niceties 

" escaping to the normal mode with Tab. See there why: http://vim.wikia.com/wiki/Avoid_the_escape_key
vnoremap <tab> <esc>
inoremap <tab> <esc>
inoremap <S-tab> <space><space><space><space>
nnoremap <tab> :noh<Enter>
" change-in-word is an extremely common action; use q for it
nnoremap q ciw
nnoremap Q <nop>
vnoremap q c
nnoremap <space>w ciw<C-r>0
nnoremap <space>q mXyiw`X
" ...and space-m for macro
nnoremap <space>m q

" positioning
noremap <space>u zbkj
noremap <space>d ztkj
noremap <space><space> zz

" u for undo, U for redo
nnoremap U <C-r>

" hjkl navigation
noremap J 5j
noremap K 5k
noremap H 15h
noremap L 15l
noremap <c-h> 5h
noremap <c-l> 5l
noremap <space>h ^
noremap <space>l $

" making habitual hotkeys work in vim
nnoremap <C-a> ggVG
nnoremap <C-w> :q<Enter>
" ctrl+d = signal eof = quit
nnoremap <C-d> :q<Enter>
nnoremap <space>s :w<Enter>
nnoremap <S-w> :wq<Enter>
inoremap <C-BS> vbc
noremap! <C-BS> db
nnoremap <BS> X
nnoremap <CR> o

" copy / paste paste

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
" enter special symbols with control-C
inoremap <C-c> <C-v>

" cpp-related

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
