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
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',

      { 'j-hui/fidget.nvim', opts = {} },

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
        vtsls = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          init_options = {
            preferences = {
              importModuleSpecifierPreference = 'non-relative',
            },
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          keys = {
            {
              'gD',
              function()
                local params = vim.lsp.util.make_position_params()
                vim.lsp.execute {
                  command = 'typescript.goToSourceDefinition',
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                }
              end,
              desc = 'Goto Source Definition',
            },
            {
              'gR',
              function()
                vim.lsp.execute {
                  command = 'typescript.findAllFileReferences',
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                }
              end,
              desc = 'File References',
            },
            {
              '<leader>co',
              function()
                vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } } }
              end,
              desc = 'Organize Imports',
            },
            {
              '<leader>cM',
              function()
                vim.lsp.buf.code_action { context = { only = { 'source.addMissingImports' } } }
              end,
              desc = 'Add missing imports',
            },
            {
              '<leader>cu',
              function()
                vim.lsp.buf.code_action { context = { only = { 'source.removeUnused' } } }
              end,
              desc = 'Remove unused imports',
            },
            {
              '<leader>cD',
              function()
                vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } } }
              end,
              desc = 'Fix all diagnostics',
            },
            {
              '<leader>cV',
              function()
                vim.lsp.execute { command = 'typescript.selectTypeScriptVersion' }
              end,
              desc = 'Select TS workspace version',
            },
          },
        },
      },
      ---@type table<string, fun(server:string, opts:lspconfig.options):boolean?>
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
    ensure_installed = { 'lua_ls', 'stylua' },
    config = function(_, opts)
      require('mason-lspconfig').setup {
        ensure_installed = opts.ensure_installed or {},
        automatic_installation = false,
      }
      local lspconfig = require 'lspconfig'
      local blink = require 'blink-cmp'
      local capabilities = blink.get_lsp_capabilities()

      require('mason').setup()

      require('mason-lspconfig').setup_handlers {
        function(server_name)
          local server_opts = vim.tbl_deep_extend('force', {
            capabilities = vim.deepcopy(capabilities),
          }, opts.servers[server_name] or {})

          if server_opts.enabled == false then
            return
          end

          -- Check for specific server setup
          if opts.setup[server_name] then
            if opts.setup[server_name](server_name, server_opts) then
              return
            end
            -- Check for wildcard setup
          elseif opts.setup['*'] then
            if opts.setup['*'](server_name, server_opts) then
              return
            end
          end

          lspconfig[server_name].setup(server_opts)
        end,
      }
    end,
  },
}
