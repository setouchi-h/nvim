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

      -- git_statusでファイルをdiffviewで開く
      opts.git_status = vim.tbl_deep_extend("force", opts.git_status or {}, {
        window = {
          mappings = {
            ["<cr>"] = function(state)
              local node = state.tree:get_node()
              local path = node.path or node:get_id()
              if path and vim.fn.filereadable(path) == 1 then
                vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(path))
              end
            end,
            ["<2-LeftMouse>"] = function(state)
              local node = state.tree:get_node()
              local path = node.path or node:get_id()
              if path and vim.fn.filereadable(path) == 1 then
                vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(path))
              end
            end,
            ["<LeftRelease>"] = function(state)
              local node = state.tree:get_node()
              local path = node.path or node:get_id()
              if path and vim.fn.filereadable(path) == 1 then
                vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(path))
              end
            end,
            ["o"] = "open", -- 通常のopenも残す
          },
        },
      })

      return opts
    end,
    keys = {
      { "<leader>gs", "<cmd>Neotree git_status<cr>", desc = "Git status (Neo-tree)" },
    },
  },
}
