local git_utils = require("utils.git")

return {
  -- LazyVim snacks.nvim の <leader>gd キーマップを無効化（diffview.nvim を優先）
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gd", false },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
        virt_text_pos = "eol",
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>gd",
        function()
          local git_root = git_utils.get_root()
          vim.cmd("DiffviewOpen" .. (git_root and (" -C=" .. vim.fn.fnameescape(git_root)) or ""))
        end,
        desc = "Diff view (all)",
      },
      {
        "<leader>gD",
        function()
          local git_root = git_utils.get_root()
          vim.cmd("DiffviewOpen --staged" .. (git_root and (" -C=" .. vim.fn.fnameescape(git_root)) or ""))
        end,
        desc = "Diff view (staged)",
      },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
    },
    opts = {},
  },
}
