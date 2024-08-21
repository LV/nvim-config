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

      { "<leader>p", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },
      { "<leader>P", "<cmd>Lazy<CR>", desc = "Open NVim Packages (LazyVim)" },

      -- Template
      { "<leader>t", group = "template" },
      { "<leader>tc", group = "cpp" },
      { "<leader>tch", "<cmd>Template cpp/header<CR>", desc = "Load C++ header template" },
      { "<leader>tcs", "<cmd>Template cpp/source()<CR>", desc = "Load C++ source template" },
      { "<leader>tcp", "<cmd>Template cpp/competitive_programming()<CR>", desc = "Load C++ competitive programming template" },

      { "<leader>w", group = "window" },
    },
  },
}

