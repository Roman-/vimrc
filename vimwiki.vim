let g:sonokai_style = 'espresso'
let g:nv_search_paths = ['/home/lo/cloud/notes']

set shiftwidth=4 tabstop=4 smarttab expandtab
let g:vimwiki_conceallevel = 3
let g:vimwiki_autowriteall = 1
set concealcursor=n
set nocursorcolumn

" unmapping everything
let g:vimwiki_key_mappings = { 'global': 0, }

" omnicompletion chooses c-o
inoremap <c-o> <c-x><c-o>

nnoremap <silent> <S-Tab> :VimwikiPrevLink<cr>
nnoremap <silent> <Tab> :VimwikiNextLink<cr>
nnoremap zd :w<cr>:call TrashCurrentNote()<cr>
nnoremap zr :w<cr>:VimwikiRenameFile<cr>y<cr>
nnoremap zs :VimwikiGoto scratch<cr>ggVG"_s
nnoremap zn :VimwikiGoto 
" fix old _________header_________ syntax
nnoremap zf :%s/^_\{3,\}/# /g<cr>:%s/_\{3,\}$//g<cr>
autocmd FileType vimwiki nnoremap <silent><script><buffer> gs :VimwikiFollowLink<cr>
" resize window after start
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
" save buffers when switching between them
autocmd BufWinLeave * silent! w
nnoremap <c-l> "xciw[[<c-r>x]]<esc>f]l
inoremap <c-l> [[]]<left><left>
nnoremap zi :call CloseAllButIndex()<cr>

" diary: today and yesterday
nnoremap zt :VimwikiMakeDiaryNote<cr>
nnoremap zy :VimwikiMakeYesterdayDiaryNote<cr>

nmap zb :DisplayBacklinks<cr>
nnoremap zc o```cpp<cr><cr>```<up>

" use ripgrep to find backlinks for current note
function! GrepBacklinks(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --fixed-strings -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang DisplayBacklinks call GrepBacklinks("[[" . expand("%:t:r") . "]]", <bang>0)

function! CloseAllButIndex()
    wa
    edit /home/lo/cloud/notes/index.md
    call DeleteHiddenBuffers()
endfunction

" Delete Hidden buffer, usefull to clean. Stolen from https://stackoverflow.com/a/8459043/2544873
function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction

" Move current file to trash
function TrashCurrentNote()
  w
  let val = input('Move "'.expand('%').' to trash? " [y]es/[N]o? ')
  if val !~? '^y'
    return
  endif
  let fname = expand('%:p')

  sav! /tmp/deleted_note.md
  "!rm #
  call delete(fname)
  "silent execute '!rm #'
  silent execute 'bwipeout' fname
  silent execute 'bd'

  " silent execute 'bwipeout'
  echomsg 'note moved to /tmp/deleted_note.md'
endfunction
