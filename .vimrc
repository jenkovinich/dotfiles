" .vimrc file

" General Settings "

let skip_defualts_vim = 1       " ignores the defaults.vim file

set mouse=a                     " makes the mouse work
filetype on                     " enables type file detection

" tab behavior for different file formats
autocmd FileType robot,makefile setlocal shiftwidth=8 softtabstop=8 tabstop=8 noexpandtab
autocmd FileType c,cpp setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 noexpandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

set expandtab                   " use space characters instead of tabs
"set wrap			" wrap lines
set textwidth=80                " no line can be longer than 80 characters

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
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set showmatch                   " show matching brackets when text indicator is over them
" set relativenumber		" have relative numbers for the line numbers

" Status Line Settings "

set laststatus=2        " always show the status line

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

" Change Leader from \ to ,
let mapleader = ","

" Support List Chars "
set listchars=eol:¬,trail:·,tab:▸·
nmap <leader>lc :set invlist<cr>

" NERDTree Plugin Mapping
nnoremap <C-n> :NERDTree<CR>

" lightline Plugin
" remove --INSERT-- line
set noshowmode

" colorscheme and add git branch plugin
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

set t_Co=256
set background=dark
colorscheme PaperColor

" Colour Settings "

syntax enable			" enables syntax highlighting
set number			" add numbers to each line on the left hand side
set cursorline                  " highlight cursor line underneath the cursor horizontally
set cursorcolumn                " highlight cursor line underneath the cursor vertically

packadd YouCompleteMe
packloadall
let NERDTreeShowHidden=1
