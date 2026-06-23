local servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          typeCheckingMode = "standard",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  ruff = {},
  markdown_oxide = {},
  robotcode = {},
}

local ensure_installed = {
  "basedpyright",
  "ruff",
  "markdown_oxide",
  "robotcode",
}

local function set_lsp_keymaps(event)
  local bufnr = event.buf
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "gr", vim.lsp.buf.references, "List references")
  map("n", "K", vim.lsp.buf.hover, "Show hover")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "[d", function()
    vim.diagnostic.goto_prev({ float = true })
  end, "Previous diagnostic")
  map("n", "]d", function()
    vim.diagnostic.goto_next({ float = true })
  end, "Next diagnostic")
  map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to location list")
  map("n", "<leader>f", "<cmd>Format<CR>", "Format buffer")
end

return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        virtual_text = {
          source = "if_many",
          spacing = 2,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("dotfiles_lsp_keymaps", { clear = true }),
        callback = set_lsp_keymaps,
      })

      for name, config in pairs(servers) do
        vim.lsp.config(name, config)
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_enable = true,
      })
    end,
  },
}
