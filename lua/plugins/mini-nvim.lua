local icons = function()
  require("mini.icons").setup({
    style = "glyph",
  })
end

local statusline = function()
  require("mini.statusline").setup()
end

return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    icons()
    statusline()
  end,
}
