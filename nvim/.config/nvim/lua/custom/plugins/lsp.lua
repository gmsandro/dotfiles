return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'j-hui/fidget.nvim', opts = {} },
  { 'mason-org/mason.nvim' },
  { 'mason-org/mason-lspconfig.nvim' },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    ensure_installed = { 'lua_ls', 'stylua' },
    config = function(_, opts)
      require('mason-lspconfig').setup {
        automatic_enable = {
          exclude = {
            'rust_analyzer',
            'ts_ls',
          },
        },
        ensure_installed = opts.ensure_installed,
      }

      require('mason').setup()
    end,
  },
}
