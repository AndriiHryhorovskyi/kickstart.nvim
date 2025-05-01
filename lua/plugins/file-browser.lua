return {

  -- Neo-tree is a Neovim plugin to browse the file system
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim', -- Optional image support in preview window
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['oa'] = 'avante_add_files',
          },
        },
        commands = {
          avante_add_files = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = require('avante.utils').relative_path(filepath)
            local sidebar = require('avante').get()
            local open = sidebar:is_open()
            -- ensure avante sidebar is open
            if not open then
              require('avante.api').ask()
              sidebar = require('avante').get()
            end
            sidebar.file_selector:add_selected_file(relative_path)
            -- remove neo tree buffer
            if not open then
              sidebar.file_selector:remove_selected_file 'neo-tree filesystem [1]'
            end
          end,
        },
      },
      window = { position = 'right' },
    },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local detail = false
      require('oil').setup {
        -- Window-local options to use for oil buffers
        win_options = {
          wrap = true,
        },
        -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
        skip_confirm_for_simple_edits = true,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        -- (:help prompt_save_on_select_new_entry)
        prompt_save_on_select_new_entry = false,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a [v]ertical split' },
          ['<C-s>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a [h]orizontal split' },
          ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
          ['<C-p>'] = 'actions.preview',
          ['<Esc>'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
          ['g\\'] = 'actions.toggle_trash',
          ['gd'] = {
            desc = 'Toggle file detail view',
            callback = function()
              detail = not detail
              if detail then
                require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
              else
                require('oil').set_columns { 'icon' }
              end
            end,
          },
          ['gyy'] = {
            callback = function()
              local entry = require('oil').get_cursor_entry()
              local dir = require('oil').get_current_dir()
              if not entry or not dir then
                return
              end
              local fullPath = dir .. '/' .. entry.name
              vim.fn.setreg('"', fullPath)
            end,
            desc = 'Copy file path to clipboard',
          },
        },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(name, bufnr)
            return name == '.' or name == '..'
          end,
        },
      }
    end,
    keys = {
      { '<leader>-', '<CMD>Oil<CR>', desc = '[] Open file explorer', mode = { 'n' } },
    },
  },
}
