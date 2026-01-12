return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        biome = {
          -- biome format → biome check --write に変更
          -- フォーマット + lint修正 + importソートを実行
          args = { "check", "--write", "--unsafe", "--stdin-file-path", "$FILENAME" },
        },
      },
    },
  },
}
