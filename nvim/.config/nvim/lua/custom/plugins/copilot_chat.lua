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
}
