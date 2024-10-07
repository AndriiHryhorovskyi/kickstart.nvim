-- fuzzy finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  event = 'vimenter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- if encountering errors, see telescope-fzf-native readme for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'ghassan0/telescope-glyph.nvim' },
    { 'AckslD/nvim-neoclip.lua' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'chip/telescope-software-licenses.nvim' },
    { 'benfowler/telescope-luasnip.nvim' },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        layout_strategy = 'vertical',
        mappings = {
          i = {
            ['<C-j>'] = require('telescope.actions').preview_scrolling_down,
            ['<C-k>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-s>'] = require('telescope.actions').file_split,
          },
          n = {
            ['<C-s>'] = require('telescope.actions').file_split,
          },
        },
        file_ignore_patterns = { '%.git/' },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        glyph = {
          action = function(glyph)
            -- argument glyph is a table.
            -- {name="", value="", category="", description=""}
            --
            vim.fn.setreg('"', glyph.value)
            -- insert glyph when picked
            -- vim.api.nvim_put({ glyph.value }, 'c', false, true)
          end,
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'glyph')
    pcall(require('telescope').load_extension, 'live_grep_args')
    pcall(require('telescope').load_extension, 'software-licenses')
    pcall(require('telescope').load_extension, 'luasnip')

    require('neoclip').setup()

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files { hidden = true }
    end, { desc = '[s]earch [f]iles' })
    vim.keymap.set('n', '<leader>sp', builtin.builtin, { desc = '[s]earch telescope [p]icker' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [w]ord' })
    vim.keymap.set('n', '<leader>sg', function()
      require('telescope').extensions.live_grep_args.live_grep_args()
    end, { desc = '[s]earch by [g]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[s]earch existing [b]uffers' })
    vim.keymap.set('n', '<leader>se', '<cmd>Telescope glyph<CR>', { desc = '[s]earch [e]moji' })
    vim.keymap.set('n', '<leader>sy', '<cmd>Telescope neoclip<CR>', { desc = '[s]earch [y]yanked text' })
    vim.keymap.set('n', '<leader>sl', '<cmd>Telescope software-licenses find<CR>', { desc = '[s]earch software [l]licenses' })
    vim.keymap.set('n', '<leader>ss', '<cmd>Telescope luasnip<CR>', { desc = '[s]earch [s]nippet' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[s]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[s]earch [n]eovim config files' })
  end,
}
