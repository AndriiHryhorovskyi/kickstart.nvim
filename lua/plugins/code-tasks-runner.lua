local keysDoc = require 'which-key'
keysDoc.add {
  { '<leader>cT',  mode = 'n', group = '[c]ode [T]ask' },
}

return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      direction = 'right',
    },
  },
  keys = {
    {
      '<leader>cTo',
      function()
        require('overseer').toggle { enter = true }
      end,
      mode = 'n',
      desc = '[c]ode [T]ask panel [o]pen toggle',
    },
    {
      '<leader>cTl',
      function()
        require('overseer').run_template()
      end,
      mode = 'n',
      desc = '[c]ode [T]ask [l]ist',
    },
    {
      '<leader>cTn',
      '<CMD>OverseerBuild<CR>',
      mode = 'n',
      desc = '[c]ode [T]ask [n]ew',
    },
  },
}
