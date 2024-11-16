local keysDoc = require 'which-key'
keysDoc.add {
  { '<leader>m',  mode = 'n', group = '[m]arkdown' },
  { '<leader>mt',  mode = 'n', group = '[m]arkdown [t]oc ' },
  { '<leader>mc',  mode = 'n', group = '[m]arkdown [c]ode ' },
}

return {
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
    keys = {
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
  {
    'ChuufMaster/markdown-toc',
    ft = { 'markdown' },
    opts = {

      -- The heading level to match (i.e the number of "#"s to match to) max 6
      heading_level_to_match = -1,

      -- Set to True display a dropdown to allow you to select the heading level
      ask_for_heading_level = false,

      -- TOC default string
      -- WARN
      toc_format = '%s- [%s](<%s#%s>)',
    },
    keys = {
      { '<leader>mtc', '<cmd>GenerateTOC<cr>', mode = 'n', desc = '[m]arkdown [t]oc [c]reate' },
      { '<leader>mtd', '<cmd>DeleteTOC<cr>', mode = 'n', desc = '[m]arkdown [t]oc [d]elete' },
    },
  },
  {
    'AckslD/nvim-FeMaco.lua',
    ft = { 'markdown' },
    opts = {},
    keys = {
      { '<leader>mce', '<cmd>FeMaco<cr>', mode = 'n', desc = '[m]arkdown [c]ode [e]dit' },
    },
  },
}
