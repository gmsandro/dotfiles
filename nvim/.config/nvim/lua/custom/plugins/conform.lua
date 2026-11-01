return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>bf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- No LSP formatting fallback for languages without a standard style
        local no_lsp_format = { c = true, cpp = true }
        return {
          timeout_ms = 2500,
          lsp_format = no_lsp_format[vim.bo[bufnr].filetype] and 'never' or 'fallback',
        }
      end,
      -- Language files in custom/lang add their formatters here
      formatters_by_ft = {},
    },
  },
}
