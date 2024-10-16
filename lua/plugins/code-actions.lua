return {
  {
    'ckolkey/ts-node-action',
    dependencies = { 'nvim-treesitter' },
    opts = {},
    keys = {
      {
        '<leader>cn',
        function()
          require('ts-node-action').node_action()
        end,
        mode = 'n',
        desc = '[c]ode [n]ode actions',
      },
    },
  },

  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'json',
    opts = {
      hide_up_to_date = true, -- It hides up to date versions when displaying virtual text
      hide_unstable_versions = false, -- It hides unstable versions from version list e.g next-11.1.3-canary3
      -- Can be `npm`, `yarn`, or `pnpm`. Used for `delete`, `install` etc...
      -- The plugin will try to auto-detect the package manager based on
      -- `yarn.lock` or `package-lock.json`. If none are found it will use the
      -- provided one, if nothing is provided it will use `yarn`
      package_manager = 'npm',
    },
    config = function(_, opts)
      require('package-info').setup(opts)
      local colors = require('tokyonight.colors').setup()
      vim.cmd([[highlight PackageInfoUpToDateVersion guifg=]] .. colors.hint)
      vim.cmd([[highlight PackageInfoOutdatedVersion guifg=]] .. colors.warning)
    end,
    keys = {
      { '<leader>cp', '<cmd><cr>', desc = '[c]ode [p]ackage' },
      {
        '<leader>cps',
        function()
          require('package-info').toggle()
        end,
        desc = '[c]ode [p]ackage [s]how version toggle',
        silent = true,
        noremap = true,
      },
      {
        '<leader>cpu',
        function()
          require('package-info').update()
        end,
        desc = '[c]ode [p]ackage [u]pdate',
        silent = true,
        noremap = true,
      },
      {
        '<leader>cpd',
        function()
          require('package-info').delete()
        end,
        desc = '[c]ode [p]ackage [d]elete',
        silent = true,
        noremap = true,
      },
      {
        '<leader>cpi',
        function()
          require('package-info').install()
        end,
        desc = '[c]ode [p]ackage [i]nstall',
        silent = true,
        noremap = true,
      },
      {
        '<leader>cpv',
        function()
          require('package-info').change_version()
        end,
        desc = '[c]ode [p]ackage [v]ersions',
        silent = true,
        noremap = true,
      },
    },
  },
}
