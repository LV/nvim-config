local diff = function()
  require("mini.diff").setup({
    view = {
      style = "sign",
    },
  })
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

local starter = function()
  -- Debug mappings
  vim.opt.timeout = true
  vim.opt.timeoutlen = 0  -- Set to 0 to eliminate waiting for multi-key sequences

  require("mini.starter").setup({
    evaluate_single = true,

    items = {
      { name = "Explorer", action = "Oil", section = "Actions" },
      { name = "Find", action = "Telescope find_files", section = "Actions" },
      { name = "Grep", action = "Telescope live_grep", section = "Actions" },
      { name = "New",  action = "enew", section = "Actions" },
      { name = "Quit", action = "q", section = "Actions" },
    },
  })

  -- Add an autocommand to check mappings in starter buffer
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "starter",
    callback = function()
      -- Print all 'g' mappings in the buffer
      vim.cmd("verbose map g")

      -- Force immediate recognition of 'g' key
      vim.keymap.set('n', 'g', 'g', { buffer = true, nowait = true })
    end
  })

  if vim.fn.argc() == 0 then
    vim.cmd("enew")
    require("mini.starter").open()
  end
end

local statusline = function()
  require("mini.statusline").setup()
end

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    diff()
    icons()
    indentscope()
    jump()
    jump2d()
    starter()
    statusline()
  end,
}
