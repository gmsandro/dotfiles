-- Highlight todo comments and hex colors. Tailwind classes are colored by the
-- tailwindcss LSP via Neovim's built-in document colors (:h lsp-document_color).
local M = {}

function M.setup()
  local hi = require 'mini.hipatterns'

  local function word(w, group)
    return { pattern = '%f[%w]()' .. w .. '()%f[%W]', group = group }
  end

  hi.setup {
    highlighters = {
      fix = word('FIX', 'MiniHipatternsFixme'),
      fixme = word('FIXME', 'MiniHipatternsFixme'),
      hack = word('HACK', 'MiniHipatternsHack'),
      warn = word('WARN', 'MiniHipatternsHack'),
      todo = word('TODO', 'MiniHipatternsTodo'),
      perf = word('PERF', 'MiniHipatternsTodo'),
      test = word('TEST', 'MiniHipatternsTodo'),
      note = word('NOTE', 'MiniHipatternsNote'),

      hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
      -- #rgb shorthand
      shorthand = {
        pattern = '()#%x%x%x()%f[^%x%w]',
        group = function(_, _, data)
          local r, g, b = data.full_match:sub(2, 2), data.full_match:sub(3, 3), data.full_match:sub(4, 4)
          return MiniHipatterns.compute_hex_color_group('#' .. r .. r .. g .. g .. b .. b, 'bg')
        end,
        extmark_opts = { priority = 2000 },
      },
    },
  }
end

return M
