return {
  {
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
    opts = {},
    keys = {
      {
        '<leader>cn',
        function()
          require('ts-node-action').node_action()
        end,
        mode = 'n',
        desc = '[c]ode [n]ode actions',
      },
    },
  },
}
