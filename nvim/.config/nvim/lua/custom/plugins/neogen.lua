return {
  {
    'danymat/neogen',
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    cmd = 'Neogen',
    keys = {
      {
        '<leader>cn',
        function()
          require('neogen').generate()
        end,
        desc = 'Generate Annotations (Neogen)',
      },
    },
  },
}
