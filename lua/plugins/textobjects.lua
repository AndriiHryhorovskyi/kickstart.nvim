return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    --     -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true
  end,
  opts = {
    move = {
      -- whether to set jumps in the jumplist
      set_jumps = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts);

    vim.keymap.set({ "x", "o" }, "ac", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end, { desc = 'around [c]lass' })

    vim.keymap.set({ "x", "o" }, "ic", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end, { desc = 'inner [c]lass' })

    vim.keymap.set({ "x", "o" }, "am", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end, { desc = 'around [m]method' })

    vim.keymap.set({ "x", "o" }, "im", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end, { desc = 'inner [m]ethod' })

    vim.keymap.set({ "x", "o" }, "af", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
    end, { desc = 'around [f]unction call' })

    vim.keymap.set({ "x", "o" }, "if", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects")
    end, { desc = 'inner [f]unction call' })

    vim.keymap.set({ "x", "o" }, "aa", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
    end, { desc = 'around [a]rguments' })

    vim.keymap.set({ "x", "o" }, "ia", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
    end, { desc = 'inner [a]rguments' })

    vim.keymap.set({ "x", "o" }, "a#", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
    end, { desc = 'around conditional block' })

    vim.keymap.set({ "x", "o" }, "i#", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
    end, { desc = 'inner conditional block' })

    vim.keymap.set({ "x", "o" }, "a=", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@assignment.outer", "textobjects")
    end, { desc = 'around assignment' })

    vim.keymap.set({ "x", "o" }, "i=", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@assignment.inner", "textobjects")
    end, { desc = 'inner assignment' })

    vim.keymap.set({ "x", "o" }, "as", function()
      require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
    end, { desc = 'around local [s]cope' })

    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end, { desc = 'next [m]ethod start' })

    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
    end, { desc = 'next [m]ethod end' })

    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end, { desc = 'previous [m]ethod start' })

    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
    end, { desc = 'previous [m]ethod end' })

    vim.keymap.set({ "n", "x", "o" }, "][", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end, { desc = 'next class start' })

    vim.keymap.set({ "n", "x", "o" }, "]]", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
    end, { desc = 'next class end' })

    vim.keymap.set({ "n", "x", "o" }, "[[", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end, { desc = 'previous class start' })

    vim.keymap.set({ "n", "x", "o" }, "[]", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
    end, { desc = 'previous class end' })

    vim.keymap.set({ "n", "x", "o" }, "]#", function()
      require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
    end, { desc = 'next conditional block start' })

    vim.keymap.set({ "n", "x", "o" }, "[#", function()
      require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
    end, { desc = 'previous conditional block start' })

    vim.keymap.set({ "n", "x", "o" }, "]s", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
    end, { desc = 'next scope' })

    vim.keymap.set({ "n", "x", "o" }, "[s", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
    end, { desc = 'previous scope' })

    vim.keymap.set({ "n", "x", "o" }, "]z", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
    end, { desc = 'next fold' })

    vim.keymap.set({ "n", "x", "o" }, "[z", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds")
    end, { desc = 'previous fold' })

    vim.keymap.set({ "n", "x", "o" }, "]=", function()
      require("nvim-treesitter-textobjects.move").goto_next_start({ '@assignment.rhs', '@assignment.lhs' }, "textobjects")
    end, { desc = 'next assignment start' })

    vim.keymap.set({ "n", "x", "o" }, "]=", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start({ '@assignment.lhs', '@assignment.rhs' },
        "textobjects")
    end, { desc = 'previous assignment start' })

    vim.keymap.set({ "n", "x", "o" }, "]a", function()
      require("nvim-treesitter-textobjects.move").goto_next_start('@parameter.inner', "textobjects")
    end, { desc = 'next [a]rgument start' })

    vim.keymap.set({ "n", "x", "o" }, "[a", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start('@parameter.inner', "textobjects")
    end, { desc = 'previous [a]rgument start' })

    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      require("nvim-treesitter-textobjects.move").goto_next_start('@call.outer', "textobjects")
    end, { desc = 'next [f]unction call' })

    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start('@call.outer', "textobjects")
    end, { desc = 'previous [f]unction call' })

    vim.keymap.set("n", "<leader>a", function()
      require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
    end, { desc = 'swap with next arg' })

    vim.keymap.set("n", "<leader>A", function()
      require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.outer"
    end, { desc = 'swap with prev arg' })
  end
}
