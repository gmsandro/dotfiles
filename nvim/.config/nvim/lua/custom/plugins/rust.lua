-- vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
-- local diagnostics = vim.g.lazyvim_rust_diagnostics or 'rust-analyzer'

local diagnostics = 'rust-analyzer'

return {
  -- LSP for Cargo.toml
  {
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- Add Rust & related to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'rust', 'ron' } },
  },

  -- Ensure Rust debugger is installed
  {
    'williamboman/mason.nvim',
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { 'codelldb' })
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<leader>cR', function()
            vim.cmd.RustLsp 'codeAction'
          end, { desc = 'Code Action', buffer = bufnr })
          vim.keymap.set('n', '<leader>dr', function()
            vim.cmd.RustLsp 'debuggables'
          end, { desc = 'Rust Debuggables', buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust if using rust-analyzer
            checkOnSave = diagnostics == 'rust-analyzer',
            -- Enable diagnostics if using rust-analyzer
            diagnostics = {
              enable = diagnostics == 'rust-analyzer',
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
            files = {
              excludeDirs = {
                '.direnv',
                '.git',
                '.github',
                '.gitlab',
                'bin',
                'node_modules',
                'target',
                'venv',
                '.venv',
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      local package_path = require('mason-registry').get_package('codelldb'):get_install_path()
      local codelldb = package_path .. '/extension/adapter/codelldb'
      local library_path = package_path .. '/extension/lldb/lib/liblldb.dylib'
      local uname = io.popen('uname'):read '*l'
      if uname == 'Linux' then
        library_path = package_path .. '/extension/lldb/lib/liblldb.so'
      end
      opts.dap = {
        adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb, library_path),
      }
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}