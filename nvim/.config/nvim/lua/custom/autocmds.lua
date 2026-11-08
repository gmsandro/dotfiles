local function augroup(name)
  return vim.api.nvim_create_augroup('custom_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup 'highlight_yank',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Show LSP progress as a single, in-place updated notification per client.
-- Not via nvim_echo: on the classic message grid every echo is appended, so
-- chatty servers (rust-analyzer's "Roots Scanned" etc.) overflow the cmdline
-- and trigger the hit-enter prompt. Snacks.notifier replaces by `id` instead.
---@type table<integer, {token: lsp.ProgressToken, msg: string, done: boolean}[]>
local lsp_progress = vim.defaulttable()
local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
vim.api.nvim_create_autocmd('LspProgress', {
  group = augroup 'lsp_progress',
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value
    if not client or type(value) ~= 'table' then
      return
    end

    -- Update (or append) the entry for this progress token
    local tasks = lsp_progress[client.id]
    for i = 1, #tasks + 1 do
      if i == #tasks + 1 or tasks[i].token == ev.data.params.token then
        tasks[i] = {
          token = ev.data.params.token,
          msg = ('[%3d%%] %s%s'):format(
            value.kind == 'end' and 100 or value.percentage or 100,
            value.title or '',
            value.message and (' **%s**'):format(value.message) or ''
          ),
          done = value.kind == 'end',
        }
        break
      end
    end

    -- Render all tasks, then drop the finished ones for the next update
    local lines = {}
    lsp_progress[client.id] = vim.tbl_filter(function(t)
      table.insert(lines, t.msg)
      return not t.done
    end, tasks)

    vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO, {
      id = 'lsp_progress.' .. client.id,
      title = client.name,
      opts = function(notif)
        notif.icon = #lsp_progress[client.id] == 0 and '✓'
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function(event)
    local buf = event.buf
    if vim.bo[buf].filetype == 'gitcommit' or vim.b[buf].custom_last_loc then
      return
    end
    vim.b[buf].custom_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q> (checkhealth already has it)
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = { 'help', 'qf' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- Make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'man_unlisted',
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Spell check in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'spell',
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
