" .vimrc for terminal vim
source /home/lo/.vimrc_rus_maps
source /home/lo/.vimrc_common_noplugin
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set viewoptions-=options
syntax on
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | endif

noremap ) :bn<CR>
noremap ( :bp<CR>
" noremap ] :bn<CR>
" noremap [ :bp<CR>
" ...and to avoid delays, unmap brackets when entering buffers
augroup unmap_brackets
autocmd!
    autocmd BufWinEnter,BufNewFile * call UnmapBrackets()
augroup END

function! UnmapBrackets()
    silent! unmap <buffer> [[
    silent! unmap <buffer> ["
    silent! unmap <buffer> []
    silent! unmap <buffer> ][
    silent! unmap <buffer> ]"
    silent! unmap <buffer> ]]
endfun

"test https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
function! HandleURL()
  let s:uri = matchstr(getline("."), 'https\?:\/\/[^ >,;]*')
  echo s:uri
  if s:uri != ""
    silent exec "!google-chrome \"".s:uri."\" &> /dev/null"
    exec "redraw!"
  else
    norm! gf
    " echo 'No URI found in line.'
  endif
endfunction
nnoremap gf :call HandleURL()<cr>


" set cursorline
"hi Normal ctermfg=white ctermbg=black
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


" terminal-vim specific
nmap <c-g> :echom expand('%:p')<Enter>

"{{{ My Esc button is swapped with the CAPS LOCK btn on the OS level. Reasoning: http://vim.wikia.com/wiki/Avoid_the_escape_key
nnoremap <space><esc> :noh<Enter>:echom ""<Enter>
nnoremap <tab> :noh<Enter>:echom "Use your CAPS LOCK btn"<Enter>
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
" C-S-t opens recently closed tab in browser; however, we should enforce good habits
nnoremap <c-s-t> :echom "use c-o to open recently closed tab"<Enter>
set hidden " allow to switch tabs when buffer is modified
function! CloseBuffer()
    if (&mod == 1)
        echom 'file has unsaved changes'
        return -1
    endif
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        bd
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
        bd!
        quit
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

" insert log("") like depending on file extention
function! Insert_Log()
  " Switch editing between .c* and .h* files (and more).
  " Since .h file can be in a different dir, call find.
  let l:filename = expand("%")
  if match(l:filename,'\.cpp') > 0 || match(l:filename,'\.c') > 0 || match(l:filename,'\.h') > 0
      exe "normal! iLOG_DEBUG(\"\");\<esc>hi"
  elseif match(l:filename,'\.js') > 0
      exe "normal! iconsole.log(\"\");\<esc>hi"
  elseif match(l:filename,'\.php') > 0
      exe "normal! iLOG_INFO(\"\");\<esc>hi"
  elseif match(l:filename,'\.java') > 0
      exe "normal! iLog.d(\"\");\<esc>hi"
  else
      exe "normal! iLOG(\"\");\<esc>hi"
  endif
endfun

imap <c-g> <C-o>:call Insert_Log()<CR>

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
nmap <space>H o<Esc>141a_<Esc>75hR

"inoremap  
"set cpt=.
set complete-=i
let g:netrw_lifestyle=3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" Ack
let g:ackprg = 'ag --vimgrep'
"tests
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" web: launch chrome
command! I !google-chrome --allow-file-access-from-files --allow-file-access index.html

"shortcuts for coding

" insert "for" construction
nnoremap <space>f ofor (size_t i = 0; i < N; ++i)<Esc>FNs
nnoremap co ostd::cout << N << std::endl;<Esc>FNs
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
