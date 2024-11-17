return {
  -- disable dashboard
  { "nvimdev/dashboard-nvim", enabled = false },
  { "folke/persistence.nvim", enabled = false },
  { "nvim-lualine/lualine.nvim", enabled = false },
  -- { "akinsho/bufferline.nvim", enabled = false },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      cmdline = {
        view = "cmdline",
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
      },
    },
  },
}
