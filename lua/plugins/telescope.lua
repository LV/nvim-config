-- Patterns to ignore when searching
local ignore_patterns = {
  ".cache",
  ".config/emacs/elpa",
  ".config/emacs/emojis",
  "_deps",
  ".DS_Store",
  ".git",
  ".local",
  ".npm",
  ".venv",
  "build",
  "CMakeFiles",
  "linux-gcc-x86",
  "node_modules",
}

---@return nil
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
  config = config,
}
