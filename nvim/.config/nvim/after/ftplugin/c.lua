vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.shiftwidth = 4 -- Number of spaces for auto-indent
vim.bo.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.bo.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.bo.cindent = true -- Enable C style indentation
vim.bo.autoindent = true -- Copy indent from current line when starting a new line

-- Text width and formatting
vim.bo.textwidth = 80 -- Maximum width of text being inserted
vim.bo.formatoptions = 'tcqj' -- Automatic formatting options

vim.bo.commentstring = '// %s'

-- Auto-format on save using clang-format
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.c,*.h',
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end,
--   group = vim.api.nvim_create_augroup('CFormatting', { clear = true }),
-- })
