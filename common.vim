" common .vimrc to be included in all .vimrcs (Terminal Vim, Qt Fakevim, IdeaVIM)
filetype plugin indent on
syntax on
" line numbers on the left
set number
set relativenumber
set nocompatible
set ignorecase
set incsearch
set hlsearch
set shiftwidth=4 tabstop=4 softtabstop=4 smarttab expandtab
" insert from system clipboard
set clipboard^=unnamed,unnamedplus
set viewoptions-=options
set cpoptions+=n
" cursor line and column -> sniper scope
set cursorline
set cursorcolumn
set copyindent
" never enable foldings
set nofoldenable

" My Esc button is swapped with the CAPS LOCK btn on the OS level. Reasoning: http://vim.wikia.com/wiki/Avoid_the_escape_key
nnoremap <silent> <space><esc> :noh<cr>
nnoremap <silent> <tab> :noh<cr>
nnoremap <esc> zz

" jkl; instead of hjkl
noremap j h
noremap k j
noremap l k
noremap ; l

map J 15j
map K 5k
map L 5l
map ¢ 15;
map <c-j> 5j
map <c-;> 5;

" delete/change two symbols
nnoremap dj vhd
nnoremap dk dj
nnoremap dl dk
nnoremap d; vld
nnoremap cj vhc
nnoremap ck cj
nnoremap cl dk
nnoremap c; vlc

" positioning
noremap <Up> zbkj
noremap <Down> ztkj
noremap <Left> ^
noremap <Right> $
xnoremap <Right> g_
noremap <Home> I
noremap <End> A
" RED+BLUE+jkl; act like ctrl+arrows. You can use them to navigate between words and guarantee that c-left will go to prev word rather then beginning of current word
noremap <c-left> ge
noremap <c-right> w
noremap <c-s-left> gE
noremap <c-s-right> W

" consistent pageUp/Down behavior and scroll
noremap <PageDown> <c-f>
noremap <PageUp> <c-b>

" Consistently "delete prev word": mapping Ctrl-Backspace does not work in terminal Vim. Following is a workaround.
imap <C-w> <Nop>
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" random key mappings go there
" escape to normal mode and then switch tabs
imap <c-PageDown> <esc><c-PageDown>
imap <c-PageUp> <esc><c-PageUp>
" u for undo, U for redo
nnoremap U <C-r>
" on Rog redblue keyboard, RED+w = plus
nmap + :wq<Enter>
" Enter to insert a new line but stay in normal mode
nnoremap <Return> o<Esc>
" J used to be for join - changing to zj
nnoremap zj mz:join<Enter>`z
" m for macro
nnoremap <space>m q
" enter block visual mode with vv
xnoremap v <c-v>
" copy
xnoremap <C-c> y
" enter special symbols with control-C
inoremap <C-c> <C-v>
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
" paste-below-newline, paste-above
" this doesn't work?
" nnoremap <silent> <c-v> o<C-r>+<esc>
nnoremap <silent> <space>p :set paste<cr>o<C-r>+<esc>:set nopaste<cr>
nnoremap <silent> <space>P :set paste<cr>O<C-r>+<esc>:set nopaste<cr>
nnoremap <space>s :w<Enter>
nnoremap <space>S :wa<Enter>

nnoremap Q ciW
nnoremap q ciw

" avoid repeatitive keypress
noremap ga gg
nnoremap gs <c-]>
noremap go <c-o>
noremap gO <c-i>
noremap g- ^W
" duplicate line but preserve cursor position and the clipboard
nnoremap <space>y mX"9yy"9p`Xj
nnoremap <space>Y mX"9yy"9P`Xk

" habit-breakers
nmap A <nop>
nmap I <nop>
nnoremap gg :echom "use ga instead"<Enter>
nnoremap dd :echom "use ds instead"<Enter>
nnoremap yy :echom "use ys instead"<Enter>
noremap <c-o> :echom "use go instead"<Enter>

" cpp-related
" space + ; = append ';' to the end of the line
nnoremap <space>; mXA;<Esc>`X
nnoremap <space>. mXA.<Esc>`X
" space + / = append comment to the current line
nnoremap <space>/ A // 
" ctrl + / = comment current line. Override in IDEs
nnoremap <c-/> mXI// <Esc>`X
xnoremap <c-/> mX:s/^/\/\/ /g<Enter>`X:noh<Enter>
" duplicate current line and comment it for fast change - TODO
nnoremap <C-w> :q<cr>

" surround selected with quotes or spaces TODO combine better with vim-surround plugin
nmap z<Space> i <Esc>;a <Esc>h
xmap z<Space> "tdi t <Esc>
xmap z" "tdi"t"<Esc>
xmap z' "tdi't'<Esc>
xmap z< "tdi<t><Esc>

" = to fix current line indent
nnoremap = V=
" single tap
nnoremap < <<
nnoremap > >>
" Keep a block highlighted while shifting
xnoremap < <gv
xnoremap > >gv

" brackets
noremap ) }
noremap ( {
noremap { [{
noremap } ]}
" marks
nnoremap gk ]`
nnoremap gl [`
nnoremap `<Delete> :delmarks!<cr>
nnoremap '<Delete> :delmarks!<cr>

" forward/backward find symbol
noremap - ;
noremap – ,

" The following 4 blocks simulates custom text objects: #, -, /, =

" yank/copy
" yank line (with newline) - avoid double-tapping yy
nnoremap ys yy
" yank soft line (without newline)
nnoremap yh mX^vg_y`X
" yank path (copy current filename to clipboard)
nnoremap yp :let @+=expand("%:p")<CR>:echom expand("%:p")<CR>
" yank dir (copy current file directory to clipboard)
nnoremap yd :let @+=expand("%:p:h")<CR>:echom expand("%:p:h")<CR>
" yank filename without extension
nnoremap yn :let @+=expand("%:t:r")<CR>:echom expand("%:t:r")<CR>
" yank to the end of the line
nnoremap Y yg_
" yank the comment
nnoremap y/ mX$2F/wyg_`X
" yank the hash comment or header
nnoremap y# mX$F#wyg_`X
" yank list item/header, i.e. anything that starts with 2nd word in soft line
nnoremap y- mX^Wyg_`X
" yank right side of the assignment
nnoremap y= mX^f=wy$`X
" yank ClassName:: with two colons
nnoremap y: y2f:

" replace-with-register but preserve the cursor position
nmap h gr
xmap h gr
nmap hs mXgrr`X
nmap hh mX^gr$`X
nmap h- mX^Wgr$`X
nmap h# mX$F#wgr$`X
nmap h= mX^f=wgr$`X
nmap h/ mX$F/wgr$`X

" delete but preserve the cursor position
" ds to delete the line (avoid repetitive keypresses)
nnoremap ds mXdd`X
" delete line, but only keep 'soft line' in register
nnoremap dh mX^vg_y"_dd`X
nnoremap d/ mX$2F/gel"9D`X
nnoremap d- mX^WD"_x`X
nnoremap d# mX$F#wD`X
nnoremap d= mX^f=wD`X
" a-la argument text object (replaed with Sideways pluging mappings in vimrc)
nnoremap d, F,dt,
nnoremap d. das
nnoremap d: d2f:

" change
" change-after-equal-sign
nnoremap c= ^f=wC
" change-comment
nnoremap c/ $F/wC
" change-hash-comment (or header)
nnoremap c# $F#wC
" change list item / header (anything starting with 2nd word in soft line)
nnoremap c- ^WC
" change-in-word is an extremely common action; use q for it

" better text objects
onoremap ( i(
onoremap ) a(
onoremap [ i[
onoremap ] a[
onoremap < i<
onoremap > a<
onoremap { i{
onoremap } a{
onoremap ' i'
onoremap ¤ a'
onoremap " i"
onoremap ` i`
onoremap w iw
onoremap q iW
xnoremap q iW
" character text object
onoremap c l
" ... except when I delete word, I usually want to delete A word
nnoremap dw daw
nnoremap dq daW
" ... and the Entire text object
omap u ae
xmap u ae
nmap yu yie
" delete in blackhole
xnoremap <c-x> "_d
nnoremap <c-x> "_diw
