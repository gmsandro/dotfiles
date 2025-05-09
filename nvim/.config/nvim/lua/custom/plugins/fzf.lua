return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local root = require 'custom.root'
      local actions = require('fzf-lua').actions
      require('fzf-lua').register_ui_select()

      require('fzf-lua').setup {
        hls = { border = 'FloatBorder' },
        winopts = {
          border = 'single',
        },
        grep = {
          actions = {
            -- actions inherit from 'actions.files' and merge
            -- this action toggles between 'grep' and 'live_grep'
            ['ctrl-g'] = { actions.grep_lgrep },
            -- uncomment to enable '.gitignore' toggle for grep
            ['ctrl-r'] = { actions.toggle_ignore },
          },
        },
      }

      vim.keymap.set('n', '<leader><leader>', function()
        require('fzf-lua').files {
          cwd = root.get(),
        }
      end, { desc = 'fzf files' })

      vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, { desc = 'LSP Go to References' })
      vim.keymap.set('n', '<leader>/', function()
        require('fzf-lua').live_grep { cwd = root.get() }
      end, { desc = 'FzF Live Grep' })
      vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers, { desc = '[B]uffer' })
      vim.keymap.set('n', '<leader>fm', require('fzf-lua').manpages, { desc = '[M]anpages' })
      vim.keymap.set('n', '<leader>fC', require('fzf-lua').colorschemes, { desc = '[C]olorschemes' })
      vim.keymap.set('n', '<leader>fa', require('fzf-lua').awesome_colorschemes, { desc = '[A]wesome Colorschemes' })
      vim.keymap.set('n', '<leader>fc', function()
        require('fzf-lua').files {
          cwd = vim.fn.stdpath 'config',
        }
      end, { desc = '[C]onfig' })

      -- vim.keymap.set('n', '<leader>fg', function()
      --   require('fzf-lua').grep { cwd = root.get() }
      -- end, { desc = '[G]rep' })
      -- vim.keymap.set('n', '<leader>fd', function()
      --   require('fzf-lua').files {
      --     cwd = vim.fs.joinpath(vim.fn.stdpath 'data'),
      --   }
      -- end, { desc = '[D]ata' })
    end,
  },
}
