local keys = {
  { "<leader>.", "<cmd>Telescope find_files<CR>", desc = "Find All Files" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
}

local ignore_patterns = {
  "build",
  ".cache",
  "CMakeFiles",
  "_deps",
  ".DS_Store",
  ".git",
  "linux-gcc-x86",
  "node_modules",
  ".venv"
}

local config = function()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      live_grep = {
        file_ignore_patterns = ignore_patterns,
        additionalargs = function(_)
          return { "--hidden", "--no-ignore-vcs" }
        end,
        hidden = true,
        no_ignore = true,
      },
      find_files = {
        file_ignore_patterns = ignore_patterns,
        additionalargs = function(_)
          return { "--hidden", "--no-ignore-vcs" }
        end,
        hidden = true,
        no_ignore = true,
      },
    },
    extensions = {
      "fzf",
    },
  })
  telescope.load_extension("fzf")
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope", "TodoTelescope" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = keys,
  config = config,
}
