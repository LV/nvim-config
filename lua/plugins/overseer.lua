local config = function()
  require("overseer").setup()
end

return {
 "stevearc/overseer.nvim",
  lazy = true,
  keys = {
    { "<leader>sr", "<cmd>OverseerRun<CR>", desc = "Run Shell" },
    { "<leader>st", "<cmd>OverseerToggle<CR>", desc = "Toggle Shells" },
  },
  config = config,
  opts = {},
}
