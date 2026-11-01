return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'ty', 'ruff' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'ty', 'ruff' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'python' } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_organize_imports', 'ruff_format' },
      },
    },
  },
}
