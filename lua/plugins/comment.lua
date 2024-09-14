return { -- Use `opts = {}` to force a plugin to be loaded.
  -- Examples:
  --  - gcc  - Toggles the current line using linewise comment
  --  - gc{motion} - Toggles the region using linewise comment
  --  - gbc  - Toggles the current line using blockwise comment
  --  - gb{motion}  - Toggles the region using blockwise comment
  --  - gco  - Insert comment to the next line and enters INSERT mode
  --  - gcO  - Insert comment to the previous line and enters INSERT mode
  --  - gcA  - Insert comment to end of the current line and enters INSERT mode
  { 'numToStr/Comment.nvim', opts = {} },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
      { '<leader>td', '<cmd>TodoLocList<cr>', desc = '[T]o [D]o list', mode = { 'n' } },
      { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[S]earch [T]odo', mode = { 'n' } },
    },
  },
}
