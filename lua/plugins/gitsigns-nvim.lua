local config = function()
  require("gitsigns").setup()
end

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = config,
}
