return {
  {
    'stevearc/oil.nvim',
    lazy = false, -- so `nvim <dir>` opens oil instead of netrw
    dependencies = { 'echasnovski/mini.nvim' }, -- mini.icons
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      columns = { 'icon' },
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
  },
}
