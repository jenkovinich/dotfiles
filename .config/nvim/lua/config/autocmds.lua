local function set_indent(pattern, opts)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = pattern,
    callback = function()
      for key, value in pairs(opts) do
        vim.opt_local[key] = value
      end
    end,
  })
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.robot",
  callback = function()
    vim.bo.filetype = "robot"
  end,
})

set_indent("robot", {
  shiftwidth = 8,
  softtabstop = 8,
  tabstop = 8,
  expandtab = false,
})

set_indent("make", {
  shiftwidth = 4,
  softtabstop = 4,
  tabstop = 4,
  expandtab = false,
})

set_indent({ "c", "cpp" }, {
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
})

set_indent("python", {
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
})

set_indent("html", {
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
})

set_indent("markdown", {
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = false,
})

set_indent("yaml", {
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
})

set_indent({ "json", "lua" }, {
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "yaml", "sh" },
  callback = function()
    vim.opt_local.commentstring = "# %s"
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
