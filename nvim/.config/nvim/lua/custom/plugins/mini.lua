return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Around/inside textobjects, e.g. va), yinq, ci'
      -- next/last variants moved off an/in, which 0.12 uses for incremental selection (:h v_an)
      require('mini.ai').setup {
        n_lines = 500,
        mappings = { around_next = 'aN', inside_next = 'iN', around_last = 'aL', inside_last = 'iL' },
      }

      -- Surroundings: saiw) add, sd' delete, sr)' replace
      require('mini.surround').setup()

      require('mini.move').setup()

      require('mini.pairs').setup()

      -- Git signs in the gutter; mini.git provides the branch for the statusline
      require('mini.git').setup()
      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = { add = '+', change = '~', delete = '_' },
        },
      }

      require('mini.icons').setup()
      -- Serve icons to plugins that expect nvim-web-devicons (bufferline, trouble)
      MiniIcons.mock_nvim_web_devicons()

      -- Todo comment and hex color highlighting
      require('custom.hipatterns').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
}
