" .vimrc file

" General Settings "

let skip_defualts_vim = 1       " ignores the defaults.vim file

set mouse=a                     " makes the mouse work
filetype on                     " enables type file detection

" tab behavior for different file formats
autocmd FileType robot setlocal shiftwidth=8 softtabstop=8 tabstop=8 noexpandtab
autocmd FileType c,cpp setlocal shiftwidth=8 softtabstop=8 tabstop=8 noexpandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 noexpandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

set expandtab                   " use space characters instead of tabs
"set wrap			" wrap lines
" set textwidth=70              " no line can be longer than 70 characters

set ignorecase                  " ignore capital letters during a search
set smartcase                   " override the ignorecase when searching specifically for capital letters
set hlsearch                    " use highlighting when doing a search
set incsearch                   " makes search act like search in modern browsers
set history=1000                " set the commands to save in history (default is 20)

set wildmenu                    " enable autocompletion after pressing tab
set wildmode=list:longest       " more like bash completion

set ruler                       " always show current position
set cmdheight=1                 " height of command bar

" set backspace so it acts like it should
"set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

set showmatch                   " show matching brackets when text indicator is over them
" set relativenumber		" have relative numbers for the line numbers

" Colour Settings "

syntax enable			" enables syntax highlighting
set number			" add numbers to each line on the left hand side
set t_Co=256                    " 256 colours
colorscheme elflord             " set the color of vim
set cursorline                  " highlight cursor line underneath the cursor horizontally
"hi CursorLine cterm=none ctermbg=grey ctermfg=black
hi CursorLine gui=underline cterm=underline
set cursorcolumn                " highlight cursor line underneath the cursor vertically
"hi CursorColumn cterm=none ctermbg=grey ctermfg=black
hi CursorColumn cterm=none ctermbg=red
hi Visual ctermbg=red

" Status Line Settings "

set laststatus=2				" always show the status line

" functions to show the git branch that you're on
"function! GitBranch()
"  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"endfunction
"
"function! StatuslineGit()
"  let l:branchname = GitBranch()
"  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
"endfunction

" create a colour scheme for the status line
highlight SLLetters ctermfg=White

set statusline=
"set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %F\ %m
set statusline+=%=
set statusline+=Line:\ %l\ \ Column:\ %c\ %p%%
" set statusline+=%r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c\ %p%%
