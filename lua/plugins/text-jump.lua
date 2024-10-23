return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {
    multi_windows = true,
  },
  keys = {
    {
      '<leader>f',
      mode = { 'n', 'v', 'o' },
      function()
        require('hop').hint_char1 {}
      end,
      desc = 'Hop [f]ind',
    },
    {
      '<leader>t',
      mode = { 'n', 'v', 'o' },
      function()
        require('hop').hint_char1 { hint_offset = -1 }
      end,
      desc = 'Hop [t]ind',
    },
  },
}
