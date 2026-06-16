local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local filetypes = {
  "c",
  "cpp",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "query",
  "sh",
  "toml",
  "typescript",
  "typescriptreact",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
      if vim.fn.executable("tree-sitter") == 0 then
        vim.notify("tree-sitter CLI is not installed; skipping parser install", vim.log.levels.WARN)
        return
      end

      require("nvim-treesitter").install(parsers):wait(300000)
    end,
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      vim.treesitter.language.register("bash", "sh")
      vim.treesitter.language.register("tsx", "typescriptreact")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
