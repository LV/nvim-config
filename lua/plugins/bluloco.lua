local config = function()
  vim.cmd("colorscheme bluloco")
end

return {
  'uloco/bluloco.nvim',
  lazy = false,
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = config,
}
