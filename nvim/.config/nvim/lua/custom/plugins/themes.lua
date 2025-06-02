return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- vim.cmd.colorscheme 'tokyonight'
    end,
  },
  {
    'gmsandro/aura.nvim',
    init = function()
      vim.cmd.colorscheme 'aura'
    end,
  },
  { 'EdenEast/nightfox.nvim' },
  { 'gmsandro/oldworld.nvim' },
  { 'rose-pine/neovim' },
  { 'gmsandro/kanagawa.nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      require('catppuccin').setup {
        flavour = 'auto', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
      }

      -- vim.cmd.colorscheme ''
    end,
  },
}
