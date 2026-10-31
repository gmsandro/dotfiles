return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = { ensure_installed = { 'ts_ls' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'javascript', 'typescript', 'tsx', 'jsdoc' } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        javascript = { 'oxfmt' },
        javascriptreact = { 'oxfmt' },
        typescript = { 'oxfmt' },
        typescriptreact = { 'oxfmt' },
        json = { 'oxfmt' },
        vue = { 'oxfmt' },
      },
    },
  },
}
