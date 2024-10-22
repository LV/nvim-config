local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("config.globals")
require("config.indentation")
require("config.keymaps")
require("config.neovide")
require("config.options")

local plugins = "plugins"

local opts = {
  defaults = { lazy = true },
  install = { colorscheme = { "carbonfox" } },
  rtp = {
    disabled_plugins = {
      "gzip",
      "matchit",
      "matchparen",
      "netrw",
      "netrwPlugin",
      "tarPlugin",
      "tohtml",
      "tutor",
      "zipPlugin",
    }
  },
  change_detection = { notify = false },
}

require("lazy").setup(plugins, opts)
