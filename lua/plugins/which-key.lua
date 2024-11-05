-- display popup with keybindings of command you start typing
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

      { "<leader>g", group = "git" },

      { "<leader>h", "<cmd>HopWord<CR>", desc = "Open NVim Packages (LazyVim)" },

      { "<leader>o", group = "org" },

      { "<leader>p", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },
      { "<leader>P", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },

      { "<leader>r", group = "runner" },

      { "<leader>t", "<cmd>term<CR>", desc = "Terminal" },

      { "<leader>w", group = "window" },
      { "<leader>ws", "<cmd>split<CR>", desc = "Split window" },
      { "<leader>wv", "<cmd>vsplit<CR>", desc = "Split window vertically" },
    },
  },
}

