return {
  { 'j-hui/fidget.nvim', opts = {} },
  {
    -- Non-LSP tools (formatters, linters). Language files in custom/plugins
    -- add to `ensure_installed`; the lists are merged via `opts_extend`.
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {},
    },
    config = function(_, opts)
      require('mason').setup(opts)

      local registry = require 'mason-registry'
      registry.refresh(function()
        for _, name in ipairs(opts.ensure_installed) do
          local pkg = registry.get_package(name)
          if not pkg:is_installed() and not pkg:is_installing() then
            pkg:install()
          end
        end
      end)
    end,
  },
  {
    -- LSP servers (lspconfig names), added by language files like mason.nvim above.
    -- Installed servers are enabled automatically.
    'mason-org/mason-lspconfig.nvim',
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {},
      automatic_enable = {
        exclude = {
          'rust_analyzer',
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
  },
}
