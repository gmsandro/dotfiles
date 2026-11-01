return {
  {
    'saghen/blink.cmp',
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- C-y accept, C-space open menu/docs, C-n/C-p select, C-e hide, C-k toggle signature
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- make lazydev completions top priority
          },
        },
      },
      signature = { enabled = true },
      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
          },
        },
        documentation = { auto_show = false },
        ghost_text = { enabled = false },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
