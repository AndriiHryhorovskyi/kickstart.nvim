-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = {
    ensure_installed = {
      'vim',
      'vimdoc',
      'diff',
      'markdown',
      'markdown_inline',
      'html',
      'css',
      'bash',
      'json',
      'javascript',
      'typescript',
      'lua',
      'luadoc',
      'graphql',
      'prisma',
      'dockerfile',
      'yaml',
      'xml',
      'sql',
      'regex',
      'query',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      -- additional_vim_regex_highlighting = { 'ruby' },
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = false, -- set to `false` to disable one of the mappings
        node_incremental = 'v',
        scope_incremental = false,
        node_decremental = 'V',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['am'] = '@function.outer',
          ['im'] = '@function.inner',
          ['af'] = '@call.outer',
          ['if'] = '@call.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['i#'] = '@conditional.inner',
          ['a#'] = '@conditional.outer',
          ['i='] = '@assignment.inner',
          ['a='] = '@assignment.outer',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']['] = '@class.outer',
          [']#'] = '@conditional.inner',
          [']='] = { query = { '@assignment.rhs', '@assignment.lhs' } },
          [']a'] = '@parameter.inner',
          [']f'] = '@call.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']]'] = '@class.outer',
          [']A'] = '@parameter.outer',
          [']F'] = '@call.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
          ['[#'] = '@conditional.inner',
          ['[a'] = '@parameter.inner',
          ['[='] = { query = { '@assignment.lhs', '@assignment.rhs' } },
          ['[f'] = '@call.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
          ['[A'] = '@parameter.outer',
          ['[F'] = '@call.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  end,
}
