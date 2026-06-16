local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = {
    colorscheme = { "habamax" },
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    notify = false,
  },
})

local nvim_path = vim.fn.exepath(vim.v.progpath)
local nvim_prefix = vim.fn.fnamemodify(nvim_path ~= "" and nvim_path or vim.v.progpath, ":h:h")
local parser_runtime = nvim_prefix .. "/lib/nvim"
if vim.fn.isdirectory(parser_runtime) == 1 then
  -- Official Linux packages keep bundled Treesitter parsers outside the runtime tree.
  vim.opt.runtimepath:append(parser_runtime)
end
