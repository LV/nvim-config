require("config/vault")
require("util/input-prompt")

local function createAtomicNote()
  local input_title = PromptInput("Atomic Note Title: ")
  if input_title and input_title ~= "" then
    vim.cmd(string.format("ObsidianNew Atomic/%s.md", input_title))
    -- Set the frontmatter
    vim.schedule(function()
      local frontmatter = string.format([[---
id: "%s"
alias:
  - %s
tags:
  - atomic-note
---
]],
        os.date("%Y%m%d%H%M%S"),  -- id
        input_title  -- alias
      )

      -- Replace entire buffer content with our new content
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(frontmatter, "\n", {}))
    end)
  end
end

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
      { "<leader>od", group = "daily" },
      { "<leader>odd", "<cmd>ObsidianDailies<CR>", desc = "See Recent Dailies" },
          -- NOTE: `<cmd>ObsidianDailies -2 1<CR>` Shows Dailies from 2 days ago until tomorrow
      { "<leader>odt", "<cmd>ObsidianToday<CR>", desc = "Open Today's Document" },
      { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find File in Vault" },
      { "<leader>og", "<cmd>ObsidianSearch<CR>", desc = "Ripgrep Vault" },
      { "<leader>on", group = "note" },
      { "<leader>onn", "<cmd>ObsidianNew<CR>", desc = "New Note" },
      { "<leader>ona", createAtomicNote, desc = "New Atomic Note" },

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

