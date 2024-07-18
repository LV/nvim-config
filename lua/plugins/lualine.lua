local config = function()
  require("lualine").setup({
    options = {
      theme = auto,
      globalstatus = true,
    },
  })
end

return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = config,
}
