return {
  "tpope/vim-fugitive",
  lazy = true,
  cmd = { "G", "Git" },
  keys = {
    { "<leader>gbb", "<cmd>Git blame<CR>", desc = "Git Blame" },
    { "<leader>gd", "<cmd>Git diff<CR>", desc = "Git Diff" },
    -- More commands here: https://github.com/tpope/vim-fugitive
  },
}
