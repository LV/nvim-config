local config = function()
  require("oil").setup({
    default_file_explorer = true,
    keymaps = {
      ["<BS>"] = "actions.parent",
      ["q"] = "actions.close",
    },
    view_options = {
      show_hidden = true,
    },
  })
end

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  lazy = true,
  event = "VimEnter",
  keys = {
    { "<leader>fe", "<cmd>Oil<CR>", desc = "File Explorer" }
  },
  config = config,
}

-- TODO: Make it so that when inside of an oil.nvim buffer and you do ~<leader>fg~, you will only grep from whatever directory you are in inside of (do not start ripgrep from when ~oil.nvim~ was invoked
