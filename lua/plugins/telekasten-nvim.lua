local config = function()
  require("telekasten").setup({
    home = vim.fn.expand("~/zk"), -- name of the notes directory
  })
end

return {
  "renerocksai/telekasten.nvim",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
      { "<leader>zp", "<cmd>Telekasten panel<CR>", desc = "Panel" },
  },
  config = config,
}
