return {
  {
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh install.sh',
    opts = {
      display = {
        'Terminal',
      },
      display_options = {
        terminal_position = 'vertical', --# or "horizontal", to open as horizontal split instead of vertical split
        terminal_width = 45, --# change the terminal display option width (if vertical)
        terminal_height = 20, --# change the terminal display option height (if horizontal)
        terminal_scrollback = 0,
      },
      show_no_output = {
        'Classic',
      },
      live_mode_toggle = 'off',
      ansi_escape = true, --# Remove ANSI escapes (usually color) from outputs
      inline_messages = false, --# boolean toggle for a one-line way to display output
      --# to workaround sniprun not being able to display anything
    },
    keys = {
      { '<leader>cr', '<CMD>%SnipRun<CR>', mode = 'n', desc = '[c]ode [r]un file' },
      {
        '<leader>cr',
        function()
          require('sniprun').run 'v'
        end,
        mode = 'v',
        desc = '[c]ode [r]un selected',
      },
    },
  },
}
