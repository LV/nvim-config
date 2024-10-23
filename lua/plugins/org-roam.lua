local config = function ()
  require("org-roam").setup({
    directory = "~/org",
  })
end


return {
  "chipsenkbeil/org-roam.nvim",
  event = "VeryLazy",
  tag = "0.1.0",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      tag = "0.3.4",
    },
  },
  config = config,
}
