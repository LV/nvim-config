local config = function()
  require("oil").setup({
    default_file_explorer = true,
    keymaps = {
      ["<BS>"] = "actions.parent",
      ["q"] = "actions.close",
    },
  })
end

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  lazy = true,
  event = "VimEnter",
  config = config,
  keys = {
    { "<leader>fe", "<cmd>Oil<CR>", desc = "File Explorer" }
  },
}
