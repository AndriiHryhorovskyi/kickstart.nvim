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
      'latex',
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
          ['ac'] = { query = '@class.outer', desc = 'around [c]lass' },
          ['ic'] = { query = '@class.inner', desc = 'inner [c]lass' },
          ['am'] = { query = '@function.outer', desc = 'around [m]ethod' },
          ['im'] = { query = '@function.inner', desc = 'inner [m]ethod' },
          ['af'] = { query = '@call.outer', desc = 'around [f]unction call' },
          ['if'] = { query = '@call.inner', desc = 'inner [f]unction call' },
          ['aa'] = { query = '@parameter.outer', desc = 'around [a]rguments' },
          ['ia'] = { query = '@parameter.inner', desc = 'inner arguments' },
          ['i#'] = { query = '@conditional.inner', desc = 'inner conditional block' },
          ['a#'] = { query = '@conditional.outer', desc = 'around conditional block' },
          ['i='] = { query = '@assignment.inner', desc = 'inner assignment' },
          ['a='] = { query = '@assignment.outer', desc = 'around assignment' },
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = { query = '@function.outer', desc = 'next [m]ethod start' },
          [']['] = { query = '@class.outer', desc = 'next class start' },
          [']#'] = { query = '@conditional.inner', desc = 'next conditional block start' },
          [']='] = { query = { '@assignment.rhs', '@assignment.lhs' }, desc = 'next assignment start' },
          [']a'] = { query = '@parameter.inner', desc = 'next [a]rgument start' },
          [']f'] = { query = '@call.outer', desc = 'next [f]unction call start' },
        },
        goto_next_end = {
          [']M'] = { query = '@function.outer', desc = 'next [m]ethod ending' },
          [']]'] = { query = '@class.outer', desc = 'next class ending' },
          [']A'] = { query = '@parameter.outer', desc = 'next [a]rgument ending' },
          [']F'] = { query = '@call.outer', desc = 'next [f]unction call ending' },
        },
        goto_previous_start = {
          ['[m'] = { query = '@function.outer', desc = 'previous [m]ethod start' },
          ['[['] = { query = '@class.outer', desc = 'previous class start' },
          ['[#'] = { query = '@conditional.inner', desc = 'previous conditional block start' },
          ['[a'] = { query = '@parameter.inner', desc = 'previous [a]rgument start' },
          ['[='] = { query = { '@assignment.lhs', '@assignment.rhs' }, desc = 'previous assignment start' },
          ['[f'] = { query = '@call.outer', desc = 'previous [f]unction call start' },
        },
        goto_previous_end = {
          ['[M'] = { query = '@function.outer', desc = 'previous [m]ethod ending' },
          ['[]'] = { query = '@class.outer', desc = 'previous [c]lass ending' },
          ['[A'] = { query = '@parameter.outer', desc = 'previous [a]rgument ending' },
          ['[F'] = { query = '@call.outer', desc = 'previous [f]unction call ending' },
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
