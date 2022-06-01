" vimrc file

let skip_defualts_vim = 1

" General Settings
syntax on		" enables syntax highlighting
set number		" add numbers to each line on the left hand side
colorscheme elflord	" set the color of vim
set cursorline		" highlight cursor line underneath the cursor horizontally
set cursorcolumn	" highlight cursor line underneath the cursor vertically
set mouse=a		" makes the mouse work

set textwidth=70	" no line can be longer than 70 characters

set ignorecase		" ignore capital letters during a search
set smartcase		" override the ignorecase when searching specifically for capital letters
set hlsearch		" use highlighting when doing a search
set history=1000	" set the commands to save in history (default is 20)

set wildmenu		" enable autocompletion after pressing tab
set wildmode=list:longest	" more like bash completion

" statusline
set statusline=		" clear status line when vim is reloaded
set statusline+=\ %F\ %M\ %Y\ %R	" status line left side
set statusline+=%=	" use a divider to separate the left side from the right side
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%


