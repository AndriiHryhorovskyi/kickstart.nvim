-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Creates a beautiful debugger UI
    { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },

    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        -- virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
        virt_text_pos = 'eol',
      },
    },

    -- Add your own debuggers here
    'mxsdev/nvim-dap-vscode-js',
    -- build debugger from source
    {
      'microsoft/vscode-js-debug',
      build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', function()
      -- setup dap config by VsCode launch.json file
      local vscode = require 'dap.ext.vscode'
      local json = require 'plenary.json'
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
      -- Extends dap.configurations with entries read from .vscode/launch.json
      if vim.fn.filereadable '.vscode/launch.json' then
        vscode.load_launchjs()
      end
      dap.continue()
    end, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Conditional Breakpoint' })
    vim.keymap.set('n', '<F6>', dap.terminate, { desc = 'Debug: Terminate' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        enabled = false,
      },
      layouts = {
        { elements = { 'scopes', 'stacks', 'breakpoints', 'watches' }, position = 'right', size = 0.3 },
        { elements = { 'repl' }, position = 'bottom', size = 0.3 },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle UI / last session result.' })
    vim.keymap.set({ 'n', 'v' }, '<F8>', dapui.eval, { desc = 'Debug: eval to floating window' })
    vim.keymap.set({ 'n', 'v' }, '<F9>', function()
      require('dap.ui.widgets').preview()
    end, { desc = 'Debug: eval to split window' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Debug configuring
    for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' } do
      dap.configurations[language] = {
        -- debug Node.js app
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug project',
          runtimeExecutable = 'npm',
          runtimeArgs = {
            'run',
            'start:debug',
          },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug current file',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- debug client side web application or static website
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Debug in Chrome',
          runtimeExecutable = '/usr/bin/google-chrome-stable',
          cwd = '${workspaceFolder}',
          webRoot = '${workspaceFolder}',
          userDataDir = '${workspaceFolder}/.vscode/chrome-debug-userdatadir',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = 'Enter file name or URL: ', default = 'index.html' }, function(input)
                if input == nil or input == '' then
                  return
                elseif string.match(input, '[a-z]*://[^ >,;]*') then
                  return coroutine.resume(co, input)
                else
                  return coroutine.resume(co, 'file://' .. '${workspaceFolder}/' .. input)
                end
              end)
            end)
          end,
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Debug active process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- Jest
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Jest Tests',
          -- trace = true, -- include debugger info
          runtimeExecutable = 'node',
          runtimeArgs = {
            './node_modules/jest/bin/jest.js',
            '--runInBand',
          },
          rootPath = '${workspaceFolder}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
          sourceMaps = true,
        },
      }
    end
  end,
}
