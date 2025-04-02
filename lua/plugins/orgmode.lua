local config = function()
  require("orgmode").setup({
    org_agenda_files = "~/Vault/**/*",
    org_default_notes_file = '~/Vault/refile.org',
    mappings = { disable_all = true },
  })
end

return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = config,
}
