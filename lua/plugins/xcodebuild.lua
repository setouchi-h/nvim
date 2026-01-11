return {
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
      -- ログパネルの設定
      logs = {
        auto_open_on_success_build = true,
        auto_open_on_failed_build = true,
        auto_focus = false,
      },
      -- コードカバレッジ
      code_coverage = {
        enabled = true,
      },
    })

    -- キーマップ
    local keymap = vim.keymap.set
    keymap("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build" })
    keymap("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build for Testing" })
    keymap("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run" })
    keymap("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
    keymap("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run Test Class" })
    keymap("n", "<leader>x.", "<cmd>XcodebuildTestRepeat<cr>", { desc = "Repeat Last Test" })
    keymap("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Logs" })
    keymap("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
    keymap("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
    keymap("n", "<leader>xs", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
    keymap("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
    keymap("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Coverage Report" })
    keymap("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })
    keymap("n", "<leader>xx", "<cmd>XcodebuildPicker<cr>", { desc = "Xcodebuild Commands" })
  end,
}
