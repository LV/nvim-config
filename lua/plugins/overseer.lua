local config = function()
  require("overseer").setup()
end

return {
 "stevearc/overseer.nvim",
  lazy = true,
  keys = {
    { "<leader>rr", "<cmd>OverseerRun<CR>", desc = "Run Runner" },
    { "<leader>rt", "<cmd>OverseerToggle<CR>", desc = "Toggle Runner" },
  },
  config = config,
  opts = {},
}
