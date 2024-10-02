return {
  {
    'barrett-ruth/http-codes.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = true,
    keys = {
      { '<leader>sH', "<CMD>lua require('http-codes').http_codes()<CR>", desc = '[s]earch [H]ttp codes description' },
    },
  },
}
