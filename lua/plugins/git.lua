-- 現在のバッファからgit rootを取得（worktree対応）
local function get_git_root()
  local bufname = vim.api.nvim_buf_get_name(0)
  local file_dir

  if bufname ~= "" and not bufname:match("^%w+://") and vim.fn.filereadable(bufname) == 1 then
    file_dir = vim.fn.fnamemodify(bufname, ":h")
  else
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" and not name:match("^%w+://") and vim.fn.filereadable(name) == 1 then
        file_dir = vim.fn.fnamemodify(name, ":h")
        break
      end
    end
  end

  if not file_dir then
    return nil
  end

  local git_root = vim.fn.system("git -C " .. vim.fn.shellescape(file_dir) .. " rev-parse --show-toplevel"):gsub("\n", "")
  if git_root:match("^fatal") then
    return nil
  end

  return git_root
end

return {
  -- LazyVim snacks.nvim の <leader>gd キーマップを無効化（diffview.nvim を優先）
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gd", false },
    },
  },

  -- LazyVim既存のgitsignsを拡張
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
        virt_text_pos = "eol",
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
  },

  -- VSCode風のdiff表示
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>gd",
        function()
          local git_root = get_git_root()
          vim.cmd("DiffviewOpen" .. (git_root and (" -C=" .. vim.fn.fnameescape(git_root)) or ""))
        end,
        desc = "Diff view (all)",
      },
      {
        "<leader>gD",
        function()
          local git_root = get_git_root()
          vim.cmd("DiffviewOpen --staged" .. (git_root and (" -C=" .. vim.fn.fnameescape(git_root)) or ""))
        end,
        desc = "Diff view (staged)",
      },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
    },
    opts = {},
  },
}
