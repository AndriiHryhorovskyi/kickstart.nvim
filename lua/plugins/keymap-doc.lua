return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    spec = {
      { '<leader>g', group = '[G]it actions' },
      { '<leader>gc', group = '[G]it [c]ommit actions' },
      { '<leader>gl', group = '[G]it [l]og actions' },
      { '<leader>gS', group = '[G]it [S]tash actions' },
      { '<leader>gb', group = '[G]it [b]ranch' },
      { '<leader>h', group = 'Git [H]unk actions' },
      { '<leader>h', group = 'Git [H]unk actions', mode = 'v' },
      { '<leader>s', group = 'Lazy [S]earch' },
      { '<leader>t', group = '[T]oggle' },
    },
  },
}
