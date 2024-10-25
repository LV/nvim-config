-- Documentation on settings:
-- https://github.com/nvim-orgmode/orgmode/blob/master/DOCS.md

local config = function()
  -- Overwrite default settings
  -- https://github.com/nvim-orgmode/orgmode/blob/master/lua/orgmode/config/defaults.lua
  require('orgmode').setup({
    org_adapt_indentation = false,
    org_agenda_files = '~/org/**/*',
    org_default_notes_file = '~/org/refile.org',
    org_hide_emphasis_markers = false,
    org_hide_leading_stars = false,
    org_startup_folded = "showeverything", -- Do not collapse elements upon launching
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

-- TODO: Fix the 3rd level header indentation not showing a color (***)
