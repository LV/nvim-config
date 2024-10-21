-- File-specific line indentation
local function set_indentation_settings(filetype_opts)
  local group = vim.api.nvim_create_augroup("IndentationSettings", { clear = true })
  for filetype, opts in pairs(filetype_opts) do
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = filetype,
      command = string.format("setlocal %s shiftwidth=%d tabstop=%d", opts.expandtab and "expandtab" or "noexpandtab", opts.shiftwidth, opts.tabstop),
    })
  end
end

-- `expandtab`: true means spaces, false means tabs
-- `shiftwidth` must be equal to `tabstop`
set_indentation_settings({
  c = {
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
  },

  cmake = {
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
  },

  cpp = {
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
  },

  dockerfile = {
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
  },

  go = {
    expandtab = false,
    shiftwidth = 4,
    tabstop = 4,
  },

  json = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
  },

  lua = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
  },

  make = {
    expandtab = false,
    shiftwidth = 4,
    tabstop = 4,
  },

  markdown = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
  },

  nix = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
  },

  org = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
  },
})
