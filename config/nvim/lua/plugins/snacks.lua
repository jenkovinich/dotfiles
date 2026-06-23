return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = {
      {
        "<C-p>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart find files",
      },
    },
  },
}
