return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        local function hunk_range()
          local start_line = vim.fn.line(".")
          local end_line = vim.fn.line("v")
          return { math.min(start_line, end_line), math.max(start_line, end_line) }
        end

        map("n", "]h", function()
          gitsigns.nav_hunk("next")
        end, "Next git hunk")
        map("n", "[h", function()
          gitsigns.nav_hunk("prev")
        end, "Previous git hunk")
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage git hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset git hunk")
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk(hunk_range())
        end, "Stage selected git hunks")
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk(hunk_range())
        end, "Reset selected git hunks")
        map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
        map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview git hunk")
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, "Blame line")
      end,
    },
  },
}
