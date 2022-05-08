# vimrc
## Key principles
- There are multiple files that reference one another. `common.vim` is used in all programs that have vim-emulators (ideavim, qt fakevim, ...) including NVIM itself, hence, there are no plugins nor functions.
- These vimrc files are optimized for my keyboard layout. Although it's still qwerty (almost), it is very different form the vast majority of keyboard layouts in every aspect. E.g. Esc, Enter, Backspace, Arrows are pressed without moving your fingers out of the homerow. Please see [rog-redblue-keyboard-layout](https://github.com/Roman-/rog-redblue-keyboard-layout)
- Out of the box, VIM keybindings are mnemonic-driven: w for word, s for substitute etc. My vimrc tends to be efficiency-driven.
- There are four arrows: left, down, up, right. Meanwhile, on your right hand there are (hopfully) four fingers that are resting on the homerow: index, middle, ring and pinky. They are rested on these four keys: J, K, L, ;. Do you see where I'm going with that? `jkl;` is superior to `hjkl`.
- Repeatitive keypresses (yy, dd) are aweful. They're replaced with ds, ys.
- Optimized text objects: change-in-parentheses is done by `c(`, not `ci(`. `w` for "in-word", `q` for "in-WORD", e.g. `cq` will change-in-WORD. There are lots of examples like this in common.vim.
