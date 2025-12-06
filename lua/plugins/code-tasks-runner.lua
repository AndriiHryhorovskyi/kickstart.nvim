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
        require('overseer').run_task {}
      end,
      mode = 'n',
      desc = '[c]ode [T]ask [l]ist',
    },
  },
}
