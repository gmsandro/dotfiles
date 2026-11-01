return {
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'clangd' } }, -- not via Mason: clangd ships with the Xcode command line tools
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'c' } },
  },
}
