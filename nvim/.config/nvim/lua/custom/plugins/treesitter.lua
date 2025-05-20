return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },

    build = ':TSUpdate',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        ensure_installed = {
          'vimdoc',
          'c',
          'lua',
          'rust',
          'bash',
          'markdown',
          'go',
          'bash',
          'luadoc',
          'printf',
          'tsx',
          'javascript',
          'typescript',
          'html',
          'jsdoc',
        },
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },

        -- Add textobjects configuration
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
            goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
            goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
            goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
          },
        },
      }

      local treesitter_parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      treesitter_parser_config.templ = {
        install_info = {
          url = 'https://github.com/vrischmann/tree-sitter-templ.git',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'master',
        },
      }

      vim.treesitter.language.register('templ', 'templ')
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'BufReadPre',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
