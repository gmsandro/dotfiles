return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    -- Language files in custom/plugins add their parsers to `ensure_installed`
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'vimdoc',
        'c',
        'bash',
        'markdown',
        'printf',
        'html',
      },
    },
    config = function(_, opts)
      require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath('data') .. '/site',
      }

      require('nvim-treesitter').install(opts.ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if vim.bo[args.buf].buftype ~= "" then
            return
          end
          pcall(vim.treesitter.start, args.buf)
        end,
      })

      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = {
      --     'c',
      --     'go',
      --     'html',
      --     'javascript',
      --     'lua',
      --     'markdown',
      --     'java',
      --     'rust',
      --     'tsx',
      --     'typescript',
      --     'vim',
      --   },
      --   callback = function()
      --     vim.treesitter.start()
      --     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      --   end,
      -- })
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

      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, ']c', function()
        move.goto_next_start('@class.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, ']a', function()
        move.goto_next_start('@parameter.inner', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
        move.goto_next_end('@function.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, ']C', function()
        move.goto_next_end('@class.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, ']A', function()
        move.goto_next_end('@parameter.inner', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, '[c', function()
        move.goto_previous_start('@class.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, '[a', function()
        move.goto_previous_start('@parameter.inner', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
        move.goto_previous_end('@function.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, '[C', function()
        move.goto_previous_end('@class.outer', 'textobjects')
      end)

      vim.keymap.set({ 'n', 'x', 'o' }, '[A', function()
        move.goto_previous_end('@parameter.inner', 'textobjects')
      end)
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
