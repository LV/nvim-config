require("config/vault")

return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  event = { "VimEnter" },  -- Load on launching
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  opts = {
    attachments = {
      -- Default folder to place images via `:ObsidianPasteImg`
      img_folder = "assets",
    },

    daily_notes = {
      folder = "Daily",
      date_format = "%Y-%m-%d",
    },

    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    disable_frontmatter = true,

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      return title
    end,

    notes_subdir = "Notes",

    workspaces = {
      {
        name = "vault",
        path = VaultPath,
      },
    },
  },
}
