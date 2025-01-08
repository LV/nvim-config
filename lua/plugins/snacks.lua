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


-- CONFIGURATIONS
---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
local dashboard_config = {
  enabled = true,
  preset = {
    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" }, -- TODO: Disable the regular Vim `g` char to improve speed of this command
      { icon = " ", key = "G", desc = "Git Status", action = function() lazygit_repo_from_cwd() end},
      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
    header = [[
██╗     ██╗   ██╗
██║     ██║   ██║
██║     ╚██╗ ██╔╝
██║      ╚████╔╝ 
███████╗  ╚██╔╝  
╚══════╝   ╚═╝   
    ]]
  },
  sections = {
    { section = "header" },
    {
      pane = 2,
      section = "terminal",
      cmd = "colorscript -e square",
      height = 5,
      padding = 1,
    },
    { section = "keys", gap = 1, padding = 1 },
    {
      pane = 2,
      icon = " ",
      desc = "Browse Repo",
      padding = 1,
      key = "B",
      action = function()
        Snacks.gitbrowse()
      end,
    },
    function()
      local in_git = Snacks.git.get_root() ~= nil
      local cmds = {
        {
          title = "Notifications",
          cmd = "gh notify -s -a -n5",
          action = function()
            vim.ui.open("https://github.com/notifications")
          end,
          key = "N",
          icon = " ",
          height = 5,
          enabled = true,
        },
        {
          title = "Open Issues",
          cmd = "gh issue list -L 3",
          key = "I",
          action = function()
            vim.fn.jobstart("gh issue list --web", { detach = true })
          end,
          icon = " ",
          height = 7,
        },
        {
          icon = " ",
          title = "Open PRs",
          cmd = "gh pr list -L 3",
          key = "P",
          action = function()
            vim.fn.jobstart("gh pr list --web", { detach = true })
          end,
          height = 7,
        },
        {
          icon = " ",
          title = "Git Activity",
          cmd = "hub --no-pager diff --stat -B -M -C",
          height = 10,
        },
      }
      return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
          pane = 2,
          section = "terminal",
          enabled = in_git,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        }, cmd)
      end, cmds)
    end,
    { section = "startup" },
  },
}


return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = dashboard_config,
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
