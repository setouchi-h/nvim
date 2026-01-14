return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)

    -- SVGファイルを開いた時に外部ビューアで表示
    vim.api.nvim_create_autocmd("BufReadCmd", {
      pattern = "*.svg",
      callback = function(args)
        local svg_path = vim.fn.fnamemodify(args.file, ":p")
        -- Arcで開く
        vim.fn.system({ "open", "-a", "Arc", svg_path })
        vim.notify("SVGを外部ビューアで開きました: " .. svg_path, vim.log.levels.INFO)
        -- 空のバッファを閉じる
        vim.cmd("bdelete")
      end,
    })
  end,
}
