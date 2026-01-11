local M = {}

-- ファイルパスからgit rootを取得
function M.get_root_from_path(path)
  if not path or path == "" then
    return nil
  end
  local dir = vim.fn.fnamemodify(path, ":h")
  local git_root = vim.fn.system("git -C " .. vim.fn.shellescape(dir) .. " rev-parse --show-toplevel"):gsub("\n", "")
  if git_root:match("^fatal") then
    return nil
  end
  return git_root
end

-- 現在のバッファからgit rootを取得（worktree対応）
function M.get_root()
  local bufname = vim.api.nvim_buf_get_name(0)

  -- 現在のバッファが実際のファイルかチェック
  if bufname ~= "" and not bufname:match("^%w+://") and vim.fn.filereadable(bufname) == 1 then
    return M.get_root_from_path(bufname)
  end

  -- 実際のファイルバッファを探す
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name ~= "" and not name:match("^%w+://") and vim.fn.filereadable(name) == 1 then
      return M.get_root_from_path(name)
    end
  end

  return nil
end

return M
