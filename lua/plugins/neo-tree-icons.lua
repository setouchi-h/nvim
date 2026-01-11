local git_utils = require("utils.git")

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

      opts.filesystem = vim.tbl_deep_extend("force", opts.filesystem or {}, {
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
          never_show = {
            ".git",
          },
        },
      })

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

      opts.source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      }

      -- git_status ソースが選択されたら Diffview を開く
      opts.event_handlers = opts.event_handlers or {}
      table.insert(opts.event_handlers, {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.schedule(function()
            local win = vim.api.nvim_get_current_win()
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name:match("neo%-tree git_status") then
              local fs_state = require("neo-tree.sources.manager").get_state("filesystem")
              local dir = fs_state and fs_state.path or vim.fn.getcwd()
              local git_root = git_utils.get_root_from_path(dir .. "/dummy")

              vim.cmd("Neotree close")

              -- Diffview が閉じられたら Neo-tree を再度開く
              local group = vim.api.nvim_create_augroup("NeoTreeDiffviewReopen", { clear = true })
              vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "DiffviewViewClosed",
                once = true,
                callback = function()
                  vim.cmd("Neotree show")
                end,
              })

              if git_root then
                vim.cmd("DiffviewOpen -C=" .. vim.fn.fnameescape(git_root))
              else
                vim.cmd("DiffviewOpen")
              end
            end
          end)
        end,
      })

      return opts
    end,
  },
}
