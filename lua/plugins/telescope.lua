local keys = {
  { "<leader>.", "<cmd>Telescope find_files<cr>", desc = "Find All Files" },
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
        file_ignore_patterns = { "node_modules", ".venv" },
        additionalargs = function(_)
          return { "--hidden", "--no-ignore-vcs" }
        end,
        hidden = true,
        no_ignore = true,
      },
      find_files = {
        file_ignore_patterns = { "node_modules", ".venv" },
        additionalargs = function(_)
          return { "--hidden", "--no-ignore-vcs" }
        end,
        hidden = true,
        no_ignore = true,
      },
    },
    extensions = {
      "file_browser",
      "fzf",
    },
  })
  telescope.load_extension("file_browser")
  telescope.load_extension("fzf")
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = keys,
  config = config,
}
