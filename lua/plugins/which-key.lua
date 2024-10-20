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
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Search TODO" },

      { "<leader>g", group = "git" },

      { "<leader>h", "<cmd>HopWord<CR>", desc = "Open NVim Packages (LazyVim)" },

      { "<leader>o", group = "org" },

      { "<leader>p", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },
      { "<leader>P", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },

      { "<leader>r", group = "runner" },

      -- Template
      { "<leader>t", group = "template" },
      { "<leader>tc", group = "cpp" },
      { "<leader>tch", "<cmd>Template cpp/header<CR>", desc = "Load C++ header template" },
      { "<leader>tcs", "<cmd>Template cpp/source()<CR>", desc = "Load C++ source template" },
      { "<leader>tcp", "<cmd>Template cpp/competitive_programming()<CR>", desc = "Load C++ competitive programming template" },

      { "<leader>w", group = "window" },
      { "<leader>ws", "<cmd>split<CR>", desc = "Split window" },
      { "<leader>wv", "<cmd>vsplit<CR>", desc = "Split window vertically" },

      { "<leader>z", group = "zettelkasten" },
      { "<leader>zn", group = "new" },
    },
  },
}

