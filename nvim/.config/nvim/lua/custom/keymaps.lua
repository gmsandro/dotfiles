-- Neovim's own defaults cover a lot (see :h default-mappings): ]d/[d, ]q/[q,
-- ]b/[b, ]t/[t, ]a/[a, <C-W>d (line diagnostics), <C-L> (clear search
-- highlight), K, gra/gri/grn/grr/grt/grx, gO, <C-S> in insert mode, gc/gcc.
-- This file only adds what's missing.

-- Clear search highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Windows (move focus with the default <C-w>h/j/k/l)
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Move by display lines unless a count is given
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Commenting
vim.keymap.set('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
vim.keymap.set('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- Buffers
vim.keymap.set('n', '<leader>bo', function()
  Snacks.bufdelete.other()
end, { desc = 'Delete Other Buffers' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'New Buffer' })

-- Diagnostics: open the float after every jump, including the default ]d/[d
vim.diagnostic.config {
  jump = {
    on_jump = function(diagnostic, bufnr)
      if diagnostic then
        vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false }
      end
    end,
  },
}
local function diagnostic_jump(count, severity)
  return function()
    vim.diagnostic.jump { count = count, severity = vim.diagnostic.severity[severity] }
  end
end
vim.keymap.set('n', ']e', diagnostic_jump(1, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_jump(-1, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_jump(1, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_jump(-1, 'WARN'), { desc = 'Prev Warning' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostics to location list' })

-- LSP: buffer-local, so buffers without a client keep the built-in gd/gD
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('custom_lsp_keymaps', { clear = true }),
  callback = function(event)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
    end
    map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')
    map('n', 'gy', vim.lsp.buf.type_definition, 'Go to T[y]pe Definition')
    map('n', 'gK', vim.lsp.buf.signature_help, 'Signature Help')
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
  end,
})

vim.keymap.set('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>rs', '<cmd>source %<CR>', { desc = 'Source current file' })

-- Undotree (built-in since 0.12, see :h package-undotree). Loaded on first use,
-- since lazy.nvim resets 'runtimepath' after this file runs.
vim.keymap.set('n', '<leader>ut', function()
  vim.cmd.packadd 'nvim.undotree'
  require('undotree').open()
end, { desc = 'UndoTree' })
