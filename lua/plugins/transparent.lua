return {
  -- 現在のテーマが tokyonight ならこれ
  {
    "folke/tokyonight.nvim",
    opts = { transparent = true },
  },

  -- 透明化の取りこぼしを潰す
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
  },
}
