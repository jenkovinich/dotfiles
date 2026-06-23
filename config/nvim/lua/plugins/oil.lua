return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
    },
    config = function(_, opts)
      require("oil").setup(opts)
      vim.keymap.set("n", "-", function()
        require("oil").open()
      end, { desc = "Open parent directory" })
    end,
  },
}
