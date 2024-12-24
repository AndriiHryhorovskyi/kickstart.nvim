return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- testing framework adapters
    'nvim-neotest/neotest-jest',
  },
  opts = {
    -- Can be a list of adapters like what neotest expects,
    -- or a list of adapter names,
    -- or a table of adapter names, mapped to adapter configs.
    -- The adapter will then be automatically loaded with the config.
    adapters = {
      ['neotest-jest'] = {
        jestCommand = 'npm test --',
        jestConfigFile = 'jest.config.js',
        env = { CI = true },
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      },
    },
    -- output = { open_on_run = true },
    -- quickfix = {
    --   open = function()
    --     local hasTroubleNvim, troubleNvim = pcall(require, 'trouble')
    --     if hasTroubleNvim then
    --       troubleNvim.open { mode = 'quickfix', focus = false }
    --     else
    --       vim.cmd 'copen'
    --     end
    --   end,
    -- },
    status = { virtual_text = true },
    summary = {
      mappings = {
        expand = { '<Tab>', '<2-LeftMouse>' },
        expand_all = '<CR>',
        short = 'o',
        output = 'O',
        stop = 'x',
      },
    },
  },

  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Replace newline and tab characters with space for more compact diagnostics
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    local hasTroubleNvim, trouble = pcall(require, 'trouble')
    if hasTroubleNvim then
      opts.consumers = opts.consumers or {}
      -- Refresh and auto close trouble after running tests
      ---@type neotest.Consumer
      opts.consumers.trouble = function(client)
        client.listeners.results = function(adapter_id, results, partial)
          if partial then
            return
          end
          local tree = assert(client:get_position(nil, { adapter = adapter_id }))

          local failed = 0
          for pos_id, result in pairs(results) do
            if result.status == 'failed' and tree:get_key(pos_id) then
              failed = failed + 1
            end
          end
          vim.schedule(function()
            if trouble.is_open() then
              trouble.refresh()
              if failed == 0 then
                trouble.close()
              end
            end
          end)
          return {}
        end
      end
    end

    if opts.adapters then
      local adapters = {}
      for name, config in pairs(opts.adapters or {}) do
        if type(name) == 'number' then
          if type(config) == 'string' then
            config = require(config)
          end
          adapters[#adapters + 1] = config
        elseif config ~= false then
          local adapter = require(name)
          if type(config) == 'table' and not vim.tbl_isempty(config) then
            local meta = getmetatable(adapter)
            if adapter.setup then
              adapter.setup(config)
            elseif adapter.adapter then
              adapter.adapter(config)
              adapter = adapter.adapter
            elseif meta and meta.__call then
              adapter = adapter(config)
            else
              error('Adapter ' .. name .. ' does not support setup')
            end
          end
          adapters[#adapters + 1] = adapter
        end
      end
      opts.adapters = adapters
    end
    require('neotest').setup(opts)
  end,

  keys = {
    {
      '<leader>ctf',
      function()
        require('neotest').run.run(vim.fn.expand '%')
      end,
      desc = 'Run [t]est [f]ile',
    },
    {
      '<leader>ctF',
      function()
        require('neotest').run.run(vim.uv.cwd())
      end,
      desc = 'Run all [t]est [F]iles',
    },
    {
      '<leader>ctt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Run nearest test',
    },
    {
      '<leader>ctl',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Run last test',
    },
    {
      '<leader>ctd',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Debug nearest test',
    },
    {
      '<leader>cto',
      function()
        require('neotest').summary.toggle()
      end,
      desc = '[c]ode [t]est panel [o]pen toggle',
    },
    {
      '<leader>cts',
      function()
        require('neotest').output.open { enter = false, short = true, auto_close = true }
      end,
      desc = '[c]ode [t]est [s]how short output',
    },
    {
      '<leader>ctS',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = '[c]ode [t]est [S]how full output',
    },
    {
      '<leader>ctq',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Stop/quit Neotest',
    },
    {
      '<leader>ctw',
      function()
        require('neotest').watch.toggle(vim.fn.expand '%')
      end,
      desc = '[t]est toggle [w]atch mode',
    },
  },
}
