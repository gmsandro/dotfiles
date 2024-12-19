local M = setmetatable({}, {
  __call = function(m)
    return m.get()
  end,
})

M.spec = { 'lsp', { '.git', 'lua' }, 'cwd' }

M.detectors = {}

function M.detectors.cwd()
  return { vim.uv.cwd() }
end

function M.detectors.lsp(buf)
  local bufpath = M.bufpath(buf)
  if not bufpath then
    return {}
  end
  local roots = {}
  local clients = vim.lsp.get_active_clients { bufnr = buf }
  clients = vim.tbl_filter(function(client)
    return not vim.tbl_contains(vim.g.root_lsp_ignore or {}, client.name)
  end, clients)
  for _, client in pairs(clients) do
    local workspace = client.config.workspace_folders
    for _, ws in pairs(workspace or {}) do
      roots[#roots + 1] = vim.uri_to_fname(ws.uri)
    end
    if client.config.root_dir then
      roots[#roots + 1] = client.config.root_dir
    end
  end
  return vim.tbl_filter(function(path)
    path = vim.fn.fnamemodify(path, ':p')
    return path and bufpath:find(path, 1, true) == 1
  end, roots)
end

function M.detectors.pattern(buf, patterns)
  patterns = type(patterns) == 'string' and { patterns } or patterns
  local path = M.bufpath(buf) or vim.uv.cwd()
  local pattern = vim.fs.find(function(name)
    for _, p in ipairs(patterns) do
      if name == p then
        return true
      end
      if p:sub(1, 1) == '*' and name:find(vim.pesc(p:sub(2)) .. '$') then
        return true
      end
    end
    return false
  end, { path = path, upward = true })[1]
  return pattern and { vim.fs.dirname(pattern) } or {}
end

function M.bufpath(buf)
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ':p')
end

function M.get(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  local roots = M.detectors.lsp(buf)
  if #roots == 0 then
    roots = M.detectors.pattern(buf, M.spec[2])
  end
  if #roots == 0 then
    roots = M.detectors.cwd()
  end
  return roots[1] or vim.uv.cwd()
end

return M
