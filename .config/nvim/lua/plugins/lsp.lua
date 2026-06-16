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
