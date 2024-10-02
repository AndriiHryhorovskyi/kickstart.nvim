return {
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      float_diff = false,
      position = 'right',
    },
    keys = {
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>", desc = '[u]ndo tree' },
    },
  },
}
