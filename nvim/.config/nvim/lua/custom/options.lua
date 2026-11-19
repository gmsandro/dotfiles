vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false -- already shown in the statusline
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.smoothscroll = true -- scroll wrapped lines by screen line, not by buffer line
vim.opt.confirm = true -- ask to save instead of failing :q / :e on unsaved changes
-- Default border for floating windows without their own (LSP hover, signature
-- help, diagnostic float, blink.cmp menu/docs); matches fzf-lua's border
vim.opt.winborder = 'single'

-- Default indentation; filetypes that differ set it in after/ftplugin
-- (Python, Rust and Go use their runtime ftplugin's recommended style)
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
