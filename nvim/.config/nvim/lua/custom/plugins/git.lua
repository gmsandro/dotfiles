return {
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Git Diffview' },
      { '<leader>gm', '<cmd>DiffviewOpen<cr>', desc = 'Open Git Merge Tool' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git File History (current)' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Git File History (all)' },
    },
  },
}
