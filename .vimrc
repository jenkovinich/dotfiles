" .vimrc file

let skip_defualts_vim = 1   " ignores the defaults.vim file

" General Settings
syntax on		    " enables syntax highlighting
set number		    " add numbers to each line on the left hand side
set t_Co=256        " 256 colours
colorscheme elflord	" set the color of vim
set cursorline		" highlight cursor line underneath the cursor horizontally
set cursorcolumn	" highlight cursor line underneath the cursor vertically
":highlight CursorLine ctermbg=white

set mouse=a		    " makes the mouse work
filetype on 		" enables type file detection
" Status Line Settings "

set laststatus=2				" always show the status line

" functions to show the git branch that you're on
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" create a colour scheme for the status line
highlight SLLetters ctermfg=White

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %F\ %m
set statusline+=%=
set statusline+=Line:\ %l\ \ Column:\ %c\ %p%%
" set statusline+=%r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c\ %p%%
