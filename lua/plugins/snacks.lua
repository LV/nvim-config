-- HELPER FUNCTIONS
local lazygit_repo_from_cwd = function()
  -- When opening lazygit, open repo in the directory of the current buffer.
  -- Rather than opening repo from directory where `nvim` was first invoked.
  local cwd
  if vim.bo.filetype == "oil" then
    local oil = require("oil")
    cwd = oil.get_current_dir()
  else
    cwd = vim.fn.expand("%:p:h")
  end

  if cwd and vim.fn.isdirectory(cwd) == 1 then
    -- Change directory to `cwd` before invoking Snacks.lazygit
    vim.cmd("cd " .. cwd)
    Snacks.lazygit()
  else
    vim.notify("Invalid directory for lazygit", vim.log.levels.ERROR)
  end
end

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
    { "<leader>gg",  function() lazygit_repo_from_cwd() end, desc = "LazyGit" },
    { "<leader>gl",  function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>nd",  function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>nh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>s",   function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>t",   function() Snacks.terminal() end, desc = "Toggle Terminal" },
  },
}
