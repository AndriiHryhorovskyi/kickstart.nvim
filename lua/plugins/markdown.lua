return {
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    keys = {
      { '<leader>m', '<cmd><cr>', mode = 'n', desc = '[m]arkdown' },
      { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', mode = 'n', desc = '[m]arkdown [p]review toggle' },
    },
  },
}
