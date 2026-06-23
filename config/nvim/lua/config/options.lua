local opt = vim.opt

vim.g.mapleader = ","
vim.g.maplocalleader = ","

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.textwidth = 80
opt.colorcolumn = "80"

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.history = 1000

opt.wildmenu = true
opt.wildmode = "list:longest"
opt.ruler = true
opt.cmdheight = 1
opt.confirm = true

opt.backspace = { "eol", "start", "indent" }
vim.cmd("set whichwrap+=<,>,h,l")

opt.showmatch = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"

opt.laststatus = 2
opt.showmode = false
opt.updatetime = 100
opt.timeoutlen = 400

opt.listchars = {
  trail = "·",
  tab = "▸·",
  extends = "»",
  precedes = "«",
}

opt.background = "dark"
opt.termguicolors = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.undofile = true
opt.swapfile = false

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

pcall(vim.cmd.colorscheme, "habamax")

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
