require("config/vault")
require("util/which-key")

return {
  "folke/which-key.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  event = "VeryLazy",
  opts = {
    spec = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },

      { ".", "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>", desc = "Hop to Char" },

      { "<leader>c", group = "code" },

      { "<leader>f", group = "file" },
      { "<leader>fc", group = "config" },
      { "<leader>fcv",
        function()
          require("oil").open("~/.config/nvim")
        end,
        desc = "Open Neovim Config" },
      { "<leader>fcx",
        function()
          require("oil").open("~/nixos")
        end,
        desc = "Open Nixos Config" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Search TODO" },
      { "<leader>fv",
        function()
          require("oil").open(VaultPath)
        end,
        desc = "Open Vault" },

      { "<leader>g", group = "git" },
      { "<leader>gb", group = "blame" },

      { "<leader>n", group = "notifications" },

      { "<leader>o", group = "org" },
      { "<leader>od", group = "daily" },
      { "<leader>odd", "<cmd>ObsidianDailies<CR>", desc = "See Recent Dailies" },
          -- `<cmd>ObsidianDailies -2 1<CR>` Shows Dailies from 2 days ago until tomorrow
      { "<leader>odt", "<cmd>ObsidianToday<CR>", desc = "Open Today's Document" },
      { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find File in Vault" },
      { "<leader>og", "<cmd>ObsidianSearch<CR>", desc = "Ripgrep Vault" },
      { "<leader>on", group = "note" },
      { "<leader>ona", CreateAtomicNote, desc = "New Atomic Note" },
      { "<leader>onf", CreateFleetingNote, desc = "New Fleeting Note" },
      { "<leader>onn", CreateNote, desc = "New Note" },

      { "<leader>p", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },
      { "<leader>P", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },

      { "<leader>r", group = "runner" },

      { "<leader>w", group = "window" },
      { "<leader>ws", "<cmd>split<CR>", desc = "Split Window Horizontally" },
      { "<leader>wv", "<cmd>vsplit<CR>", desc = "Split Window Vertically" },
    },
  },
}

