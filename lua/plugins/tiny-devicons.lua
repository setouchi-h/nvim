return {
  {
    "rachartier/tiny-devicons-auto-colors.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      local palette = require("catppuccin.palettes").get_palette("macchiato")
      require("tiny-devicons-auto-colors").setup({
        colors = palette,
      })
    end,
  },
}
