require("config/vault")

local config = function()
  require("pendulum").setup({
    log_file = vim.fn.expand(VaultPath .. "/Misc/nvim_usage.csv"),
  })
end

return {
  lazy = false,
  "ptdewey/pendulum-nvim",
  config = config,
}
