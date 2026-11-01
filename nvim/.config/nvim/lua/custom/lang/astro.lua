-- astro-ls needs TypeScript in the project's node_modules. Formatting goes
-- through the LSP (project's prettier + prettier-plugin-astro); oxfmt has no
-- Astro support. oxlint and tailwindcss already cover .astro files.
return {
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'astro-language-server' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = { servers = { 'astro' } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'astro', 'css' } },
  },
}
