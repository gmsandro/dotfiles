-- vue_ls handles <template>/<style>; TypeScript in .vue files goes through
-- ts_ls with @vue/typescript-plugin (see after/lsp/ts_ls.lua)
return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'vue-language-server' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'vue_ls' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'vue', 'css' } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        vue = { 'oxfmt' },
      },
    },
  },
}
