return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.setupopts
  opts = {},
  -- optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  config = function()
    require('oil').setup {
      columns = {
        'icon',
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      view_options = {
        show_hidden = true,
      },
    }
    vim.keymap.set('n', '-', '<cmd>oil<cr>', { desc = 'open parent directory' })
  end,
}
