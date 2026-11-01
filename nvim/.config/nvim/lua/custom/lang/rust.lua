return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'rust-analyzer' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'rust_analyzer' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'rust' } },
  },
}
