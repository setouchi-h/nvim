return {
  -- Swift LSP設定
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          cmd = { "xcrun", "sourcekit-lsp" },
          root_dir = function(filename, _)
            local util = require("lspconfig.util")
            return util.root_pattern("buildServer.json")(filename)
              or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
              or util.root_pattern("Package.swift")(filename)
              or util.root_pattern(".git")(filename)
          end,
          filetypes = { "swift", "objective-c", "objective-cpp" },
        },
      },
    },
  },

  -- Swift用のTreesitterパーサー
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "swift" })
      end
    end,
  },

  -- Swiftフォーマッタ (swift-format)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swift_format" },
      },
      formatters = {
        swift_format = {
          command = "xcrun",
          args = { "swift-format", "--in-place", "$FILENAME" },
          stdin = false,
        },
      },
    },
  },
}
