local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- -- Global variable to keep track of the toggle state
-- _G.copilot_suggestions_enabled = true
--
-- -- Function to toggle Copilot suggestions
-- function _G.toggle_copilot_suggestions()
--   if _G.copilot_suggestions_enabled then
--     -- Disable Copilot suggestions
--     vim.api.nvim_create_autocmd("BufEnter", {
--       pattern = "*",
--       callback = function()
--         require("copilot.client").buf_detach()
--       end,
--     })
--     print("Copilot suggestions disabled")
--   else
--     -- Enable Copilot suggestions
--     vim.api.nvim_clear_autocmds({ event = "BufEnter" })
--     print("Copilot suggestions enabled")
--   end
--   _G.copilot_suggestions_enabled = not _G.copilot_suggestions_enabled
-- end
--
-- -- Bind the toggle function to a Neovim command
-- vim.api.nvim_create_user_command("ToggleCopilot", _G.toggle_copilot_suggestions, {})
