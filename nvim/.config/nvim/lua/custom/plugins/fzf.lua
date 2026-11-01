return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.nvim' }, -- mini.icons
    config = function()
      local fzf = require 'fzf-lua'
      fzf.register_ui_select()
      fzf.setup {
        hls = { border = 'FloatBorder' },
        winopts = {
          border = 'single',
        },
      }

      vim.keymap.set('n', '<leader><leader>', fzf.files, { desc = 'fzf files' })
      vim.keymap.set('n', 'grr', fzf.lsp_references, { desc = 'LSP References' })
      vim.keymap.set('n', '<leader>/', fzf.live_grep, { desc = 'FzF Live Grep' })
      vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = '[B]uffer' })
      vim.keymap.set('n', '<leader>fm', fzf.manpages, { desc = '[M]anpages' })
      vim.keymap.set('n', '<leader>xt', function()
        fzf.grep { search = [[\b(TODO|FIX|FIXME|HACK|WARN|PERF|NOTE|TEST)\b]], no_esc = true }
      end, { desc = 'Todo comments' })
      vim.keymap.set('n', '<leader>xT', function()
        fzf.grep { search = [[\b(TODO|FIX|FIXME)\b]], no_esc = true }
      end, { desc = 'Todo/Fix/Fixme' })
      vim.keymap.set('n', '<leader>fc', function()
        fzf.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[C]onfig' })
    end,
  },
}
