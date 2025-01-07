-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local set = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    set.number = false
    set.relativenumber = false
    set.scrolloff = 0

    vim.bo.filetype = "terminal"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "json", "yaml" },
  callback = function()
    set.shiftwidth = 2
    set.tabstop = 2
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "python", "rust", "go" },
--   callback = function()
--     set.shiftwidth = 4
--     set.tabstop = 4
--   end,
-- })
