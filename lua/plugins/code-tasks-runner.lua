return {
  'stevearc/overseer.nvim',
  opts = {
    task_list = {
      direction = 'right',
    },
  },
  keys = {
    {
      '<leader>cto',
      function()
        require('overseer').toggle { enter = true }
      end,
      mode = 'n',
      desc = '[c]ode [t]ask panel [o]pen toggle',
    },
    {
      '<leader>ctl',
      function()
        require('overseer').run_template()
      end,
      mode = 'n',
      desc = '[c]ode [t]ask [l]ist',
    },
    {
      '<leader>ctn',
      '<CMD>OverseerBuild<CR>',
      mode = 'n',
      desc = '[c]ode [t]ask [n]ew',
    },
  },
}
