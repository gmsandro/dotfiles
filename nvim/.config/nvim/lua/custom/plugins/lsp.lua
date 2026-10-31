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
    opts = {
      ensure_installed = { 'lua_ls', 'stylua', 'ty', 'ruff', 'ts_ls' },
    },
    config = function(_, opts)
      require('mason-lspconfig').setup {
        automatic_enable = {
          exclude = {
            'rust_analyzer',
          },
        },
        ensure_installed = opts.ensure_installed,
      }

      require('mason').setup()
    end,
  },
}
