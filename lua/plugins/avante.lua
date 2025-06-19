return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = 'gemini',
    mode = 'agentic',
    auto_suggestions_provider = 'llama4',
    cursor_applying_provider = 'llama33',
    behaviour = {
      enable_cursor_planning_mode = true,
      cursor_planning_mode = true,
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      auto_approve_tool_permissions = false,
      minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      enable_token_counting = true, -- Whether to enable token counting. Default to true.
      enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
    },
    providers = {
      gemini = {
        api_key_name = 'GOOGLE_API_API_KEY',
        model = 'gemini-2.5-flash-preview-05-20',
      },
      llama4 = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'meta-llama/llama-4-maverick-17b-128e-instruct',
        extra_request_body = {
          max_completion_tokens = 6000,
        },
      },
      llama33 = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'llama-3.3-70b-versatile',
        extra_request_body = {
          max_completion_tokens = 6000,
        },
      },
      deepseek_llama3 = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'deepseek-r1-distill-llama-70b',
        extra_request_body = {
          max_completion_tokens = 6000,
        },
      },
    },
    ---Specify the special dual_boost mode
    ---1. enabled: Whether to enable dual_boost mode. Default to false.
    ---2. first_provider: The first provider to generate response. Default to "openai".
    ---3. second_provider: The second provider to generate response. Default to "claude".
    ---4. prompt: The prompt to generate response based on the two reference outputs.
    ---5. timeout: Timeout in milliseconds. Default to 60000.
    ---How it works:
    --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
    ---Note: This is an experimental feature and may not work as expected.
    dual_boost = {
      enabled = false,
      first_provider = 'deepseek_llama3',
      second_provider = 'llama33',
      prompt = 'Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]',
      timeout = 60000, -- Timeout in milliseconds
    },
    web_search_engine = {
      provider = 'tavily', -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
      proxy = nil, -- proxy support, e.g., http://127.0.0.1:7890
    },
    windows = {
      width = 40,
    },
    hints = { enabled = false },
    mappings = {
      ask = '<leader>cca',
      edit = '<leader>cce',
      refresh = '<leader>ccr',
      focus = '<leader>ccf',
      stop = '<leader>ccS',
      select_model = '<leader>cc?', -- Select model command
      select_history = '<leader>cch', -- Select history command
      files = {
        add_current = '<leader>ccA', -- Add current buffer to selected files
        add_all_buffers = '<leader>ccB', -- Add all buffer files to selected files
      },
      toggle = {
        default = '<leader>cct',
        debug = '<leader>ccd',
        hint = '<leader>cch',
        suggestion = '<leader>ccs',
      },
    },
    -- comment it and disable Neovim MCP to use avante's built-in tools to save tokens
    -- disabled_tools = {
    --   'list_files',
    --   'search_files',
    --   'read_file',
    --   'create_file',
    --   'rename_file',
    --   'delete_file',
    --   'create_dir',
    --   'rename_dir',
    --   'delete_dir',
    --   'bash',
    -- },

    system_prompt = function()
      local hub = require('mcphub').get_hub_instance()
      return hub:get_active_servers_prompt()
    end,
    -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require('mcphub.extensions.avante').mcp_tool(),
      }
    end,
  },
  keys = {
    {
      '<leader>ccC',
      function()
        vim.cmd 'AvanteClear history'
        vim.cmd 'AvanteClear cache'
      end,
      mode = 'n',
      desc = 'clear history',
    },
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-tree/nvim-web-devicons',
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
  },
}
