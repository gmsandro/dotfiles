-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", ",st", function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- better up/down
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

vim.keymap.set('n', '<leader>bo', function()
  Snacks.bufdelete.other()
end, { desc = 'Delete Other Buffers' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New Buffer' })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })


-- lsp
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = 'Go to Definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, silent = true, desc = 'Go to Declaration' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation,
  { noremap = true, silent = true, desc = 'Go to Implementation' })
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition,
  { noremap = true, silent = true, desc = 'Go to T[y]pe Definition' })
vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = 'Signature Help' })
vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = 'Signature Help' })

vim.keymap.set('n', 'gK', function()
  return vim.lsp.buf.signature_help()
end, { desc = 'Signature Help' })
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set({ 'n', 'v' }, '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
vim.keymap.set('n', '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', ']]', function()
  Snacks.words.jump(vim.v.count1)
end, {
  desc = 'Next Reference',
})
vim.keymap.set('n', '[[', function()
  Snacks.words.jump(-vim.v.count1)
end, {
  desc = 'Prev Reference',
})
vim.keymap.set('n', '<a-n>', function()
  Snacks.words.jump(vim.v.count1, true)
end, {
  desc = 'Next Reference',
})
vim.keymap.set('n', '<a-p>', function()
  Snacks.words.jump(-vim.v.count1, true)
end, {
  desc = 'Prev Reference',
})


--keywordprg
vim.keymap.set('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- new file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

vim.keymap.set('n', '<space>rs', '<cmd>source %<CR>')
