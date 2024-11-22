return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    priority = { 'lsp', 'markdown' },
    outline_window = {
      auto_close = true,
      auto_jump = false,
      show_numbers = true,
      show_relative_numbers = true,
      wrap = true,
    },
    preview_window = {
      auto_preview = false,
      open_hover_on_preview = false,
    },
    keymaps = {
      up_and_jump = '<C-p>',
      down_and_jump = '<C-n>',
    },
  },
}
