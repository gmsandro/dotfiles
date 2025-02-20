return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "vimdoc", "c", "lua", "rust",
        "bash", "markdown", "go", "bash", "luadoc", "printf",
        "tsx", "javascript", "typescript", "html", "jsdoc"
      },

      ignore_install = {},

      sync_install = false,
      auto_install = true,

      indent = { enable = true },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        disable = function(lang, buf)
          if lang == "html" then
            print("disabled")
            return true
          end

          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            vim.notify(
              "File larger than 100KB treesitter disabled for performance",
              vim.log.levels.WARN,
              { title = "Treesitter" }
            )
            return true
          end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = { "markdown" },
      },

      -- Add incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },

      -- Add textobjects configuration
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },

      -- Enable autotag
      autotag = {
        enable = true,
      },
    })

    -- Keep your templ configuration
    local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    treesitter_parser_config.templ = {
      install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
      },
    }

    vim.treesitter.language.register("templ", "templ")

    -- Add diff mode handling for textobjects
    local move = require("nvim-treesitter.textobjects.move")
    local configs = require("nvim-treesitter.configs")
    for name, fn in pairs(move) do
      if name:find("goto") == 1 then
        move[name] = function(q, ...)
          if vim.wo.diff then
            local config = configs.get_module("textobjects.move")[name]
            for key, query in pairs(config or {}) do
              if q == query and key:find("[%]%[][cC]") then
                vim.cmd("normal! " .. key)
                return
              end
            end
          end
          return fn(q, ...)
        end
      end
    end
  end
}

-- return {
--   "nvim-treesitter/nvim-treesitter",
--   build = ":TSUpdate",
--   config = function()
--     require("nvim-treesitter.configs").setup({
--       -- A list of parser names, or "all"
--       ensure_installed = {
--         "vimdoc", "javascript", "typescript", "c", "lua", "rust",
--         "jsdoc", "bash", "go"
--       },
--
--       -- Install parsers synchronously (only applied to `ensure_installed`)
--       sync_install = false,
--
--       -- Automatically install missing parsers when entering buffer
--       -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
--       auto_install = true,
--
--       indent = {
--         enable = true
--       },
--
--       highlight = {
--         -- `false` will disable the whole extension
--         enable = true,
--         disable = function(lang, buf)
--           if lang == "html" then
--             print("disabled")
--             return true
--           end
--
--           local max_filesize = 100 * 1024 -- 100 KB
--           local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--           if ok and stats and stats.size > max_filesize then
--             vim.notify(
--               "File larger than 100KB treesitter disabled for performance",
--               vim.log.levels.WARN,
--               { title = "Treesitter" }
--             )
--             return true
--           end
--         end,
--
--         -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--         -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
--         -- Using this option may slow down your editor, and you may see some duplicate highlights.
--         -- Instead of true it can also be a list of languages
--         additional_vim_regex_highlighting = { "markdown" },
--       },
--     })
--
--     local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
--     treesitter_parser_config.templ = {
--       install_info = {
--         url = "https://github.com/vrischmann/tree-sitter-templ.git",
--         files = { "src/parser.c", "src/scanner.c" },
--         branch = "master",
--       },
--     }
--
--     vim.treesitter.language.register("templ", "templ")
--   end
-- }
