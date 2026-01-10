-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Neo-tree customization
local function set_neotree_hl()
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#E5A84B" })
  vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#E5A84B" })
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#6B7280" })
  vim.api.nvim_set_hl(0, "NeoTreeExpander", { fg = "#6B7280" })
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = set_neotree_hl,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = set_neotree_hl,
})

set_neotree_hl()

-- FocusGained時にneo-treeを更新（外部でgit操作した場合）
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    if package.loaded["neo-tree"] then
      require("neo-tree.sources.manager").refresh("filesystem")
    end
  end,
})
