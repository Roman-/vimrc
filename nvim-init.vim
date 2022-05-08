set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source /home/lo/cloud/coding/configs/vim/qwerty/vimrc.vim

let g:sonokai_style = 'maia'
let g:sonokai_better_performance = 1
let g:airline_theme = 'sonokai'

" vimwiki-specific config
if expand("%:p") == "/home/lo/cloud/notes/index.md"
    source /home/lo/cloud/coding/configs/vim/qwerty/vimwiki.vim
endif
colorscheme sonokai

