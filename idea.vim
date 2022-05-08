" idea-ported plugins
Plug 'machakann/vim-highlightedyank'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-entire'
Plug 'easymotion/vim-easymotion'
" Plug 'tpope/vim-surround'
let g:highlightedyank_highlight_duration = "100"

" easymotion
let mapleader="M"
set easymotion
map M <Plug>(easymotion-prefix)
map ' <Plug>(easymotion-w)

noremap ¢ 15;

"" Source my .vimrc (no plugins)
source /home/lo/cloud/coding/configs/vim/qwerty/common.vim
source /home/lo/cloud/coding/configs/vim/qwerty/cyrillic.vim

" Idea autocompletes random things so the behavior is different when do stuff like this:
nnoremap <space>[ o {<Enter><Esc>

" Consistent shortcuts: (Idea/Clion, web browsers, file browsers have these for tab switch)
" Those are remapped on BLUE+z/c on my keyboard
noremap <c-PageDown> gt
noremap <c-PageUp> gT
nunmap (
nunmap )

" get rid of the pesky bell: http://jason-stillwell.com/blog/2013/04/11/ideavim/
set visualbell
set noerrorbells

" because in my .vimrc it's handled differently
nnoremap <c-w> :bd<Enter>

" TODO transfer that to ideavimrc for php/js
inoremap <c-d> $("<div></div>")
inoremap <c-b> $("<button class='btn btn-primary'></button>")
imap <c-g> console.log("

" IDEA actions
nmap yp <Action>(CopyAbsolutePath)
" doesn't work??
" nmap gs <Action>(LightEditGotoOpenedFile)
nmap yc <Action>(CopyFileName)
nmap yd <Action>(CopyAbsolutePath)
" this works, but kinda wanna edit configurations and make "build" cmd as well
nmap <space>j <Action>(Run)
nmap <space>J <Action>(RunConfiguration)

nmap <c-s-j> <Action>(Run)
nmap <gu> <Action>(VcsShowPrevChangeMarker)
nmap <gm> <Action>(VcsShowNextChangeMarker)

nmap <space>f <Action>(GotoFile)
nmap <space>h <Action>(RecentFiles)
nmap <space>a <Action>(FindInPath)
nmap gs <Action>(GotoDeclaration)

" imitate yank-assassin (yanking without moving cursor)
nnoremap yw mXyiw`X
nnoremap yq mXyiW`X
nnoremap y( mXyi(`X
nnoremap y) mXya)`X
nnoremap y[ mXyi[`X
nnoremap y] mXya[`X
nnoremap y< mXyi<`X
nnoremap y> mXya<`X
nnoremap y{ mXyi{`X
nnoremap y} mXya{`X
nnoremap ys mXyy`X
nnoremap yh mX^yg_`X
nnoremap y" mXyi"`X
nnoremap y' mXyi'`X
nnoremap y` mXyi``X
