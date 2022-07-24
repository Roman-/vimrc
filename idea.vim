" idea-ported plugins: https://github.com/JetBrains/ideavim/wiki/Emulated-plugins
" commands/actions: https://github.com/JetBrains/intellij-community/blob/master/platform/platform-resources-en/src/messages/ActionsBundle.properties
Plug 'machakann/vim-highlightedyank'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kana/vim-textobj-entire'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/argtextobj.vim'
" Plug 'tpope/vim-surround'
let g:highlightedyank_highlight_duration = "100"

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
nmap yn <Action>(CopyFileName)
nmap yd <Action>(CopyAbsolutePath)

" this works, but kinda wanna edit configurations and make "build" cmd as well
nmap <space>j <Action>(Run)
nmap <c-s-j>  <Action>(Run)
nmap <space>J <Action>(RunConfiguration)
nmap £ <Action>(GotoAction)
nmap <space>R <Action>(Refactorings.QuickListPopupAction)
nmap <space>r <Action>(RenameElement)
nmap zi <Action>(CloseAllEditorsButActive)
nmap zw <Action>(CloseAllUnpinnedViews)

" navigation
nmap go <Action>(Back)
nmap gO <Action>(Forward)
nmap gu <Action>(VcsShowPrevChangeMarker)
nmap gm <Action>(VcsShowNextChangeMarker)
nmap ge <Action>(GotoNextError)
nmap gs <Action>(GotoDeclaration)
nmap gS <Action>(QuickImplementations)
nmap gh <Action>(GotoRelated)
nmap gH <Action>(TypeHierarchy)
" nmap <c-/> <Action>(CommentByLineComment)
" xmap <c-/> <Action>(CommentByBlockComment)

nmap <space>f <Action>(GotoFile)
nmap <space>h <Action>(RecentFiles)
nmap <space>a <Action>(FindInPath)
nmap <space>o <Action>($LRU)
nmap <space>O <Action>(OpenFile)

" arg-text-object
nmap d, daa
nmap y, mXyia`X
nmap c, cia

" imitate yank-assassin (yanking without moving cursor) for text-objects
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
