local config = function()
  require("nvim-surround").setup({})
end

return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = config,
}
