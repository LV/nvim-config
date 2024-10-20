-- List of default settings:
-- https://github.com/nvim-orgmode/orgmode/blob/master/lua/orgmode/config/defaults.lua

local config = function()
  -- Setup orgmode
  require('orgmode').setup({
    org_agenda_files = '~/org/**/*',
    org_default_notes_file = '~/org/refile.org',
    org_hide_emphasis_markers = false,
    org_hide_leading_stars = false,
  })

  -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
  -- add ~org~ to ignore_install
  -- require('nvim-treesitter.configs').setup({
  --   ensure_installed = 'all',
  --   ignore_install = { 'org' },
  -- })
end

return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = config,
}
