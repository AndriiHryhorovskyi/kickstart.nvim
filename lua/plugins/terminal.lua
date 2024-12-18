local function open_file_under_cursor_in_the_panel_above(with_location)
  local has_telescope, telescope = pcall(require, 'telescope.builtin')
  local filename = vim.fn.expand '<cfile>:t'
  local full_path = vim.fn.expand '<cfile>:p'
  local file_and_line = with_location and vim.fn.expand '<cWORD>' or full_path
  vim.api.nvim_command 'wincmd k'
  if vim.uv.fs_stat(full_path) then
    local line, column = file_and_line:match ':(%d+):?(%d*)'
    line = tonumber(line) or 1
    column = tonumber(column) or 1
    vim.cmd('edit ' .. full_path)
    vim.api.nvim_win_set_cursor(0, { line, column - 1 })
    vim.cmd 'norm! zz'
  elseif has_telescope then
    telescope.find_files {
      prompt_prefix = '🪿 ',
      default_text = filename,
      wrap_results = true,
      find_command = { 'rg', '--files', '--no-require-git' },
    }
  else
    error(string.format('File %s does not exist', full_path))
  end
end

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set('n', 'gf', function()
    open_file_under_cursor_in_the_panel_above()
  end, { silent = true, buffer = 0 })
  vim.keymap.set('n', 'gF', function()
    open_file_under_cursor_in_the_panel_above(true)
  end, { silent = true, buffer = 0 })
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      insert_mappings = false,
      terminal_mappings = false,
      hide_numbers = false,
    },
    keys = {
      {
        '<leader>To',
        function()
          require('toggleterm').toggle(vim.v.count)
        end,
        mode = 'n',
        desc = '[T]erminal [o]pen toggle',
      },
      {
        '<leader>TO',
        function()
          require('toggleterm').toggle_all()
        end,
        mode = 'n',
        desc = '[T]erminal [O]pen toggle all',
      },
      { '<leader>Tl', '<CMD>TermSelect<CR>', mode = 'n', desc = '[T]erminal [l]ist' },
      {
        '<leader>Ts',
        function()
          require('toggleterm').send_lines_to_terminal('visual_selection', false, { args = vim.v.count })
        end,
        mode = 'v',
        desc = '[T]erminal [s]end',
      },
    },
  },
}
