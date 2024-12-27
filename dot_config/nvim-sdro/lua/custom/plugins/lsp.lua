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

      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      -- 'hrsh7th/cmp-nvim-lsp',
      'saghen/blink.cmp',
    },
    opts = {
      servers = {
        lua_ls = {},
        rust_analyzer = { enabled = false },
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
    },
    config = function(_, opts)
      local lspconfig = require 'lspconfig'

      -- Change diagnostic symbols in the sign column (gutter)
      -- if vim.g.have_nerd_font then
      --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      --   local diagnostic_signs = {}
      --   for type, icon in pairs(signs) do
      --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
      --   end
      --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
      -- end

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })

      require('mason-lspconfig').setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {}
        end,
      }
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = 'Go to Definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true, silent = true, desc = 'Go to Declaration' })
      vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { noremap = true, silent = true, desc = 'Go to Implementation' })
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { noremap = true, silent = true, desc = 'Go to T[y]pe Definition' })
      vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = 'Signature Help' })
      vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = 'Signature Help' })

      -- vim.keymap.set( "K", function() return vim.lsp.buf.hover() end,{ desc = "Hover" }),
      -- vim.keymap.set( "<c-k>", function() return vim.lsp.buf.signature_help() end,{ mode = "i", desc = "Signature Help", has = "signatureHelp" }),
      -- vim.keymap.set('n', "<leader>cR", function() Snacks.rename.rename_file() end, {desc = "Rename File" })
      vim.keymap.set('n', 'gK', function()
        return vim.lsp.buf.signature_help()
      end, { desc = 'Signature Help' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
      vim.keymap.set('n', '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
      vim.keymap.set('n', ']]', function()
        Snacks.words.jump(vim.v.count1)
      end, {
        desc = 'Next Reference',
      })
      vim.keymap.set('n', '[[', function()
        Snacks.words.jump(-vim.v.count1)
      end, {
        desc = 'Prev Reference',
      })
      vim.keymap.set('n', '<a-n>', function()
        Snacks.words.jump(vim.v.count1, true)
      end, {
        desc = 'Next Reference',
      })
      vim.keymap.set('n', '<a-p>', function()
        Snacks.words.jump(-vim.v.count1, true)
      end, {
        desc = 'Prev Reference',
      })
    end,
    setup = {
      rust_analyzer = function()
        return true
      end,

      -- go
      gopls = function(_, opts)
        -- workaround for gopls not supporting semanticTokensProvider
        -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
        vim.lsp.on_attach(function(client, _)
          if not client.server_capabilities.semanticTokensProvider then
            local semantic = client.config.capabilities.textDocument.semanticTokens
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        end, 'gopls')
        -- end workaround
      end,
    },
  },
}
