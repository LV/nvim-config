-- display popup with keybindings of command you start typing
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 --milliseconds; amount of time before which-key popup shows up after pressing <leader>
  end,
  opts = {},
}
