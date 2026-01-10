return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- 1) file_opened で閉じる系のハンドラがあれば除去
      local ok, events = pcall(require, "neo-tree.events")
      local FILE_OPENED = ok and (events.FILE_OPENED or "file_opened") or "file_opened"

      opts.event_handlers = vim.tbl_filter(function(h)
        return h.event ~= "file_opened" and h.event ~= FILE_OPENED
      end, opts.event_handlers or {})

      -- 2) Enterでも普通に開く（閉じない）
      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}
      opts.window.mappings["<cr>"] = "open"
      opts.window.mappings["l"] = "open"
    end,
  },
}
