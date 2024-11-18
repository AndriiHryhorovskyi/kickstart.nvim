vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zK', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = 'Preview current fold' })

return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return { 'lsp', 'indent' }
    end,
  },
  -- keys = {
  --   {
  --     'zR',
  --     function()
  --       require('ufo').openAllFolds()
  --     end,
  --     desc = 'Open all folds',
  --   },
  --   {
  --     'zM',
  --     function()
  --       require('ufo').closeAllFolds()
  --     end,
  --     desc = 'Close all folds',
  --   },
  --   {
  --     'zK',
  --     function()
  --       local winid = require('ufo').peekFoldedLinesUnderCursor()
  --       if not winid then
  --         vim.lsp.buf.hover()
  --       end
  --     end,
  --     desc = 'Preview fold',
  --   },
  -- },
}
