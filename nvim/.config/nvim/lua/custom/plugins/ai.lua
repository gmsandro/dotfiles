return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    keys = {
      { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
      { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
      {
        '<leader>aa',
        function()
          return require('CopilotChat').toggle()
        end,
        desc = 'Toggle (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>ax',
        function()
          return require('CopilotChat').reset()
        end,
        desc = 'Clear (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input)
          end
        end,
        desc = 'Quick Chat (CopilotChat)',
        mode = { 'n', 'v' },
      },
      {
        '<leader>am',
        function()
          require('CopilotChat').select_model()
        end,
        desc = 'Select Model (CopilotChat)',
        mode = { 'n', 'v' },
      },
      -- Show prompts actions with telescope
      -- { "<leader>ap", funciton() require('fzf-lua').pick("prompt") end, desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-chat',
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup {
        providers = {
          openrouter = {
            prepare_input = require('CopilotChat.config.providers').copilot.prepare_input,
            prepare_output = require('CopilotChat.config.providers').copilot.prepare_output,

            get_headers = function()
              local api_key = assert(os.getenv 'OPENROUTER_API_KEY', 'OPENROUTER_API_KEY env not set')
              return {
                Authorization = 'Bearer ' .. api_key,
                ['Content-Type'] = 'application/json',
              }
            end,

            get_models = function(headers)
              local response, err = require('CopilotChat.utils').curl_get('https://openrouter.ai/api/v1/models', {
                headers = headers,
                json_response = true,
              })

              if err then
                error(err)
              end

              return vim
                .iter(response.body.data)
                :map(function(model)
                  return {
                    id = model.id,
                    name = model.name,
                  }
                end)
                :totable()
            end,

            get_url = function()
              return 'https://openrouter.ai/api/v1/chat/completions'
            end,
          },
        },
        -- model = 'gemini-2.5-pro',
      }
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    'ThePrimeagen/99',
    config = function()
      local _99 = require '99'

      -- For logging that is to a file if you wish to trace through requests
      -- for reporting bugs, i would not rely on this, but instead the provided
      -- logging mechanisms within 99.  This is for more debugging purposes
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup {
        -- provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
        logger = {
          level = _99.DEBUG,
          path = '/tmp/' .. basename .. '.99.debug',
          print_on_error = true,
        },
        -- When setting this to something that is not inside the CWD tools
        -- such as claude code or opencode will have permission issues
        -- and generation will fail refer to tool documentation to resolve
        -- https://opencode.ai/docs/permissions/#external-directories
        -- https://code.claude.com/docs/en/permissions#read-and-edit
        tmp_dir = './tmp',

        --- Completions: #rules and @files in the prompt buffer
        completion = {
          -- I am going to disable these until i understand the
          -- problem better.  Inside of cursor rules there is also
          -- application rules, which means i need to apply these
          -- differently
          -- cursor_rules = "<custom path to cursor rules>"

          --- A list of folders where you have your own SKILL.md
          --- Expected format:
          --- /path/to/dir/<skill_name>/SKILL.md
          ---
          --- Example:
          --- Input Path:
          --- "scratch/custom_rules/"
          ---
          --- Output Rules:
          --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
          --- ... the other rules in that dir ...
          ---
          custom_rules = {
            'scratch/custom_rules/',
          },

          --- Configure @file completion (all fields optional, sensible defaults)
          files = {
            -- enabled = true,
            -- max_file_size = 102400,     -- bytes, skip files larger than this
            -- max_files = 5000,            -- cap on total discovered files
            -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
          },

          --- What autocomplete do you use.  We currently only
          --- support cmp right now
          source = 'blink',
        },

        --- WARNING: if you change cwd then this is likely broken
        --- ill likely fix this in a later change
        ---
        --- md_files is a list of files to look for and auto add based on the location
        --- of the originating request.  That means if you are at /foo/bar/baz.lua
        --- the system will automagically look for:
        --- /foo/bar/AGENT.md
        --- /foo/AGENT.md
        --- assuming that /foo is project root (based on cwd)
        md_files = {
          'AGENT.md',
        },
      }

      -- take extra note that i have visual selection only in v mode
      -- technically whatever your last visual selection is, will be used
      -- so i have this set to visual mode so i dont screw up and use an
      -- old visual selection
      --
      -- likely ill add a mode check and assert on required visual mode
      -- so just prepare for it now
      vim.keymap.set('v', '<leader>9v', function()
        _99.visual()
      end, { desc = 'Visual selection (99)' })

      --- if you have a request you dont want to make any changes, just cancel it
      vim.keymap.set('n', '<leader>9x', function()
        _99.stop_all_requests()
      end, { desc = 'Stop all requests (99)' })

      vim.keymap.set('n', '<leader>9s', function()
        _99.search()
      end, { desc = 'Search (99)' })

      vim.keymap.set('n', '<leader>9m', function()
        require('99.extensions.fzf_lua').select_model()
      end, { desc = 'Select model (99)' })

      vim.keymap.set('n', '<leader>9p', function()
        require('99.extensions.fzf_lua').select_provider()
      end, { desc = 'Select provider (99)' })
    end,
  },
}
