return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  -- See `:help gitsigns` to understand what the configuration keys do
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']h', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [h]unk' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[h', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [h]unk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })

        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })

        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })

        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
    opts = {
      -- "ascii"   is the graph the git CLI generates
      -- "unicode" is the graph like https://github.com/rbong/vim-flog
      graph_style = 'unicode',
      -- Disable line numbers and relative line numbers
      disable_line_numbers = false,
      mappings = {
        status = {
          ['<c-S>'] = 'StageAll',
          ['<c-s>'] = 'SplitOpen',
        },
      },
    },

    keys = {
      {
        '<leader>gs',
        function()
          require('neogit').open()
        end,
        mode = { 'n' },
        desc = '[G]it [s]tatus',
      },
      {
        '<leader>gSp',
        '<CMD>!git stash -u -q<CR><CR>',
        mode = { 'n' },
        desc = '[G]it [S]stash [p]ush',
      },
      {
        '<leader>gSP',
        '<CMD>!git stash pop -q<CR><CR>',
        mode = { 'n' },
        desc = '[G]it [S]stash [P]op',
      },
      {
        '<leader>gca',
        function()
          vim.cmd 'silent !git add -A'
          require('neogit').action('commit', 'commit', { '--verbose' })()
        end,
        mode = { 'n' },
        desc = '[G]it [c]ommit [a]ll ',
      },
      {
        '<leader>gcA',
        function()
          vim.cmd 'silent !git add -A'
          require('neogit').action('commit', 'amend', { '--verbose' })()
        end,
        mode = { 'n' },
        desc = '[G]it [c]ommit [A]mend',
      },
      {
        '<leader>gf',
        function()
          require('neogit').action('fetch', 'fetch_pushremote')()
        end,
        mode = { 'n' },
        desc = '[G]it [f]etch',
      },
      {
        '<leader>gbc',
        function()
          local reloadGroup = vim.api.nvim_create_augroup('refresh', { clear = true })
          vim.api.nvim_create_autocmd({ 'User' }, {
            pattern = 'NeogitBranchCheckout',
            group = reloadGroup,
            desc = 'Refresh current buffer after checkout branch',
            callback = function()
              vim.cmd.checkt()
              vim.api.nvim_clear_autocmds { group = reloadGroup }
            end,
          })
          require('neogit').action('branch', 'checkout_local_branch')()
        end,
        mode = { 'n' },
        desc = '[G]it [b]ranch chechout',
      },
      {
        '<leader>gp',
        function()
          require('neogit').action('pull', 'from_upstream')()
        end,
        mode = { 'n' },
        desc = '[G]it [p]ull',
      },
      {
        '<leader>gP',
        function()
          require('neogit').action('push', 'to_upstream')()
        end,
        mode = { 'n' },
        desc = '[G]it [p]ush',
      },
      {
        '<leader>gl',
        function()
          local file = vim.fn.expand '%'
          vim.cmd [[execute "normal! \<ESC>"]]
          local line_start = vim.fn.getpos("'<")[2]
          local line_end = vim.fn.getpos("'>")[2]
          require('neogit').action('log', 'log_current', { '-L' .. line_start .. ',' .. line_end .. ':' .. file })()
        end,
        desc = '[G]it [l]og for line range',
        mode = 'v',
      },
      {
        '<leader>glf',
        function()
          local file = vim.fn.expand '%'
          require('neogit').action('log', 'log_current', { '--graph', '--decorate', '--', file })()
        end,
        desc = '[G]it [l]og current [f]ile',
      },
      {
        '<leader>glb',
        function()
          require('neogit').action('log', 'log_current', { '--decorate' })()
        end,
        desc = '[G]it [l]og current [b]ranch',
      },
      {
        '<leader>glB',
        function()
          require('neogit').action('log', 'log_other', { '--decorate' })()
        end,
        desc = '[G]it [l]og a [B]ranch',
      },
      {
        '<leader>gL',
        function()
          require('neogit').action('log', 'log_all_references', { '--graph', '--decorate' })()
        end,
        desc = '[G]it [L]og all branches',
      },
    },
  },
}
