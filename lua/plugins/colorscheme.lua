return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    style = 'storm',
    on_highlights = function(hl, colors)
      hl.LineNr = {
        -- fg = colors.yellow,
        fg = '#b2b8cf',
      }
      hl.LineNrAbove = {
        -- fg = colors.yellow,
        fg = '#b2b8cf',
      }
      hl.LineNrBelow = {
        -- fg = colors.yellow,
        fg = '#b2b8cf',
      }
      hl.Whitespace = {
        fg = '#b2b8cf',
      }

    end,
  },
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-night', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'tokyonight'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
  end,
}
