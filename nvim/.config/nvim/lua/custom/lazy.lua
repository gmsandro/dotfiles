-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'custom.plugins' },
  -- Per-language setup (LSP, tools, formatters, parsers). Imported after
  -- custom.plugins so the base specs' `opts_extend` applies to these lists.
  { import = 'custom.lang' },
}, {
  -- No plugin needs luarocks; don't let lazy install hererocks/luarocks
  rocks = { enabled = false },
})
