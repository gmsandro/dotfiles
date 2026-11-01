return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'typescript-language-server', 'oxlint', 'oxfmt' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'ts_ls', 'oxlint' } },
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
