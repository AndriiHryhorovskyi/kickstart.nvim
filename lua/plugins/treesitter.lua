-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = "master",
  lazy = false,
  build = ':TSUpdate',
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
      'tsx',
      'vue',
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
