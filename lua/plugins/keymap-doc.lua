return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    spec = {
      { '<leader>g', mode = 'n', group = '[g]it actions' },
      { '<leader>gc', mode = 'n', group = '[g]it [c]ommit actions' },
      { '<leader>gl', mode = 'n', group = '[g]it [l]og actions' },
      { '<leader>gS', mode = 'n', group = '[g]it [S]tash actions' },
      { '<leader>gb', mode = 'n', group = '[g]it [b]ranch' },
      { '<leader>h', mode = { 'n', 'v' }, group = 'git [h]unk actions' },
      { '<leader>s', mode = 'n', group = 'Lazy [s]earch' },
      { '<leader>w', mode = 'n', group = '[w]orkspace' },
      { '<leader>T', mode = 'n', group = '[T]erminal' },
      { '<leader>c', mode = 'n', group = '[c]ode' },
      { '<leader>ct', mode = 'n', group = '[c]ode [t]test' },
      { '<leader>cT', mode = 'n', group = '[c]ode [T]ask' },
      { '<leader>cc', mode = { 'n', 'v' }, group = '[c]ode [c]ompanion' },
      { '<leader>m', mode = 'n', group = '[m]arkdown' },
      { '<leader>mt', mode = 'n', group = '[m]arkdown [t]oc ' },
      { '<leader>mc', mode = 'n', group = '[m]arkdown [c]ode ' },
    },
  },
}
