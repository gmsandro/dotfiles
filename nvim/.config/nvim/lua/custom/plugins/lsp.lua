-- Language files in custom/lang add to two lists (merged via `opts_extend`):
--   mason.nvim     `ensure_installed`: Mason package names to install (LSPs, formatters)
--   nvim-lspconfig `servers`:          lspconfig names to enable, e.g. { 'ts_ls' }
-- Servers not installed via Mason (e.g. clangd) only go into `servers`.
return {
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {},
    },
    config = function(_, opts)
      require('mason').setup(opts)

      local registry = require 'mason-registry'
      -- is_installed() only checks the install dir, so the common case (all
      -- installed) needs no registry at all
      local missing = vim.tbl_filter(function(name)
        return not registry.is_installed(name)
      end, opts.ensure_installed)
      if #missing == 0 then
        return
      end

      registry.refresh(function()
        for _, name in ipairs(missing) do
          if not registry.has_package(name) then
            vim.notify(('Mason: unknown package %q'):format(name), vim.log.levels.WARN)
          else
            local pkg = registry.get_package(name)
            if not pkg:is_installing() then
              pkg:install()
            end
          end
        end
      end)
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-org/mason.nvim' }, -- puts Mason's bin dir on PATH first
    opts_extend = { 'servers' },
    opts = {
      servers = {},
    },
    config = function(_, opts)
      vim.lsp.enable(opts.servers)
    end,
  },
}
