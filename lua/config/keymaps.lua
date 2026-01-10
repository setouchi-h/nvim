-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Cmd+C でコピー（ビジュアルモード用）
vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy to clipboard" })
-- Cmd+V でペースト
vim.keymap.set({ "i", "c" }, "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from clipboard" })
