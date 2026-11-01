return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'goimports', 'gofumpt' } },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = { ensure_installed = { 'gopls' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'go', 'gomod', 'gosum' } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        go = { 'goimports', 'gofumpt' },
      },
    },
  },
}
