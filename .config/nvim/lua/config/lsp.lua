local M = {}

local server_by_filetype = {
  lua = {
    {
      name = "lua_ls",
      cmd = { "lua-language-server" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          runtime = { version = "LuaJIT" },
          workspace = { checkThirdParty = false },
        },
      },
    },
  },
  python = {
    {
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    },
    {
      name = "pylsp",
      cmd = { "pylsp" },
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    },
  },
  c = {
    {
      name = "clangd",
      cmd = { "clangd" },
      root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
    },
  },
  cpp = {
    {
      name = "clangd",
      cmd = { "clangd" },
      root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
    },
  },
  sh = {
    {
      name = "bashls",
      cmd = { "bash-language-server", "start" },
      root_markers = { ".git" },
    },
  },
  yaml = {
    {
      name = "yamlls",
      cmd = { "yaml-language-server", "--stdio" },
      root_markers = { ".git" },
    },
  },
  json = {
    {
      name = "jsonls",
      cmd = { "vscode-json-language-server", "--stdio" },
      root_markers = { ".git" },
    },
  },
  markdown = {
    {
      name = "marksman",
      cmd = { "marksman", "server" },
      root_markers = { ".git" },
    },
  },
  robot = {
    {
      name = "robotframework_ls",
      cmd = { "robotframework_ls" },
      root_markers = { ".git" },
    },
  },
}

local function root_dir(markers, bufnr)
  local buffer_name = vim.api.nvim_buf_get_name(bufnr)
  local path = vim.fs.find(markers, {
    upward = true,
    path = buffer_name ~= "" and buffer_name or vim.loop.cwd(),
  })[1]
  return path and vim.fs.dirname(path) or vim.loop.cwd()
end

local function start_lsp(bufnr)
  local filetype = vim.bo[bufnr].filetype
  local candidates = server_by_filetype[filetype]
  if not candidates then
    return
  end

  for _, server in ipairs(candidates) do
    if vim.fn.executable(server.cmd[1]) == 1 then
      local config = vim.tbl_deep_extend("force", {}, server, {
        root_dir = root_dir(server.root_markers, bufnr),
      })
      config.root_markers = nil
      vim.lsp.start(config)
      return
    end
  end
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    start_lsp(args.buf)
  end,
})

return M
