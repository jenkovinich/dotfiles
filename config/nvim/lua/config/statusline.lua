local M = {}

local severity = vim.diagnostic.severity

local function diagnostic_counts(bufnr)
  if vim.diagnostic.count then
    return vim.diagnostic.count(bufnr)
  end

  local counts = {}
  for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
    counts[diagnostic.severity] = (counts[diagnostic.severity] or 0) + 1
  end
  return counts
end

function M.git()
  local branch = vim.b.gitsigns_head
  if not branch or branch == "" then
    return ""
  end
  return " " .. branch
end

function M.diagnostics()
  local counts = diagnostic_counts(0)
  local parts = {}
  local items = {
    { severity.ERROR, "E" },
    { severity.WARN, "W" },
    { severity.INFO, "I" },
    { severity.HINT, "H" },
  }

  for _, item in ipairs(items) do
    local count = counts[item[1]] or 0
    if count > 0 then
      table.insert(parts, item[2] .. count)
    end
  end

  if #parts == 0 then
    return ""
  end
  return " " .. table.concat(parts, " ")
end

_G.DotfilesStatuslineGit = function()
  return M.git()
end

_G.DotfilesStatuslineDiagnostics = function()
  return M.diagnostics()
end

vim.opt.statusline = table.concat({
  " %f",
  " %m%r",
  "%{%v:lua.DotfilesStatuslineGit()%}",
  "%=",
  "%{%v:lua.DotfilesStatuslineDiagnostics()%}",
  " %{&filetype}",
  " %l:%c",
  " %p%% ",
})

return M
