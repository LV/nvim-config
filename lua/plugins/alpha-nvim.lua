local config = function()
  local startify = require("alpha.themes.startify")

  -- Set your custom header
  startify.section.header.val = {
    "  ██╗     ██╗   ██╗ ",
    "  ██║     ██║   ██║ ",
    "  ██║     ╚██╗ ██╔╝ ",
    "  ██║      ╚████╔╝  ",
    "  ███████╗  ╚██╔╝   ",
    "  ╚══════╝   ╚═╝    ",
  }

  -- Set file icons provider
  startify.file_icons.provider = "devicons"

  -- Send config to alpha
  require("alpha").setup(startify.config)

  -- Disable folding on alpha buffer
  vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
  ]])
end

return {
  "goolord/alpha-nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = { "VimEnter" },
  config = config,
}

