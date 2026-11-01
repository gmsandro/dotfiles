return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'tailwindcss-language-server' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'tailwindcss' } },
  },
}
