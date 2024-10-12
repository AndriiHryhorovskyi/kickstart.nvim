-- autopairs
-- https://github.com/windwp/nvim-autopairs

vim.g.AutoPairsFlyMode = 1
vim.g.AutoPairsMapBS = 0
vim.g.AutoPairsMapCh = 0
vim.g.AutoPairsMapCR = 0
vim.g.AutoPairsCenterLine = 0
vim.g.AutoPairsMapSpace = 0
vim.g.AutoPairsMultilineClose = 0
vim.g.AutoPairsShortcutBackInsert = '<C-b>'
vim.g.AutoPairsShortcutJump = '<S-Tab>'

return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
      }
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { 'jiangmiao/auto-pairs' },
}
