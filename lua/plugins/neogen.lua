local config = function()
  require("neogen").setup({
    enabled = true,
    languages = {
      cpp = {
        template = {
          annotation_convention = "doxygen"
        },
      },
    },
  })
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<Leader>dd", ":Neogen<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Leader>df", ":Neogen func<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Leader>dc", ":Neogen class<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Leader>dt", ":Neogen type<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Leader>dl", ":Neogen file<CR>", opts)
end

return {
  "danymat/neogen",
  requires = "nvim-treesitter/nvim-treesitter",
  ft = { "cpp" }, -- Load only for C++ files
  config = config,
}

