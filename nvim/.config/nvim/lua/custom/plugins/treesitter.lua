return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    -- Language files in custom/lang add their parsers to `ensure_installed`
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'vimdoc',
        'bash',
        'markdown',
        'printf',
        'html',
      },
    },
    config = function(_, opts)
      require('nvim-treesitter').install(opts.ensure_installed)

      -- Start treesitter highlighting for every filetype with a parser
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('custom_treesitter', { clear = true }),
        callback = function(args)
          if vim.bo[args.buf].buftype ~= '' then
            return
          end
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        move = {
          set_jumps = true,
        },
      }

      local move = require 'nvim-treesitter-textobjects.move'

      -- ]f/[f function, ]c/[c class (start); uppercase jumps to the end.
      local objects = { f = { '@function.outer', 'function' }, c = { '@class.outer', 'class' } }
      for key, obj in pairs(objects) do
        local query, name = obj[1], obj[2]
        for _, dir in ipairs { { ']', 'next', 'Next' }, { '[', 'previous', 'Prev' } } do
          local lhs, fn, label = dir[1] .. key, dir[2], dir[3]
          vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
            -- Keep the built-in ]c/[c (jump to next/prev change) in diff mode
            if key == 'c' and vim.wo.diff then
              vim.cmd.normal { vim.v.count1 .. lhs, bang = true }
              return
            end
            move['goto_' .. fn .. '_start'](query, 'textobjects')
          end, { desc = label .. ' ' .. name .. ' start' })
          vim.keymap.set({ 'n', 'x', 'o' }, dir[1] .. key:upper(), function()
            move['goto_' .. fn .. '_end'](query, 'textobjects')
          end, { desc = label .. ' ' .. name .. ' end' })
        end
      end
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
