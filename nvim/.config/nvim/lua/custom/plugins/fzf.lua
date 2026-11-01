return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.nvim' }, -- mini.icons
    cmd = 'FzfLua',
    init = function()
      -- Load fzf-lua on the first vim.ui.select() call (e.g. code actions)
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('fzf-lua').register_ui_select()
        return vim.ui.select(...)
      end
    end,
    opts = {
      hls = { border = 'FloatBorder' },
      winopts = {
        border = 'single',
      },
    },
    keys = {
      { '<leader><leader>', '<cmd>FzfLua files<cr>', desc = 'fzf files' },
      { 'grr', '<cmd>FzfLua lsp_references<cr>', desc = 'LSP References' },
      { '<leader>/', '<cmd>FzfLua live_grep<cr>', desc = 'FzF Live Grep' },
      { '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = '[B]uffer' },
      { '<leader>fm', '<cmd>FzfLua manpages<cr>', desc = '[M]anpages' },
      {
        '<leader>xt',
        function()
          require('fzf-lua').grep { search = [[\b(TODO|FIX|FIXME|HACK|WARN|PERF|NOTE|TEST)\b]], no_esc = true }
        end,
        desc = 'Todo comments',
      },
      {
        '<leader>xT',
        function()
          require('fzf-lua').grep { search = [[\b(TODO|FIX|FIXME)\b]], no_esc = true }
        end,
        desc = 'Todo/Fix/Fixme',
      },
      {
        '<leader>fc',
        function()
          require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[C]onfig',
      },
    },
  },
}
