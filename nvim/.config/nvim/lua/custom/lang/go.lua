return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'gopls', 'goimports', 'gofumpt' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'gopls' } },
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
