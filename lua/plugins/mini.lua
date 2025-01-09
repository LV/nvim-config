local diff = function()
  require("mini.diff").setup({
    view = {
      style = "sign",
    },
  })
end

local files = function()
  require("mini.files").setup()
end

local icons = function()
  require("mini.icons").setup({
    style = "glyph",
  })
end

local indentscope = function()
  require("mini.indentscope").setup({
    draw = {
      delay = 0,
      animation = require("mini.indentscope").gen_animation.none(),
    },
    symbol = "│",
  })
end

local jump = function()
  require("mini.jump").setup()
end

local jump2d = function()
  require("mini.jump2d").setup({
    mappings = {
      start_jumping = "", -- remove default binding
    },
  })
end

local statusline = function()
  require("mini.statusline").setup()
end

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    diff()
    files()
    icons()
    indentscope()
    jump()
    jump2d()
    statusline()
  end,
}
