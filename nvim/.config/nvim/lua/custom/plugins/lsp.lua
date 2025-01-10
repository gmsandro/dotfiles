return {
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',

      { 'j-hui/fidget.nvim',       opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      -- 'hrsh7th/cmp-nvim-lsp',
      'saghen/blink.cmp',
    },
    opts = {
      servers = {
        lua_ls = {},
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
              semanticTokens = true,
            },
          },
        },
        marksman = {},
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        rust_analyzer = function()
          return true
        end,
      },

    },
    config = function(_, opts)
      local lspconfig = require 'lspconfig'

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })

      require('mason-lspconfig').setup_handlers {
        function(server_name)
          if server_name ~= "rust_analyzer" then
            local server_opts = opts.servers[server_name] or {}
            server_opts.capabilities = require('blink-cmp').get_lsp_capabilities(server_opts.capabilities)

            -- Check if there's a custom setup function
            if opts.setup[server_name] then
              if opts.setup[server_name](server_name, server_opts) then
                return -- don't continue if the setup function returns true
              end
            end

            lspconfig[server_name].setup(server_opts)
          end
        end,
      }

      -- require('mason-lspconfig').setup_handlers {
      --   function(server_name)
      --     if server_name ~= "rust_analyzer" then
      --       local config = opts.servers[server_name] or {}
      --       config.capabilities = require('blink-cmp').get_lsp_capabilities(config.capabilities)
      --       lspconfig[server_name].setup(config)
      --     end
      --   end,
      -- }
    end,
  },
}
