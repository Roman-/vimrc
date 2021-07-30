source /home/lo/.vimrc_rus_maps
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set viewoptions-=options
set relativenumber
set number
syntax on
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | endif
set nocompatible

" set cursorline
hi CursorLine cterm=NONE ctermbg=234
hi CursorLineNr cterm=bold ctermfg=226
hi Comment ctermfg=14
hi cTodo ctermbg=236
hi Search ctermfg=0 ctermbg=154
hi Visual ctermbg=214 ctermfg=0
" c and cpp keywords
hi cStorageClass ctermfg=11
hi cppStorageClass ctermfg=11
hi cStructure ctermfg=11
hi cppStructure ctermfg=11
hi cModifier ctermfg=11
hi cppModifier ctermfg=11
hi cStatement ctermfg=11
hi cppStatement ctermfg=11
hi cRepeat ctermfg=11
hi cppRepeat ctermfg=11
hi cConditional ctermfg=11
" values: red and pink
hi cNumber ctermfg=13
hi cFloat ctermfg=13
hi cppBoolean ctermfg=13
hi cString ctermfg=9
hi cSpecial ctermfg=1
hi cFormat ctermfg=166
hi cCharacter ctermfg=9
" other keywords
hi cType ctermfg=154
hi cppType ctermfg=154

set ignorecase
set incsearch
set hlsearch

set smartindent
set shiftwidth=4 tabstop=4 smarttab expandtab

set path=.,,
set path+=**
set tags=./tags,tags;$HOME
set wildignore+=**/_deps/**

function! MakeTags()
    silent exec "!ctags -R --exclude=*.min.js --exclude=build ."
    redraw!
    echom 'Tags made     >^.^<   '
endfun
nmap T :call MakeTags()<CR>

set clipboard^=unnamed,unnamedplus

" shoudn't it be by default?
nmap dl vld
nmap dh vhd
nmap cl vlc
nmap ch vhc
nmap yl vly
nmap yh vhy
nmap <c-g> :echom expand('%:p')<Enter>

"{{{ My Esc button is swapped with the CAPS LOCK btn on the OS level. Reasoning: http://vim.wikia.com/wiki/Avoid_the_escape_key
nnoremap <space><esc> :noh<Enter>:echom ""<Enter>
nnoremap <tab> :noh<Enter>:echom "Use your CAPS LOCK btn"<Enter>
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
noremap <space>H o<Esc>145a_<Esc>77hR
noremap <space>l $
" J used to be for join - gj
nnoremap zj mz:join<Enter>`z
inoremap <c-BS> <c-w>
"}}}
"{{{ making habitual hotkeys work in vim
nnoremap <C-a> ggVG
nnoremap <space>s :w<Enter>
nnoremap <space>S :wa<Enter>
"}}}
"{{{ copy / paste

" enter special symbols with control-C
inoremap <C-c> <C-v>

" paste: <C-V> always puts things that were YANKED, not deleted;
inoremap <C-v> <C-r>0
nnoremap <C-v> i<C-r>0
" non of these works. I guess what I should do is change behavior when paste over selected
" nnoremap p a<C-r>0
" vnoremap p "0p

" change-in-word is a very common action; use q for it
nnoremap q ciw
nnoremap Q daw
vnoremap q c
nnoremap <space>w ciw<C-r>0
nnoremap <space>q mXyiw`X
" ...and space-m for macro
nnoremap <space>m q
"}}}
"{{{ cpp- and js-related
" space + ; = append ';' to the end of the line
nnoremap <space>; msA;`s
nnoremap <space>. msA.`s
" space + / = comment current line
" map <C-/> :s:^\/\/<CR>
" nnoremap <C-/>/ msI// `sll
let CommentSymbol='//'
function! CommentUncomment()
    if match(getline('.'), "^\\s*//") != -1
        silent s:\/\/\s*::g
    else
        silent exe "norm moI// `o"
    endif
endfu
nnoremap <space>/ mp :call CommentUncomment()<CR>`p
" <C-j> for ignoring input in Qt FakeVim
nnoremap <C-j> ,
" duplicate current line and comment it for fast change
nnoremap <space>y "9yymo"9PI// `o
" when the cursor is on the word, add #include directive with that word on space + i
nnoremap <space>i miyiw?#include<Enter>o#include <pa>`ik$/<C-r>0<Enter>zh
" space-[ for opening braces
nnoremap <space>[ A {o}O
" replace 'Abc' with 'const Abc&'
nnoremap <space>C diwiconst pa&
" go from function declaration to definition: copy line, mark position, copy
nmap <space>] mt"lyy?class <CR>w"cyiw`t<c-y>Go<c-r>lk^f(bi<C-r>c:::s:^\s*:<CR>:noh<CR>$s {<CR>}O
" add braces
"}}}
"{{{ working with buffers
noremap <space>k :bn<CR>
noremap <space>j :bp<CR>
" this opens just closed tab just like in web browser
map <c-s-t> <c-o>
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
    set undodir=$HOME/.vim/undo
endif

"{{{ airline
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#default#layout = [ [ 'a', 'b', 'c' ], [ 'x', 'y', 'z', 'error' ] ]
let g:airline_section_y=''
let g:airline_section_x=''

"}}}
"{{{ vundle
filetype off                  " required (vundle)

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'vim-airline/vim-airline'
Plugin 'mileszs/ack.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'

 "All of your Plugins must be added before the following line
call vundle#end()            " required (vundle)
filetype plugin indent on    " required (vundle)
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
  elseif match(expand("%"),'\.c') > 0
    let s:flipname = substitute(expand("%"),'\.c\(.*\)','.h\1',"")
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
    else
        let s:flipnamec = substitute(expand("%"),'\.h\(.*\)','.c\1',"")
        if (filereadable(s:flipnamec))
            exe ":find " s:flipnamec
        endif
    endif
  else
    echom 'file is not h(pp) or c(pp)'
  endif
endfun

map <c-y> :call Mosh_Flip_Ext()<CR>

" tests l
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nojoinspaces
set pastetoggle=<F12>
:au InsertEnter * set nolist
:au InsertLeave * set list

"this is for the vimnotes
nmap zo o[ ] 
nmap z- o- 
nmap zO O[ ] 
nmap zm mz0lF[lrx<Esc>`z
nmap zu mz0lF[lr <Esc>`z

"inoremap  
"set cpt=.
set complete-=i
let g:netrw_lifestyle=3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" Ack
let g:ackprg = 'ag --vimgrep'
" noremap <esc> :cclose<Enter>:echom ""<Enter>
"tests
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"surround selected with quotes or something
nmap z<Space> i <Esc>la <Esc>h
vmap z<Space> "tdi t <Esc>
vmap z" "tdi"t"<Esc>
vmap z' "tdi't'<Esc>
vmap z< "tdi<t><Esc>

" web: launch chrome
command! I !google-chrome --allow-file-access-from-files --allow-file-access index.html

"shortcuts for coding

" insert "for" construction
nnoremap <space>f ofor (size_t i = 0; i < N; ++i)<Esc>FNs
nnoremap co ocout << N << endl;<Esc>FNs
" common JS funcs
inoremap <c-g> console.log("");<Esc>hhi
inoremap <c-f> function 
" jquery
inoremap <c-d> $("<div></div>")
inoremap <c-b> $("<button class='btn btn-primary'></button>")
nmap zq viw"tdi$("#t")<Esc>
imap <c-q> $("#");<Esc>hhi

"ack
nmap <Space>a :tab split<CR>:Ack ""<Left>
nmap <Space>A :tab split<CR>:Ack <C-r><C-w><CR>
nmap <Space>c :cclose<CR>:tabc<CR>

"build
nmap <Space>b :wa<CR>:!cd build && clear && cmake --build . -- -j4<CR>
