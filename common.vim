" common .vimrc to be included in all .vimrcs (Terminal Vim, Qt Fakevim, IdeaVIM)
filetype plugin indent on
syntax on
set relativenumber
set number
set nocompatible
set ignorecase
set incsearch
set hlsearch
set shiftwidth=4 tabstop=4 shiftwidth=4 smarttab expandtab
set clipboard^=unnamed,unnamedplus
set viewoptions-=options
set cpoptions+=n
set cursorline
set cursorcolumn

" My Esc button is swapped with the CAPS LOCK btn on the OS level. Reasoning: http://vim.wikia.com/wiki/Avoid_the_escape_key
nnoremap <space><esc> :noh<cr>
nnoremap <tab> :noh<cr>
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
noremap cj vhc
noremap ck cj
noremap cl dk
noremap c; vlc

" positioning
noremap <Up> zbkj
noremap <Down> ztkj
noremap <Left> ^
noremap <Right> g_
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

" escape to normal mode and then switch tabs
imap <c-PageDown> <esc><c-PageDown>
imap <c-PageUp> <esc><c-PageUp>
" u for undo, U for redo
nnoremap U <C-r>
" on Rog redblue keyboard, RED+w = plus
nmap + :wq<Enter>
" = to fix current line indent
nnoremap = V=
" Enter to insert a new line but stay in normal mode
nnoremap <Return> o<Esc>
" J used to be for join - changing to zj
nnoremap zj mz:join<Enter>`z
" m for macro
nnoremap <space>m q
" enter block visual mode with vv
vnoremap v <c-v>
noremap go <c-o>
" copy
vnoremap <C-c> y
" enter special symbols with control-C
inoremap <C-c> <C-v>
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+

" paste-below-newline, paste-above
nnoremap <c-v> o<C-r>+<esc>
nnoremap <space>p o<C-r>+<esc>
nnoremap <space>P O<C-r>+<esc>
nnoremap <space>s :w<Enter>
nnoremap <space>S :wa<Enter>
" change-after-equal-sign
nnoremap c= ^f=wC
" change-comment
nnoremap c/ $F/wC
" change-hash-comment (or header)
nnoremap c# $F#wC
" change list item / header (anything starting with 2nd word in soft line)
nnoremap c- ^WC
" change-in-word is an extremely common action; use q for it
nnoremap Q ciW
nnoremap q ciw

" avoud repeatitive keypress
noremap ga gg
nnoremap gs <c-]>
" duplicate line but preserve cursor position and the clipboard
nnoremap <space>y mX"9yy"9p`Xj
nnoremap <space>Y mX"9yy"9P`Xk
" copy the comment
nnoremap y/ mX$2F/wyg_`X
" copy the hash comment or header
nnoremap y# mX$F#wyg_`X
" copy list item / header (anything starting with 2nd word in soft line)
nnoremap y- mX^Wyg_`X
" remove the comment
nnoremap d/ mX$2F/gel"9D`X

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
vnoremap <c-/> mX:s/^/\/\/ /g<Enter>`X:noh<Enter>
" duplicate current line and comment it for fast change - TODO
nnoremap <C-w> :q<cr>

" surround selected with quotes or spaces TODO combine better with vim-surround plugin
nmap z<Space> i <Esc>;a <Esc>h
vmap z<Space> "tdi t <Esc>
vmap z" "tdi"t"<Esc>
vmap z' "tdi't'<Esc>
vmap z< "tdi<t><Esc>

nnoremap < <<
nnoremap > >>

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

"              yanking
" yank soft line (without newline)
nnoremap yh mX^vg_y`X
" yank line (with newline) - avoid double-tapping yy
nnoremap ys yy
" yank path = copy current filename to clipboard
nnoremap yp :let @+=expand("%:p")<CR>:echom expand("%:p")<CR>
" yank dir = copy current file directory to clipboard
nnoremap yd :let @+=expand("%:p:h")<CR>:echom expand("%:p:h")<CR>
" yank filename without extension
nnoremap yn :let @+=expand("%:t:r")<CR>:echom expand("%:t:r")<CR>
" copy to the end of the line
nnoremap Y yg_

" replace-with-register
map h gr
nmap hs grr

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
vnoremap q iW
" ... except when I delete word, I usually want to delete A word
nnoremap dw daw
nnoremap dq daW
" ... and the Entire text object
omap u ae
vmap u ae
nmap yu yie
" ds to delete the line (avoid repetitive keypresses) and preserve cursor position
nnoremap ds mXdd`X
" delete line, but only keep 'soft line' in register
nnoremap dh mX^vg_y"_dd`X
" delete in blackhole
vnoremap <c-x> "_d
nnoremap <c-x> "_diw
