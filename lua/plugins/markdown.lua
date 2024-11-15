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
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {
      enabled = true,
      render_modes = true,
      file_types = { 'markdown' },
      debounce = 500,
      quote = { repeat_linebreak = true },
      win_options = {
        showbreak = { default = '', rendered = '  ' },
        breakindent = { default = false, rendered = true },
        breakindentopt = { default = '', rendered = '' },
      },
      code = {
        sign = false,
        width = 'block',
        min_width = 45,
      },
      heading = {
        sign = false,
      },
      latex = {
        enabled = true,
        top_pad = 0,
        bottom_pad = 0,
      },
    },
    keys = {
      { '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', mode = 'n', desc = '[m]arkdown [r]render toggle' },
    },
  },
}
