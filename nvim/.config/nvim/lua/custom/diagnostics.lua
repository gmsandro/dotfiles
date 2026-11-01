vim.diagnostic.config {
  severity_sort = true,
  -- Message at the end of the cursor line only; <leader>uv toggles it
  virtual_text = { current_line = true },
  -- Open the float after every jump, including the default ]d/[d
  jump = {
    on_jump = function(diagnostic, bufnr)
      if diagnostic then
        vim.diagnostic.open_float { bufnr = bufnr, scope = 'cursor', focus = false }
      end
    end,
  },
}
