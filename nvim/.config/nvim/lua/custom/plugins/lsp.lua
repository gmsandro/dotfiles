return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'j-hui/fidget.nvim', opts = {} },
  { 'mason-org/mason.nvim' },
  { 'mason-org/mason-lspconfig.nvim' },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp', 'rafamadriz/friendly-snippets' },
    ensure_installed = { 'lua_ls', 'stylua' },
    config = function(_, opts)
      require('mason-lspconfig').setup {
        automatic_enable = {
          exclude = {
            'rust_analyzer',
            'ts_ls',
          },
        },
      }

      require('mason').setup()

      require('blink.cmp').setup {
        sources = {
          default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              -- make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100,
            },
          },
        },
        signature = {
          enabled = true,
          window = { border = 'none' },
        },
        completion = {
          accept = {
            -- experimental auto-brackets support
            auto_brackets = {
              enabled = true,
            },
          },
          menu = {
            border = 'none',
            draw = {
              treesitter = { 'lsp' },
            },
          },
          documentation = {
            window = { border = 'none' },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
          ghost_text = {
            enabled = false,
          },
        },
      }
    end,
  },
}
