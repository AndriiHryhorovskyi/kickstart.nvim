return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {
    keys = 'etovxqpdygfblzhckisuran',
    multi_windows = true,
  },
  keys = {
    {
      '<leader>f',
      mode = { 'n' },
      function()
        require('hop').hint_char1()
      end,
      desc = 'Hop [F]ind',
    },
  },
}
