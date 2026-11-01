return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
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
      -- Serve icons to plugins that expect nvim-web-devicons (diffview, bufferline, trouble)
      MiniIcons.mock_nvim_web_devicons()

      -- Color highlighting (hex, Tailwind)
      require('custom.hipatterns').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
