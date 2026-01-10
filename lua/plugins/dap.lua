return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- 基本設定のみ（xcodebuildが詳細を設定）
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
}
