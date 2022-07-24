" messy experimental stuff that should work for cpp files
" when the cursor is on the word, add #include directive with that word on space + i
autocmd FileType c nnoremap <buffer> <space>i mXyiw?#include<Enter>o#include <<Esc>pa><Esc>`Xk$/<C-r>0<Enter>zh
autocmd FileType javascript inoremap <buffer> <c-f> function 

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

map gh :call Mosh_Flip_Ext()<CR>

" insert extended if-else construction with brackets
nnoremap <space>e aif (N)o{o}oelseo{o}?N<Enter>s
" space-[ for opening braces
nnoremap <space>[ A {o}O
" replace 'Abc' with 'const Abc&'
nnoremap <space>c diwiconst pa&

"{{{ cpp- and js-related
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
nnoremap <c-/> mp :call CommentUncomment()<CR>`p
" when the cursor is on the word, add #include directive with that word on space + i
nnoremap <space>i miyiw?#include<Enter>o#include <pa>`ik$/<C-r>0<Enter>zh
" space-[ for opening braces
nnoremap <space>[ A {o}O
" replace 'Abc' with 'const Abc&'
nnoremap <space>C diwiconst pa&
" go from function declaration to definition: copy line, mark position, copy
nmap <space>] mt"lyy?class <CR>w"cyiw`t<c-k>Go<c-r>lk^f(bi<C-r>c:::s:^\s*:<CR>:noh<CR>$s {<CR>}O
