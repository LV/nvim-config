local function open_lazygit_in_oil_or_current_file()
  -- Check if the current buffer has 'oil' as its filetype
  if vim.bo.filetype == "oil" then
    local oil = require("oil")
    local path = oil.get_current_dir()  -- Get the current directory from oil.nvim
    if path then
      vim.cmd("cd " .. path)            -- Change to the directory you're browsing in oil.nvim
      vim.cmd("LazyGit")                -- Invoke lazygit in the new directory
    end
  else
    vim.cmd("LazyGitCurrentFile")       -- Default to lazygit for the current file
  end
end

return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>gg",
      open_lazygit_in_oil_or_current_file, -- Function to handle oil.nvim or fallback
      desc = "LazyGit"
    }
  }
}
