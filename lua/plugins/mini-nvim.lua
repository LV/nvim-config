local statusline = function()
  require("mini.statusline").setup()
end

return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    statusline()
  end,
}
