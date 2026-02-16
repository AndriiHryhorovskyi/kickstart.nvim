return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    input = {
      enabled = true,
      icon = '',
      expand = true,
      win = {
        relative = 'cursor',
        row = -3,
        col = 0,
        width = 0,
        wo = {
          winhighlight = '',
        },
      },
    },
  },
}
