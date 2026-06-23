local M = {}

local function open_quickfix(title, items)
  vim.fn.setqflist({}, " ", { title = title, items = items })
  if #items > 0 then
    vim.cmd.copen()
  else
    vim.notify("No results", vim.log.levels.INFO)
  end
end

function M.files()
  local command
  if vim.fn.isdirectory(".git") == 1 then
    command = { "git", "ls-files", "--cached", "--others", "--exclude-standard" }
  else
    command = { "find", ".", "-type", "f" }
  end

  local files = vim.fn.systemlist(command)
  local items = {}
  for _, file in ipairs(files) do
    table.insert(items, { filename = file, lnum = 1, col = 1, text = file })
  end

  open_quickfix("Files", items)
end

function M.grep()
  if vim.fn.executable("rg") == 0 then
    vim.notify("ripgrep is not installed", vim.log.levels.ERROR)
    return
  end

  local query = vim.fn.input("Rg: ")
  if query == "" then
    return
  end

  vim.cmd("silent grep! " .. vim.fn.shellescape(query))
  vim.cmd.copen()
end

local function comment_prefix()
  local commentstring = vim.bo.commentstring
  if commentstring == "" or not commentstring:find("%%s", 1, true) then
    local fallback_by_filetype = {
      c = "//",
      cpp = "//",
      lua = "--",
      make = "#",
      python = "#",
      robot = "#",
      sh = "#",
      yaml = "#",
    }
    return fallback_by_filetype[vim.bo.filetype]
  end

  local prefix, suffix = commentstring:match("^(.-)%%s(.-)$")
  prefix = vim.trim(prefix or "")
  suffix = vim.trim(suffix or "")
  if suffix ~= "" then
    return nil
  end
  return prefix
end

function M.toggle_comment()
  local prefix = comment_prefix()
  if not prefix or prefix == "" then
    vim.notify("No commentstring configured for this filetype", vim.log.levels.WARN)
    return
  end

  local mode = vim.fn.mode()
  local start_line = vim.fn.line(".")
  local end_line = start_line
  if mode == "v" or mode == "V" or mode == "\022" then
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
  end

  local escaped = vim.pesc(prefix)
  for line_number = start_line, end_line do
    local line = vim.fn.getline(line_number)
    local indent, text = line:match("^(%s*)(.*)$")
    if text:match("^" .. escaped .. "%s?") then
      text = text:gsub("^" .. escaped .. "%s?", "", 1)
    else
      text = prefix .. " " .. text
    end
    vim.fn.setline(line_number, indent .. text)
  end
end

local function client_supports_formatting(client, bufnr)
  if client.supports_method then
    return client:supports_method("textDocument/formatting", bufnr)
  end
  return client.server_capabilities and client.server_capabilities.documentFormattingProvider
end

function M.format()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    if client_supports_formatting(client, bufnr) then
      vim.lsp.buf.format({ bufnr = bufnr, async = false })
      return
    end
  end

  vim.notify("No LSP formatter attached to this buffer", vim.log.levels.WARN)
end

vim.api.nvim_create_user_command("ProjectFiles", M.files, {})
vim.api.nvim_create_user_command("ProjectGrep", M.grep, {})
vim.api.nvim_create_user_command("Format", M.format, {})

return M
