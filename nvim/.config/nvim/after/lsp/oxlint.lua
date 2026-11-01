-- lspconfig only starts oxlint in projects with an oxlint config or dependency.
-- Run it in every JS/TS project instead: prefer the oxlint config's directory,
-- else the nearest package.json/.git (oxlint then uses its default rules).
return {
  workspace_required = false,
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { { '.oxlintrc.json', '.oxlintrc.jsonc', 'oxlint.config.ts' }, 'package.json', '.git' }) or vim.fn.getcwd())
  end,
}
