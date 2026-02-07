return {
  -- xcodebuild.nvim
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- デバッグ用
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("xcodebuild").setup({
        -- デバッガー統合（print出力表示用）
        integrations = {
          dap = {
            enabled = true,
          },
        },
        -- ログパネルの設定
        logs = {
          auto_open_on_success_build = false,
          auto_open_on_failed_build = true,
          auto_focus = false,
        },
        -- コードカバレッジ
        code_coverage = {
          enabled = true,
        },
      })

      -- nvim-dap に lldb-dap を設定
      require("xcodebuild.integrations.dap").setup()

      -- which-key用のグループ登録
      require("which-key").add({
        { "<leader>X", group = "Xcode" },
      })

      -- キーマップ（<leader>X = Xcode）
      local keymap = vim.keymap.set
      keymap("n", "<leader>XS", "<cmd>XcodebuildSetup<cr>", { desc = "Setup Project" })
      keymap("n", "<leader>Xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build" })
      keymap("n", "<leader>XB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build for Testing" })
      keymap("n", "<leader>Xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run" })
      keymap("n", "<leader>Xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
      keymap("n", "<leader>XT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run Test Class" })
      keymap("n", "<leader>X.", "<cmd>XcodebuildTestRepeat<cr>", { desc = "Repeat Last Test" })
      keymap("n", "<leader>Xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Logs" })
      keymap("n", "<leader>Xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
      keymap("n", "<leader>Xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
      keymap("n", "<leader>Xs", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
      keymap("n", "<leader>Xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
      keymap("n", "<leader>XC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Coverage Report" })
      keymap("n", "<leader>Xq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })
      keymap("n", "<leader>Xx", "<cmd>XcodebuildPicker<cr>", { desc = "Xcodebuild Commands" })
      -- デバッグ用キーマップ
      keymap("n", "<leader>XD", function()
        require("xcodebuild.integrations.dap").build_and_debug()
      end, { desc = "Build & Debug" })
      keymap("n", "<leader>XE", "<cmd>XcodebuildTestExplorerShow<cr>", { desc = "Test Explorer" })
      keymap("n", "<leader>XR", function()
        require("xcodebuild.tests.runner").reload_tests()
      end, { desc = "Reload Tests" })
    end,
  },
}
