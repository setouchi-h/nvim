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
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "console", size = 1.0 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- デバッグ開始時に自動でUIを開く
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- デバッグ終了時に自動でUIを閉じる
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
