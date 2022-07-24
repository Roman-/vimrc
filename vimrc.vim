" .vimrc for terminal vim. Includes common.vim - most mappings/options are described there.
" This file is messy, maybe I'll tidy up one day. But remappings are at the end.

" plugins
filetype off                  " required (vundle)
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'machakann/vim-highlightedyank'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim' " search though: files, history (recently opened files), content (ag)
Plugin 'vimwiki/vimwiki'
Plugin 'sainnhe/sonokai'
Plugin 'svban/YankAssassin.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'neovim/nvim-lspconfig'
Plugin 'AndrewRadev/sideways.vim'
"Plugin 'karb94/neoscroll.nvim'
"Plugin 'glacambre/firenvim'
"Plugin 'easymotion/vim-easymotion' (hello, world)

 "All of your Plugins must be added before the following line
call vundle#end()            " required (vundle)
filetype plugin indent on    " required (vundle)

let g:sonokai_style = 'maia'
let g:sonokai_better_performance = 1
let g:airline_theme = 'sonokai'

" vimwiki-specific config
if expand("%:p") == "/home/lo/cloud/notes/index.md"
    source /home/lo/cloud/coding/configs/vim/qwerty/vimwiki.vim
endif
colorscheme sonokai

" allows to close netrw TODO google for it
let g:netrw_fastbrowse = 0

if has('termguicolors')
    set termguicolors
endif

source /home/lo/cloud/coding/configs/vim/qwerty/common.vim
source /home/lo/cloud/coding/configs/vim/qwerty/cyrillic.vim

"easymotion is awesome but IdeaVim doesn't have it :( Omit inconsistent navigation
"map M <Plug>(easymotion-prefix)
"map ' <Plug>(easymotion-w)

" surround
let g:surround_no_mappings = 1

" snipmate
let g:snipMate = { 'snippet_version' : 1 }
let g:snips_author = 'Roman Strakhov'

set path=.,,
autocmd BufWinLeave,BufWrite ?* silent! mkview
autocmd BufWinEnter ?* silent! loadview
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set viewoptions-=options

filetype plugin on " required for vimwiki

autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | endif
" remove line number margin for wide lines
set cpoptions+=n
" ...and to avoid delays, unmap brackets when entering buffers
augroup unmap_brackets
autocmd!
    autocmd BufWinEnter,BufNewFile * call UnmapBrackets()
augroup END

" these aren't needed as I don't use brackets anymore
function! UnmapBrackets()
    silent! unmap <buffer> [[
    silent! unmap <buffer> ["
    silent! unmap <buffer> []
    silent! unmap <buffer> ][
    silent! unmap <buffer> ]"
    silent! unmap <buffer> ]]
endfun

set tags=./tags,tags;$HOME
set wildignore+=**/_deps/**

function! MakeTags()
    silent exec "!ctags -R --exclude=*.min.js --exclude=build ."
    redraw!
    echom 'Tags made     >^.^<   '
endfun
nmap T :call MakeTags()<CR>

nnoremap <c-g> :echom expand('%:p')<Enter>
" execute current bash script
nnoremap <F9> :w<Enter>:!%:p<Enter>

" add braces
set hidden " allow to switch tabs when buffer is modified
function! CloseBuffer()
    if (&mod == 1)
        if (&ft=='vimwiki')
            w
        else
            echom 'file has unsaved changes'
            return -1
        endif
    endif
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if expand("%:p:h") == "/home/lo/cloud/notes"
            edit /home/lo/cloud/notes/index.md
            " delete all buffers, edit last buffer, delete [no name] buffer
            %bd|e#|bd#
        else
            bd
            quit
        endif
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

" Delete current file to trash
function MoveToTrash()
  w
  let val = input('Move "'.expand('%').' to trash? " [y]es/[N]o? ')
  if val !~? '^y'
    return
  endif
  let fname = expand('%:p')

  sav! /tmp/deleted_buffer.txt
  "!rm #
  call delete(fname)
  "silent execute '!rm #'
  silent execute 'bwipeout' fname
  silent execute 'bd'

  " silent execute 'bwipeout'
  echomsg 'note moved to /tmp/deleted_buffer.txt'
endfunction

" dealing with hard line breaks
nnoremap <expr> k v:count ? 'j' : 'g<down>'
nnoremap <expr> l v:count ? 'k' : 'g<up>'
map K 5k
map L 5l

noremap <C-w> :call CloseBuffer()<Enter>
noremap zw :call CloseBuffer()<cr>:call CloseBuffer()<cr>:call CloseBuffer()<cr>:call CloseBuffer()<cr>:call CloseBuffer()<cr>:call CloseBuffer()<cr>
" TODO probably here's the command you're looking for: %bd|e#|bd#
" noremap z+ :wa<cr>:%bd<cr>:call SaveAndCloseBuffer()<cr>
noremap + :call SaveAndCloseBuffer()<Enter>
" noremap <c-s-w> :call SaveAndCloseBuffer()<Enter>
noremap z+ :silent! wa<cr>:qa!<cr>
nnoremap zq :call DiscardAndQuit()<Enter>
nnoremap zd :w<cr>:call MoveToTrash()<cr>

if has('persistent_undo')
    set undofile
    set undolevels=100          " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    set undodir=$HOME/.vim/undo
endif

let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#buffer_min_count = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#default#layout = [ [ 'a', 'b', 'c' ], [ 'x', 'y', 'z', 'error' ] ]
let g:airline_section_y=''
let g:airline_experimental=1
" let g:airline_section_x=''

source /home/lo/cloud/coding/configs/vim/qwerty/cpp.vim
let g:vimwiki_list = [{'path': '/home/lo/cloud/notes',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" machakann/vim-highlightedyank
let g:highlightedyank_highlight_duration = 100
set conceallevel=2

augroup bufclosetrack
  au!
  autocmd BufWinLeave * let g:lastWinName = @%
augroup END
function! LastWindow()
  exe "find " . g:lastWinName
endfunction
" command -nargs=0 LastWindow call LastWindow()
" C-S-t opens recently closed tab in browser; keeping consistent behavior. Unfortunately, vim only processes it as c-t
nnoremap <c-s-t> :call LastWindow()<cr>
nnoremap <c-t> :call LastWindow()<cr>

" Consistent shortcuts: (Idea/Clion, web browsers, file browsers have these for tab switch)
" Those are remapped on BLUE+z/c on my keyboard
noremap <c-PageDown> :bn<CR>
noremap <c-PageUp> :bp<CR>

" TODO I haven't explored all the capabilities of surround yet - do it later
nmap do  <Plug>Dsurround
nmap co  <Plug>Csurround
nmap cO  <Plug>CSurround
nmap yo  <Plug>Ysurround
xmap O   <Plug>VSurround
nmap <space>o yoiw
nmap <space>O yoiW
" arg-text-object
nnoremap d, d<Plug>SidewaysArgumentTextobjA
nnoremap y, y<Plug>SidewaysArgumentTextobjI
nnoremap c, c<Plug>SidewaysArgumentTextobjI

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set nojoinspaces
:au InsertEnter * set nolist
:au InsertLeave * set list

" web: launch chrome
command! I !google-chrome --allow-file-access-from-files --allow-file-access index.html
" H for help, launch in fullscreen
command! -nargs=1 -complete=help H help <args> | silent only

"shortcuts for coding (work-in-progress)
inoremap <c-d> $("<div>")
inoremap <c-b> $("<button class='btn btn-primary'>")
inoremap <c-f> function 

" fzf shortcuts
nnoremap <space> <nop>
nnoremap <Space>a :Ag<cr>
nnoremap <Space>A :Ag <c-r><c-w><cr>
nmap <Space>f :Files %:p:h<cr>
nmap <space>h :History<cr>
noremap <c-r> :History:<cr>
noremap <space>: :History:<cr>
noremap £ :Lines<cr>

nmap <Space>c :cclose<CR>:tabc<CR>

" misc
hi link markdownError Normal
nnoremap <c-s> :source $MYVIMRC<cr>

