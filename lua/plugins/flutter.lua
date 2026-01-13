-- Flutterプロジェクトのルートを検索
local function find_flutter_project()
  -- 浅い階層から順に検索（パフォーマンス改善）
  for depth = 0, 3 do
    local pattern = string.rep("*/", depth) .. "pubspec.yaml"
    local files = vim.fn.glob(pattern, false, true)
    for _, pubspec in ipairs(files) do
      local project_dir = vim.fn.fnamemodify(pubspec, ":p:h")
      if vim.fn.isdirectory(project_dir .. "/lib") == 1 then
        return project_dir
      end
    end
  end
  return nil
end

return {
  -- flutter-tools.nvim
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      -- flutter_pathを環境変数または既知のパスから取得
      local flutter_path = vim.env.FLUTTER_PATH
        or vim.fn.expand("~/Tools/flutter/bin/flutter")

      require("flutter-tools").setup({
        flutter_path = flutter_path,
        ui = {
          border = "rounded",
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          enabled = true,
          highlight = "Comment",
          prefix = "// ",
        },
        dev_log = {
          enabled = true,
          open_cmd = "botright 15split", -- 画面下に高さ15行で表示
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
        lsp = {
          color = {
            enabled = true,
            background = true,
            virtual_text = true,
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            enableSnippets = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
        },
      })

      -- Flutterプロジェクトがあればコマンドを即座に登録
      local project_dir = find_flutter_project()
      if project_dir then
        require("flutter-tools").setup_project({
          cwd = project_dir,
          -- device = "emulator-5554", -- デフォルトデバイスを固定する場合はコメント解除
        })
      end

      -- Telescope拡張を読み込み（エラーハンドリング付き）
      pcall(function()
        require("telescope").load_extension("flutter")
      end)

      -- which-key用のグループ登録
      pcall(function()
        require("which-key").add({
          { "<leader>F", group = "Flutter" },
        })
      end)

      -- キーマップ
      local keymap = vim.keymap.set
      keymap("n", "<leader>Fr", "<cmd>FlutterRun<cr>", { desc = "Run" })
      keymap("n", "<leader>Fd", "<cmd>FlutterDevices<cr>", { desc = "Devices" })
      keymap("n", "<leader>Fe", "<cmd>FlutterEmulators<cr>", { desc = "Emulators" })
      keymap("n", "<leader>Fh", "<cmd>FlutterReload<cr>", { desc = "Hot Reload" })
      keymap("n", "<leader>FR", "<cmd>FlutterRestart<cr>", { desc = "Hot Restart" })
      keymap("n", "<leader>Fq", "<cmd>FlutterQuit<cr>", { desc = "Quit" })
      keymap("n", "<leader>FD", "<cmd>FlutterDevTools<cr>", { desc = "DevTools" })
      keymap("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<cr>", { desc = "Outline" })
      keymap("n", "<leader>Fl", "<cmd>FlutterLogClear<cr>", { desc = "Clear Log" })
      keymap("n", "<leader>Fp", "<cmd>Telescope flutter commands<cr>", { desc = "Commands" })
      keymap("n", "<leader>Fs", "<cmd>FlutterRename<cr>", { desc = "Rename" })
    end,
  },

  -- Dart用のTreesitterパーサー
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "dart" })
      end
    end,
  },
}
