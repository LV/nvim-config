
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<leader>cn",  function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "<leader>cN",  function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    { "<leader>fd",  function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>gB",  function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gbl", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gl",  function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>nd",  function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>nh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>s",   function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>t",   function() Snacks.terminal() end, desc = "Toggle Terminal" },
  },
}
