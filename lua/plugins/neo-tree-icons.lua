return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.default_component_configs = opts.default_component_configs or {}

      opts.default_component_configs.icon = vim.tbl_deep_extend("force", opts.default_component_configs.icon or {}, {
        folder_closed = "󰉋",
        folder_open = "󰝰",
        folder_empty = "󰉖",
        default = "󰈙",
      })

      opts.default_component_configs.indent =
        vim.tbl_deep_extend("force", opts.default_component_configs.indent or {}, {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          expander_collapsed = "",
          expander_expanded = "",
        })

      -- gitステータスの自動更新を有効化
      opts.filesystem = vim.tbl_deep_extend("force", opts.filesystem or {}, {
        use_libuv_file_watcher = true,
      })

      -- シングルクリックでファイルを開く設定
      opts.event_handlers = opts.event_handlers or {}
      table.insert(opts.event_handlers, {
        event = "file_open_requested",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      })

      -- ウィンドウ設定：シングルクリックでファイルを開く
      opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
        mappings = {
          ["<cr>"] = "open",
          ["<2-LeftMouse>"] = "open",
          ["<LeftRelease>"] = {
            "open",
            nowait = true,
          },
        },
      })

      -- git_statusソースの設定
      opts.source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      }

      return opts
    end,
    keys = {
      { "<leader>gs", "<cmd>Neotree git_status<cr>", desc = "Git status (Neo-tree)" },
    },
  },
}
