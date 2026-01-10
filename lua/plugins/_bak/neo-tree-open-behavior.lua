return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      -- Neo-treeのウィンドウがファイルで置き換わらないようにする

      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "trouble", "qf", "Outline" }

      if not vim.tbl_contains(opts.open_files_do_not_replace_types, "neo-tree") then
        table.insert(opts.open_files_do_not_replace_types, "neo-tree")
      end

      -- Enterで開くときは、別ウィンドウに出す（ツリーを残す）
      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}
      opts.window.mappings["<cr>"] = "open_with_window_picker"
      opts.window.mappings["l"] = "open_with_window_picker"

      -- 「最後のウィンドウなら閉じる」系が効いてた場合の保険
      opts.close_if_last_window = false
    end,
  },
}
