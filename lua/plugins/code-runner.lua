return {
  {
    'arjunmahishi/flow.nvim',
    opts = {
      output = {
        buffer = true,
        size = 80, -- possible values: "auto" (default) OR 1-100 (percentage of screen to cover)
        focused = true,
        modifiable = false,
        split_cmd = '86vsplit',
      },
      -- add/override the default command used for a perticular filetype
      -- -- the "%s" you see in the below example is interpolated by the contents of
      --     -- the file you are trying to run
      --         -- Format { <filetype> = <command> }
      filetype_cmd_map = {
        python = 'python3 <<-EOF\n%s\nEOF',
        javascript = 'node -e "%s"',
        typescript = [[ts-node --compilerOptions "{\"module\":\"commonjs\"}" -e "%s"]],
      },
      custom_cmd_dir = vim.fs.normalize '~/.local/share/nvim/custom-scripts',
    },
    keys = {
      { '<leader>cr', '<CMD>FlowRunFile<CR>', mode = 'n', desc = '[c]ode [r]un file' },
      { '<leader>cr', ':FlowRunSelected<CR>', mode = 'v', desc = '[c]ode [r]un selected' },
      { '<leader>cl', '<CMD>FlowRunLastCmd<CR>', mode = 'n', desc = '[c]ode  run [l]ast script' },
      { '<leader>cL', '<CMD>FlowLauncher<CR>', mode = 'n', desc = '[c]ode launcher' },
      { '<leader>co', '<CMD>FlowLastOutput<CR>', mode = 'n', desc = '[c]ode print last [o]utput' },
    },
  },
}
